package kr.pe.eta.web.callres;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Pay;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.AddCallEntity;
import kr.pe.eta.redis.RedisEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.callres.CallResService;
import kr.pe.eta.service.pay.PayService;

@Controller
@RequestMapping("/callres/*")
public class CallResController {

	@Autowired
	private CallResService callResService;

	@Autowired
	private PayService payService;

	@Autowired
	private final RedisService redisService;

	public CallResController(RedisService redisService) {
		this.redisService = redisService;
		System.out.println(this.getClass());
	}

	public void PayController(PayService payService) {
		this.payService = payService;
	}

	@Value("${search.pageUnit}")
	private int pageUnit;

	@Value("${search.pageSize}")
	private int pageSize;

	@GetMapping("getRecordPassenger")
	public String getRecordPassenger(@RequestParam("callNo") int callNo, Model model) throws Exception {

		System.out.println("pgrpCont");
		System.out.println(callNo);
		// Business Logic
		Call call = callResService.getCallByNo(callNo);
		System.out.println("call 끝");
		User user = callResService.getUserByCallNop(callNo);
		System.out.println("user 끝");
		List<ShareReq> shares = callResService.getSharesByCallNop(callNo);
		System.out.println("shares:" + shares);
		model.addAttribute("call", call);
		model.addAttribute("users", user);
		model.addAttribute("share", shares);

		if (!"예약중".equals(call.getCallStateCode())) {
			return "/callres/getRecord.jsp";
		} else {
			return "/callres/getReservation.jsp";
		}

	}

	@GetMapping("getRecordDriver")
	public String getRecordDriver(@RequestParam("callNo") int callNo, Model model) throws Exception {

		System.out.println("dgrpCont");
		System.out.println(callNo);
		// Business Logic
		Call call = callResService.getCallByNo(callNo);
		System.out.println("예약중" + call.getCallStateCode());
		User user = callResService.getUserByCallNod(callNo);
		List<ShareReq> shares = callResService.getSharesByCallNod(callNo);
		int passengerNo = callResService.getMatchByCallnod(callNo);
		int blacklist = callResService.getBlacklistByCallNod(callNo);

		// Model 과 View 연결
		model.addAttribute("call", call);
		model.addAttribute("users", user);
		model.addAttribute("share", shares);
		model.addAttribute("passengerNo", passengerNo);
		model.addAttribute("blacklist", blacklist);

		if (!"예약중".equals(call.getCallStateCode())) {
			return "/callres/getRecord.jsp";
		} else {
			return "/callres/getReservation.jsp";
		}

	}

	@PostMapping("callEnd")
	@ResponseBody
	public void callEnd(@RequestBody Call call) throws Exception {
		call.setCallStateCode("운행후");
		RedisEntity redisEntity = new RedisEntity();
		String userNo = String.valueOf(call.getCallNo());
		redisEntity.setId(userNo);
		redisEntity.setCurrentX(call.getEndX());
		redisEntity.setCurrentY(call.getEndY());
		redisService.addUser(redisEntity);
		callResService.updateCallStateCode(call);
		callResService.updateEndXY(call);
	}

	@GetMapping("getRealPay")
	public String getRealPay(@RequestParam("callNo") int callNo, Model model) {
		model.addAttribute("callNo", callNo);
		return "forward:/callres/addRealPay.jsp";
	}

