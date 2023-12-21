package kr.pe.eta.web.callreq;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.websocket.Session;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Like;
import kr.pe.eta.redis.AddCallEntity;
import kr.pe.eta.redis.RedisEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.redis.RedisService.DatabaseHasNoDataException;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.pay.PayService;
import kr.pe.eta.service.user.UserService;

//==>  Call Req Controller
@Controller
@RequestMapping("/callreq/*")
public class CallReqController {

	@Autowired
	private CallReqService callReqService;

	@Autowired
	private PayService payService;

	@Autowired
	private UserService userService;

	@Autowired
	private final RedisService redisService;

	public CallReqController(RedisService redisService) {
		this.redisService = redisService; // 여기 추가
		System.out.println(this.getClass());
	}

	private static final List<Session> session = new ArrayList<Session>();

	@GetMapping("/callreq")
	public String index() {
		return "redirect:callreq/home.jsp";
	}

	@RequestMapping(value = "inputAddress", method = RequestMethod.GET)
	public String inputAddress(@RequestParam("userNo") int userNo, @RequestParam("callCode") String callCode,
			Model model) throws Exception {

		System.out.println("/callreq/inputAddress");
		System.out.println("userNo : " + userNo);
		System.out.println("callCode : " + callCode);

		// Business Logic
		List<Call> endAddrList = callReqService.getEndAddrList(userNo); // 도착지 키워드, 주소 리스트
		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("endAddrList", endAddrList);
		model.addAttribute("likeList", likeList);
		model.addAttribute("callCode", callCode);

		return "forward:/callreq/inputAddress.jsp";
	}

	@RequestMapping(value = "inputAddressMap", method = RequestMethod.GET)
	public String inputAddressMap(@RequestParam("userNo") int userNo, @RequestParam("callCode") String callCode,
			Model model) throws Exception {

		System.out.println("/callreq/inputAddressMap");
		System.out.println("userNo : " + userNo);

		model.addAttribute("callCode", callCode);

		return "forward:/callreq/inputAddressMap.jsp";
	}

	@RequestMapping(value = "selectOptions", method = RequestMethod.GET)
	public String selectOptions(@RequestParam("userNo") int userNo, @RequestParam("callCode") String callCode,
			Model model) throws Exception {

		System.out.println("/callreq/selectOptions");
		System.out.println("userNo : " + userNo);

		int myMoney = payService.getMyMoney(userNo);

		model.addAttribute("myMoney", myMoney);
		model.addAttribute("callCode", callCode);

		return "forward:/callreq/selectOptions.jsp";
	}

	@RequestMapping(value = "addCall", method = RequestMethod.POST)
	public String addCall(@ModelAttribute("call") Call call, Model model) throws Exception {

		System.out.println("/callreq/addCall");

		System.out.println("call : " + call);

		double passengerX = call.getStartX();
		double passengerY = call.getStartY();
		double driverX = 0;
		double driverY = 0;

		List<RedisEntity> driverList = null;
		try {
			driverList = redisService.getAllUser();
			callReqService.addCall(call); // addCall()
		} catch (DatabaseHasNoDataException ex) {
			String errorMessage = ex.getMessage();
			System.out.print(errorMessage);

			int userNo = call.getUserNo();
			String callCode = call.getCallCode();
			int myMoney = payService.getMyMoney(userNo);

			model.addAttribute("myMoney", myMoney);
			model.addAttribute("callCode", callCode);
			model.addAttribute("hasNoDataException", true);

			return "forward:/callreq/selectOptions.jsp";

		}
		List<String> driverNoList = new ArrayList<>();
		List<Integer> callDriverNoList = new ArrayList<>();
		List<Integer> driverNoResult = new ArrayList<>();

		for (int i = 0; i < driverList.size(); i++) {
			System.out.println("redis 전체 driverList : " + driverList.get(i).getId());
		}
		for (int i = 0; i < driverList.size(); i++) {
			driverX = driverList.get(i).getCurrentX();
			driverY = driverList.get(i).getCurrentY();

			double distance = userService.haversineDistance(passengerX, passengerY, driverY, driverX);

			if (distance <= 3) { // passenger의 출발 위치로부터 3km 이내의 driver List
				String driverNo = driverList.get(i).getId();
				System.out.println("3km 이내의 driverList: " + driverNo);
				driverNoList.add(driverNo);
			}
		}

		boolean petOpt = call.isPetOpt();
		System.out.println("petOpt : " + petOpt);

		String carOpt = call.getCarOpt();
		System.out.println("carOpt : " + carOpt);

		for (int i = 0; i < driverNoList.size(); i++) {
			int driverNo = Integer.parseInt(driverNoList.get(i));
			Integer callDriverNo = callReqService.getCallDriver(carOpt, petOpt, driverNo);
			if (callDriverNo != null) {
				System.out.println("반려동물, 차량옵션에 맞는 driver : " + callDriverNo);
				callDriverNoList.add(callDriverNo);
			}
		}

		int callNo = callReqService.getCallNo(); // getCallNo()
		int passengerNo = call.getUserNo();
		List<Integer> blackNo = callReqService.getBlackList(passengerNo);
		if (blackNo != null && !blackNo.isEmpty()) {
			System.out.println("blackList 있음");
			System.out.println("blackNo : " + blackNo);
			for (int i = 0; i < callDriverNoList.size(); i++) {

				for (int j = 0; j < blackNo.size(); j++) {
					if (callDriverNoList.get(i).equals(blackNo.get(j))) {
						System.out.println("blackList driver : " + callDriverNoList.get(i));
					} else {
						System.out.println("blackList 가 아닌 driver : " + callDriverNoList.get(i));
						driverNoResult.add(callDriverNoList.get(i));
						String driverNo = String.valueOf(callDriverNoList.get(i));
						AddCallEntity addCallEntity = new AddCallEntity();
						addCallEntity.setId(driverNo);
						addCallEntity.setCallNo(callNo);
						redisService.addCall(addCallEntity);
					}
				}
			}
		} else {
			System.out.println("blackList 없음");
			for (int i = 0; i < callDriverNoList.size(); i++) {
				driverNoResult.add(callDriverNoList.get(i));
				String driverNo = String.valueOf(callDriverNoList.get(i));
				AddCallEntity addCallEntity = new AddCallEntity();
				addCallEntity.setId(driverNo);
				addCallEntity.setCallNo(callNo);
				redisService.addCall(addCallEntity);
			}
		}

		System.out.println("driverNoResult : " + driverNoResult);
		System.out.println("callNo : " + callNo);
		model.addAttribute("call", call);
		model.addAttribute("callNo", callNo);
		model.addAttribute("driverNoResult", driverNoResult);

		return "forward:/callreq/searchCall.jsp";
	}

