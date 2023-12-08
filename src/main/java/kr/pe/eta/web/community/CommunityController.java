package kr.pe.eta.web.community;

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
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.community.CommunityService;
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

	public CommunityController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageUnit}")
	int pageUnit;
	@Value("${search.pageSize}")
	int pageSize;

	@RequestMapping(value = "addReservation", method = RequestMethod.GET)
	public String addReservation(Model model) throws Exception {
		// public String addReservation(@ModelAttribute("call") Call call, Model model)
		// throws Exception {

		System.out.println("/addReservation POST");

		Call call = new Call();

		call.setCallDate("2023-12-25 14:00:00");
		call.setRealPay(40800);
		call.setStartAddr("서울 강남구 역삼동 642-14");
		call.setStartKeyword("맥시머스");
		call.setStartX(10.11111);
		call.setStartY(12.11111);
		call.setEndAddr("경기 수원시 팔달구 매산로1가 102");
		call.setEndKeyword("수원역");
		call.setEndX(13.11111);
		call.setEndY(15.1111);
		call.setRouteOpt("RECOMMEND");
		call.setCallCode("R");
		call.setCarOpt("소형");
		call.setPetOpt(false);

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

		boolean petOpt = call.isPetOpt();
		String carOpt = call.getCarOpt();
		List<User> callDriverList = callReqService.getCallDriverList(carOpt, petOpt);

		model.addAttribute("call", call);
		model.addAttribute("callNo", callNo);
		model.addAttribute("callDriverList", callDriverList);

		return "forward:/callreq/searchCall.jsp";
	}

	@RequestMapping(value = "addDeal", method = RequestMethod.GET)
	public String addDeal(HttpSession session, Model model) throws Exception {
		// public String addDeal(@ModelAttribute("call") Call call, HttpSession session,
		// Model model) throws Exception {
		System.out.println("/addDeal POST");

		Call call = new Call();

		call.setCallDate("2023-12-25 14:00:00");
		call.setRealPay(40800);
		call.setStartAddr("서울 강남구 역삼동 642-14");
		call.setStartKeyword("맥시머스");
		call.setStartX(10.11111);
		call.setStartY(12.11111);
		call.setEndAddr("경기 수원시 팔달구 매산로1가 102");
		call.setEndKeyword("수원역");
		call.setEndX(13.11111);
		call.setEndY(15.1111);
		call.setRouteOpt("RECOMMEND");
		call.setCallCode("D");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		call.setUserNo(userNo);
		callReqService.addCall(call);
		int callNo = communityService.getCallNo(userNo, call.getCallCode());
		int money = call.getRealPay();
		int myMoney = payService.getMyMoney(userNo);
		model.addAttribute("callNo", callNo);
		model.addAttribute("money", money);
		model.addAttribute("myMoney", myMoney);

		return "/community/addDeal.jsp";
	}

	@RequestMapping(value = "addDealReq", method = RequestMethod.POST)
	public String addDealReq(@ModelAttribute("dealReq") DealReq dealReq, HttpSession session, Model model)
			throws Exception {

		System.out.println("/addDealReq POST");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		dealReq.setUserNo(userNo);
		communityService.addDealReq(dealReq);
		communityService.updateDealCode(userNo);
		User user = userService.getUser(((User) session.getAttribute("user")).getEmail());
		session.setAttribute("user", user);
		Call call = communityService.getCall(dealReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("dealReq", dealReq);

		return "/community/getDeal.jsp";
	}

	@RequestMapping(value = "getDealReq", method = RequestMethod.GET)
	public String getDealReq(HttpSession session, Model model) throws Exception {

		System.out.println("/getDealReq GET");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		DealReq dealReq = communityService.getDeal(userNo);
		Call call = communityService.getCall(dealReq.getCallNo());
		Map<String, Object> map = communityService.getDealDriverList(dealReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("dealReq", dealReq);
		model.addAttribute("list", map.get("list"));

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
	public String getDealList(@ModelAttribute("search") Search search, HttpSession session, Model model)
			throws Exception {

		System.out.println("/getDealList");

		System.out.println(search);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = communityService.getDealList(search);
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		int callNo = 0;
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		if (((User) session.getAttribute("user")).isDealCode()) {
			callNo = communityService.getDealNo(userNo, "D");
		}

		model.addAttribute("dealList", map.get("dealList"));
		model.addAttribute("callList", map.get("callList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("callNo", callNo);

		return "/community/listDeal.jsp";
	}
}