	@GetMapping("addRealPay")
	public String addRealPay(@RequestParam("callNo") int callNo, @RequestParam("money") int money, Model model)
			throws Exception {
		Call call = callResService.getCallByNo(callNo);
		int passengerNo = callResService.getMatchByCallnod(callNo);

		if (call.getCallCode().equals("N") || call.getCallCode().equals("D") || call.getCallCode().equals("R")) {

			Pay pay1 = new Pay();
			pay1.setCallNo(callNo);
			pay1.setPayType("선결제취소");
			pay1.setUserNo(passengerNo);
			pay1.setMoney(call.getRealPay());
			payService.addPay(pay1);
			// 선결제취소
			int currentMoney1 = payService.getMyMoney(passengerNo);
			payService.updateMyMoney(passengerNo, currentMoney1 + call.getRealPay());

			Pay pay = new Pay();
			pay.setCallNo(callNo);
			pay.setPayType("실결제");
			pay.setUserNo(passengerNo);
			pay.setMoney(money);
			payService.addPay(pay);
			// 실결제
			call.setCallNo(callNo);
			call.setRealPay(money);
			callResService.updateRealPay(call);
			int currentMoney2 = payService.getMyMoney(passengerNo);
			int resultMoney = currentMoney2 - money;

			payService.updateMyMoney(passengerNo, resultMoney);
		} else {
			List<ShareReq> shares = callResService.getSharesByCallNod(callNo);
			int numberOfShares = shares.size();
			int allCount = 0;
			for (ShareReq share : shares) {
				allCount += share.getFirstShareCount();
			}
			for (ShareReq share : shares) {
				Pay pay = new Pay();
				int myAccount = (call.getRealPay() / allCount) * share.getFirstShareCount();
				int currentMoney = payService.getMyMoney(share.getFirstSharePassengerNo());
				pay.setCallNo(callNo);
				pay.setPayType("선결제취소");
				pay.setMoney(myAccount);
				pay.setUserNo(share.getFirstSharePassengerNo()); // ShareReqPassenger 객체의 userNo를 사용
				payService.addPay(pay);
				payService.updateMyMoney(share.getFirstSharePassengerNo(), currentMoney + myAccount);

			}

			for (ShareReq share : shares) {
				Pay pay = new Pay();
				int currentMoney = payService.getMyMoney(share.getFirstSharePassengerNo());
				int myAccount = (money / allCount) * share.getFirstShareCount();
				pay.setCallNo(callNo);
				pay.setPayType("실결제");
				pay.setMoney(myAccount);
				pay.setUserNo(share.getFirstSharePassengerNo()); // ShareReqPassenger 객체의 userNo를 사용
				payService.addPay(pay);
				payService.updateMyMoney(share.getFirstSharePassengerNo(), currentMoney - myAccount);

			}

		}

		// 피드백하러 가기
		return "forward:/callres/home.jsp";
	}

	@GetMapping("callAccept")
	public String callAccept(@RequestParam("callNo") int callNoString, Model model, HttpSession session)
			throws Exception {// String callNoString으로 바꾸기 나중에

		int driverNo = ((User) session.getAttribute("user")).getUserNo();
		// int callNo = Integer.parseInt(callNoString);
		int callNo = callNoString;

		Call call = callResService.getCallByNo(callNo);
		// Business Logic
		if (call.getCallCode().equals("N") || call.getCallCode().equals("D")) {
			call.setCallStateCode("운행중");
			callResService.updateCallStateCode(call);
			callResService.updateMatchDriver(callNo, driverNo);

			int passengerNo = callResService.getMatchByCallnod(callNo);

			Pay pay = new Pay();
			pay.setCallNo(callNo);
			pay.setPayType("선결제");
			pay.setMoney(call.getRealPay());
			pay.setUserNo(passengerNo);
			payService.addPay(pay);
			int currentMoney = payService.getMyMoney(passengerNo);
			payService.updateMyMoney(passengerNo, currentMoney - call.getRealPay());

			String driverNo1 = String.valueOf(driverNo);
			RedisEntity location = redisService.getUserById(driverNo1);
			double currentX = location.getCurrentX().doubleValue();
			double currentY = location.getCurrentY().doubleValue();

			model.addAttribute("currentX", currentX);
			model.addAttribute("currentY", currentY);
			model.addAttribute("call", call);
			model.addAttribute("passengerNo", passengerNo);
			model.addAttribute("driverNo", driverNo);
			return "forward:/callres/driving.jsp";

		} else if (call.getCallCode().equals("R")) {
			call.setCallStateCode("예약중");
			callResService.updateCallStateCode(call);
			callResService.updateMatchDriver(callNo, driverNo);
			int passengerNo = callResService.getMatchByCallnod(callNo);

			Pay pay = new Pay();
			pay.setCallNo(callNo);
			pay.setPayType("선결제");
			pay.setMoney(call.getRealPay());
			pay.setUserNo(passengerNo);
			payService.addPay(pay);
			int currentMoney = payService.getMyMoney(passengerNo);
			payService.updateMyMoney(passengerNo, currentMoney - call.getRealPay());

			return "forward:/callres/getReservationList.jsp";

		} else {
			call.setCallStateCode("운행중");
			callResService.updateCallStateCode(call);
			callResService.updateMatchDriver(callNo, driverNo);
			List<ShareReq> shares = callResService.getSharesByCallNod(callNo);

			int allCount = 0; // 택시를 타는 총 인원수
			for (ShareReq share : shares) {
				allCount += share.getFirstShareCount();
			}

			System.out.println("allCount:.." + allCount);

			for (ShareReq share : shares) {
				Pay pay = new Pay();
				int myAccount = (call.getRealPay() / allCount) * share.getFirstShareCount();
				int currentMoney = payService.getMyMoney(share.getFirstSharePassengerNo());
				pay.setCallNo(callNo);
				pay.setPayType("선결제");
				pay.setMoney(myAccount);
				pay.setUserNo(share.getFirstSharePassengerNo()); // ShareReqPassenger 객체의 userNo를 사용
				payService.addPay(pay);
				payService.updateMyMoney(share.getFirstSharePassengerNo(), currentMoney - myAccount);
			}

			model.addAttribute("call", call);
			model.addAttribute(shares);
			model.addAttribute("passengerNo", 1001);// 일단 이렇게 보내줌 driving.jsp 고쳐야됌
			model.addAttribute("driverNo", driverNo);

			return "forward:/callres/driving.jsp";

		}
		// 선결제 service 들어와야됌
	}