	@RequestMapping(value = "deleteCall", method = RequestMethod.GET)
	public String deleteCall(@RequestParam("callNo") int callNo,
			@RequestParam("driverNoResult") List<String> driverNoResult, Model model) throws Exception {

		System.out.println("/callreq/deleteCall");

		System.out.println("callNo : " + callNo);
		Call call = callReqService.getCall(callNo);
		int userNo = call.getUserNo();
		String callCode = call.getCallCode();
		System.out.println("userNo : " + userNo);
		System.out.println("callCode : " + callCode);

		callReqService.deleteCall(callNo);

		for (int i = 0; i < driverNoResult.size(); i++) {
			String driverNo = driverNoResult.get(i).replaceAll("[\\[\\]]", "");
			System.out.println("driverNo : " + driverNo);
			AddCallEntity addCallEntity = new AddCallEntity();
			addCallEntity.setId(driverNo);
			addCallEntity.setCallNo(callNo);
			redisService.deleteCall(addCallEntity);
		}

		return "redirect:/callreq/selectOptions?userNo=" + userNo + "&callCode=" + callCode;
	}

	@RequestMapping(value = "likeAddress", method = RequestMethod.GET)
	public String likeAddress(@RequestParam("userNo") int userNo, Model model) throws Exception {

		System.out.println("/callreq/likeAddress");
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/likeAddrList.jsp";
	}

	@RequestMapping(value = "updateLikeAddr", method = RequestMethod.POST)
	// public String updateLikeAddr(@ModelAttribute @Valid Like like, BindingResult
	// result,
	// @RequestParam("userNo") int userNo, Model model) throws Exception {
	public String updateLikeAddr(@ModelAttribute @Valid Like like, @RequestParam("userNo") int userNo, Model model)
			throws Exception {

		System.out.println("/callreq/updateHomeAddr");
		System.out.println("like : " + like);
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		String likeAddr = like.getLikeAddr();
		String likeName = like.getLikeName();
		int likeNo = like.getLikeNo();
		double likeX = like.getLikeX();
		double likeY = like.getLikeY();

		callReqService.updateLikeAddr(likeAddr, likeName, userNo, likeNo, likeX, likeY);

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/likeAddrList.jsp";
	}

	@RequestMapping(value = "deleteLikeAddr", method = RequestMethod.GET)
	public String deleteLikeAddr(@RequestParam("likeNo") int likeNo, @RequestParam("userNo") int userNo,
			HttpSession session, Model model) throws Exception {

		System.out.println("/callreq/deleteLikeAddr");
		System.out.println("likeNo : " + likeNo);
		System.out.println("userNo : " + userNo);
		// Business Logic

		callReqService.deleteLikeAddr(likeNo, userNo);

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		if (likeNo == 1000) {
			session.removeAttribute("home");
		} else if (likeNo == 1001) {
			session.removeAttribute("company");
		} else if (likeNo == 1002) {
			session.removeAttribute("custom");
		}

		return "redirect:/callreq/likeAddress?userNo=" + userNo;
	}

	@RequestMapping(value = "deleteCustomName", method = RequestMethod.POST)
	public String deleteCustomName(@ModelAttribute("like") Like like, @RequestParam("userNo") int userNo, Model model)
			throws Exception {

		System.out.println("/callreq/deleteCustomName");
		System.out.println("like : " + like);
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		callReqService.deleteCustomName(userNo);

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/likeAddrList.jsp";
	}

}