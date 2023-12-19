package kr.pe.eta.web.community;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.RedisEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.community.CommunityService;
import kr.pe.eta.service.feedback.FeedbackService;
import kr.pe.eta.service.pay.PayService;
import kr.pe.eta.service.user.UserService;

@Controller
@RequestMapping("/community/*")
public class CommunityController {

	@Autowired
	private CommunityService communityService;

	@Autowired
	private CallReqService callReqService;

	@Autowired
	private PayService payService;

	@Autowired
	private UserService userService;

	@Autowired
	private FeedbackService feedbackService;

	@Autowired
	private final RedisService redisService;

	public CommunityController(RedisService redisService) {
		this.redisService = redisService; // 여기 추가
		System.out.println(this.getClass());
	}

	@Value("${search.pageUnit}")
	int pageUnit;
	@Value("${search.pageSize}")
	int pageSize;

	////////// 예약

	@RequestMapping(value = "addReservation", method = RequestMethod.POST)
	public String addReservation(@ModelAttribute("call") Call call, Model model) throws Exception {

		System.out.println("/addReservation POST");

		model.addAttribute("call", call);

		return "/community/addReservation.jsp";
	}

	@RequestMapping(value = "addReservationReq", method = RequestMethod.POST)
	public String addReservationReq(@ModelAttribute("call") Call call, HttpSession session, Model model)
			throws Exception {

		System.out.println("/addReservationReq POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		call.setUserNo(userNo);
		communityService.addReservation(call);

		int callNo = communityService.getCallNo(userNo, call.getCallCode());

		List<Integer> driverNoResult = getDriverList(call, userNo);

		model.addAttribute("call", call);
		model.addAttribute("callNo", callNo);
		model.addAttribute("callDriverList", driverNoResult);

		return "forward:/callreq/searchCall.jsp";
	}

	public List<Integer> getDriverList(Call call, int userNo) throws Exception {

		double passengerX = call.getStartX();
		double passengerY = call.getStartY();
		double driverX = 0;
		double driverY = 0;

		List<RedisEntity> driverList = redisService.getAllUser();

		List<String> driverNoList = new ArrayList<>();
		List<Integer> callDriverNoList = new ArrayList<>();
		List<Integer> driverNoResult = new ArrayList<>();

		for (int i = 0; i < driverList.size(); i++) {
			driverX = driverList.get(i).getCurrentX();
			driverY = driverList.get(i).getCurrentY();

			double distance = userService.haversineDistance(passengerX, passengerY, driverX, driverY);

			if (distance <= 3) { // passenger의 출발 위치로부터 3km 이내의 driver List
				String driverNo = driverList.get(i).getId();
				driverNoList.add(driverNo);
			}
		}

		boolean petOpt = call.isPetOpt();
		String carOpt = call.getCarOpt();

		for (int i = 0; i < driverNoList.size(); i++) {
			int driverNo = Integer.parseInt(driverNoList.get(i));
			Integer callDriverNo = callReqService.getCallDriver(carOpt, petOpt, driverNo);
			if (callDriverNo != null) {
				callDriverNoList.add(callDriverNo);
			}
		}

		List<Integer> blackNo = callReqService.getBlackList(userNo);

		for (int i = 0; i < callDriverNoList.size(); i++) {
			for (int j = 0; j < blackNo.size(); j++) {
				if (callDriverNoList.get(i).equals(blackNo.get(j))) {
					System.out.println("blackList driver : " + callDriverNoList.get(i));
				} else {
					driverNoResult.add(callDriverNoList.get(i));
				}
			}
		}

		return driverNoResult;
	}

	/////////// 딜

	@RequestMapping(value = "addDeal", method = RequestMethod.POST)
	public String addDeal(@ModelAttribute("call") Call call, HttpSession session, Model model) throws Exception {

		System.out.println("/addDeal POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		call.setUserNo(userNo);
		callReqService.addCall(call);
		int callNo = communityService.getCallNo(userNo, call.getCallCode());
		int money = call.getRealPay();
		model.addAttribute("callNo", callNo);
		model.addAttribute("money", money);

		return "/community/addDeal.jsp";
	}

	@RequestMapping(value = "addDealReq", method = RequestMethod.POST)
	public String addDealReq(@ModelAttribute("dealReq") DealReq dealReq, HttpSession session) throws Exception {

		System.out.println("/addDealReq POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		dealReq.setUserNo(userNo);
		communityService.addDealReq(dealReq);
		communityService.updateDealCode(userNo);
		User user = userService.getUser(((User) session.getAttribute("user")).getEmail());
		session.setAttribute("user", user);

		return "redirect:/community/getDealReq";
	}

	@RequestMapping(value = "getDealReq", method = RequestMethod.GET)
	public String getDealReq(HttpSession session, Model model) throws Exception {

		System.out.println("/getDealReq GET");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		DealReq dealReq = communityService.getDeal(userNo);
		Call call = communityService.getCall(dealReq.getCallNo());
		List<DealReq> list = communityService.getDealDriverList(dealReq.getCallNo());
		List<DealReq> driverList = new ArrayList<>();

		for (int i = 0; i < list.size(); i++) {
			DealReq listItem = list.get(i);
			int driverNo = list.get(i).getUserNo();
			User driver = userService.getUsers(driverNo);
			double starAvg = feedbackService.avgStar(driver);
			listItem.setStarAvg(starAvg);
			driverList.add(listItem);
		}

		model.addAttribute("call", call);
		model.addAttribute("dealReq", dealReq);
		model.addAttribute("driverList", driverList);

		return "/community/getDeal.jsp";
	}

	@RequestMapping(value = "deleteDealReq", method = RequestMethod.GET)
	public String deleteDealReq(@RequestParam int callNo, HttpSession session) throws Exception {

		System.out.println("/deleteDealReq GET");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		communityService.deleteDealReq(callNo);
		communityService.updateDealCode(userNo);
		callReqService.deleteCall(callNo);

		return "redirect:/home.jsp";
	}

	@RequestMapping(value = "getDealList")
	public String getDealList(HttpSession session, Model model) throws Exception {

		System.out.println("/getDealList");

		Map<String, Object> map = communityService.getDealList();

		int callNo = 0;
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		if (((User) session.getAttribute("user")).isDealCode()) {
			callNo = communityService.getDealNo(userNo, "D");
		}

		model.addAttribute("dealList", map.get("dealList"));
		model.addAttribute("callList", map.get("callList"));
		model.addAttribute("callNo", callNo);

		return "/community/listDeal.jsp";
	}

	@RequestMapping(value = "addShare", method = RequestMethod.POST)
	public String addShare(@ModelAttribute("call") Call call, HttpSession session, Model model) throws Exception {

		System.out.println("/addShare POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		call.setUserNo(userNo);
		callReqService.addCall(call);
		int callNo = communityService.getCallNo(userNo, call.getCallCode());

		int maxShareCount = 4;
		if (call.getCarOpt().equals("중형")) {
			maxShareCount = 6;
		} else if (call.getCarOpt().equals("대형")) {
			maxShareCount = 7;
		}

		model.addAttribute("callNo", callNo);
		model.addAttribute("maxShareCount", maxShareCount);

		return "/community/addShare.jsp";
	}

	@RequestMapping(value = "addShareReq", method = RequestMethod.POST)
	public String addShareReq(@ModelAttribute("shareReq") ShareReq shareReq, HttpSession session) throws Exception {

		System.out.println("/addShareReq POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		shareReq.setFirstSharePassengerNo(userNo);
		communityService.addShareReq(shareReq);
		communityService.updateShareCode(userNo);
		User user = userService.getUser(((User) session.getAttribute("user")).getEmail());
		session.setAttribute("user", user);

		return "redirect:/community/getShareList";
	}

	@RequestMapping(value = "getShareList")
	public String getShareList(@ModelAttribute("search") Search search, Model model) throws Exception {

		System.out.println("/getShareList");

		System.out.println(search);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = communityService.getShareList(search);
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		List<ShareReq> list = (List<ShareReq>) map.get("shareList");
		List<ShareReq> shareList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			ShareReq listItem = list.get(i);
			int callNo = list.get(i).getCallNo();
			int total = communityService.getShareCount(callNo);
			listItem.setFirstShareCount(total);
			shareList.add(listItem);
		}

		model.addAttribute("shareList", shareList);
		model.addAttribute("callList", map.get("callList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "/community/listShare.jsp";
	}

	@RequestMapping(value = "deleteShareReq", method = RequestMethod.GET)
	public String deleteShareReq(HttpSession session, Model model) throws Exception {

		System.out.println("/deleteShareReq POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		int callNo = communityService.getCallNo(userNo, "S");
		communityService.deleteShareReq(callNo);
		communityService.updateShareCode(userNo);
		callReqService.deleteCall(callNo);

		return "redirect:/community/getShareList";
	}

	@RequestMapping(value = "chat", method = RequestMethod.GET)
	public String chat(@RequestParam int callNo, HttpSession session, Model model) throws Exception {

		System.out.println("/chat GET");

		model.addAttribute("callNo", callNo);

		return "/community/chat.jsp";
	}
}