	@GetMapping(value = "startReservationDriving")
	public String startReservationDriving(@RequestParam("callNo") int callNo, Model model, HttpSession session)
			throws Exception {

		Call call = callResService.getCallByNo(callNo);

		call.setCallStateCode("운행중");
		callResService.updateCallStateCode(call);
		System.out.println("updatecallstatecode");

		int passengerNo = callResService.getMatchByCallnod(callNo);
		System.out.println("getmatchbycallnod");
		model.addAttribute("call", callResService.getRecordDriver(callNo));
		model.addAttribute("passengerNo", passengerNo);
		return "forward:/callres/driving.jsp";
	}

	@GetMapping(value = "getRecordList")
	public String getRecordList(@ModelAttribute Search search, Model model, HttpSession session,
			@RequestParam("month") String month) throws Exception {
		System.out.println("crContRL");
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		System.out.println("userNo : " + userNo);
		User users = callResService.getUserByUserNo(userNo);
		System.out.println(month);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(null);

		System.out.println(search);

		Map<String, Object> map = callResService.getRecordList(search, userNo, month);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("users", users);
		model.addAttribute("month", month);

		return "forward:/callres/getRecordList.jsp";
	}

	@GetMapping(value = "getReservationList")
	public String getReservationList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		System.out.println("crContRL");
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		User users = callResService.getUserByUserNo(userNo);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(null);

		System.out.println(search);

		Map<String, Object> map = callResService.getReservationList(search, userNo);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("user", users);

		return "forward:/callres/getReservationList.jsp";
	}

	@GetMapping(value = "getCallResList")
	public ModelAndView getCallResList(@ModelAttribute Search search, Model model) throws Exception {
		String viewName = "/callres/getCallRecordList.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		search.setCurrentPage(1);

		search.setPageSize(pageSize);

		Map<String, Object> map = callResService.getCallResList(search);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		return modelAndView;
	}

	@GetMapping(value = "getRequest")
	public String getRequest(Model model, HttpSession session) throws Exception {
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		String driverNo = String.valueOf(userNo);
		AddCallEntity callRequest = redisService.getCallById(driverNo);
		int callNo = callRequest.getCallNo();
		int passengerNo = callResService.getMatchByCallnod(callNo);
		Call call = callResService.getCallByNo(callNo);
		model.addAttribute("call", call);
		model.addAttribute("passengerNo", passengerNo);
		System.out.println(call);
		return "forward:/callres/callAcceptReject.jsp";
	}

}
