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

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Pay;
import kr.pe.eta.domain.ShareReqPassenger;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callres.CallResService;
import kr.pe.eta.service.pay.PayService;

@Controller
@RequestMapping("/callres/*")
public class CallResController {

	@Autowired
	private CallResService callResService;

	@Autowired
	private PayService payService;

	public CallResController() {
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
		List<ShareReqPassenger> shares = callResService.getSharesByCallNop(callNo);
		System.out.println("shares:" + shares);
		model.addAttribute("call", call);
		model.addAttribute("user", user);
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
		List<ShareReqPassenger> shares = callResService.getSharesByCallNod(callNo);
		int passengerNo = callResService.getMatchByCallnod(callNo);
		int blacklist = callResService.getBlacklistByCallNod(callNo);

		// Model 과 View 연결
		model.addAttribute("call", call);
		model.addAttribute("user", user);
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

		Pay pay1 = new Pay();
		pay1.setCallNo(callNo);
		pay1.setPayType("선결제취소");
		pay1.setUserNo(passengerNo);
		pay1.setMoney(call.getRealPay());
		payService.addPay(pay1);
		// 선결제취소

		Pay pay = new Pay();
		pay.setCallNo(callNo);
		pay.setPayType("실결제");
		pay.setUserNo(passengerNo);
		pay.setMoney(money);
		payService.addPay(pay);
		// 실결제
		call.setRealPay(money);
		callResService.updateRealPay(call);

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
		if (call.getCallCode().equals("N") || call.getCallCode().equals("D") || call.getCallCode().equals("S")) {
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

			model.addAttribute("call", callResService.getRecordDriver(callNo));
			model.addAttribute("passengerNo", passengerNo);
			return "forward:/callres/driving.jsp";
		} else {
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

			return "forward:/callres/getReservationList.jsp";
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
	public String getRecordList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		System.out.println("crContRL");
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		System.out.println("userNo : " + userNo);
		User users = callResService.getUserByUserNo(userNo);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(null);

		System.out.println(search);

		Map<String, Object> map = callResService.getRecordList(search, userNo);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("user", users);

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
	public String getCallResList(@ModelAttribute Search search, Model model) throws Exception {
		System.out.println("crContRL");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(null);

		System.out.println(search);

		Map<String, Object> map = callResService.getCallResList(search);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/callres/getCallResList.jsp";
	}

}
