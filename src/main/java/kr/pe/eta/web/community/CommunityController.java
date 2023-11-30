package kr.pe.eta.web.community;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.*;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.pay.PayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.pe.eta.service.community.CommunityService;

import java.util.Map;


@Controller
@RequestMapping("/community/*")
public class CommunityController {

	@Autowired
	private CommunityService communityService;

	@Autowired
	private CallReqService callReqService;

	@Autowired
	private PayService payService;

	public CommunityController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageUnit}")
	int pageUnit;
	@Value("${search.pageSize}")
	int pageSize;

	//삭제 예정
	@RequestMapping(value = "addCall", method = RequestMethod.GET)
	public String addCall(@RequestParam("callCode") String callCode, Model model) throws Exception {

		System.out.println("/addCall GET");

		model.addAttribute("callCode", callCode);

		return "/community/addCall.jsp";
	}

	@RequestMapping(value = "addReservation", method = RequestMethod.POST)
	public String addReservation(@ModelAttribute("call") Call call,
			Model model) throws Exception {

		System.out.println("/addReservation POST");
		System.out.println(call);

		model.addAttribute("call", call);

		return "/community/addReservation.jsp";
	}

	@RequestMapping(value = "addReservationReq", method = RequestMethod.POST)
	public String addReservationReq(@ModelAttribute("call") Call call, @ModelAttribute("callTime") String callTime, Model model) throws Exception {

		System.out.println("/addReservationReq POST");
		call.setCallDate(call.getCallDate()+" "+callTime+":00");
		communityService.addReservation(call);
		model.addAttribute("call", call);

		//"/callres/reservationRecordDetail.jsp"
		return "/community/getReservation.jsp";
	}

	@RequestMapping(value = "addDeal", method = RequestMethod.POST)
	public String addDeal(@ModelAttribute("call") Call call,
						  @ModelAttribute("pay") Pay pay,
						  HttpSession session,
						  Model model) throws Exception {

		System.out.println("/addDeal POST");

		//int userNo=((User)session.getAttribute("user")).getUserNo();
		//call.setUserNo(userNo);
		callReqService.addCall(call);
		pay.setMoney(call.getRealPay());
		payService.addPay(pay);
		//int callNo = communityService.getCallNo(userNo);
		int callNo = communityService.getCallNo(call.getUserNo());
		int money = call.getRealPay();

		model.addAttribute("callNo", callNo);
		model.addAttribute("userNo", call.getUserNo()); //삭제 예정
		model.addAttribute("money", money);

		return "/community/addDeal.jsp";
	}

	@RequestMapping(value = "addDealReq", method = RequestMethod.POST)
	public String addDealReq(@ModelAttribute("dealReq") DealReq dealReq,
							 Model model) throws Exception {

		System.out.println("/addDealReq POST");

		//int userNo=((User)session.getAttribute("user")).getUserNo();
		//dealReq.setUserNo(userNo);
		communityService.addDealReq(dealReq);
		Call call = callReqService.getCall(dealReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("dealReq", dealReq);

		return "/community/getDeal.jsp";
	}

	@RequestMapping(value = "getDealReq", method = RequestMethod.POST)
	public String getDealReq(HttpSession session,
							 Model model) throws Exception {

		System.out.println("/getDealReq POST");

		int userNo=((User)session.getAttribute("user")).getUserNo();
		DealReq dealReq = communityService.getDeal(userNo);
		Call call = callReqService.getCall(dealReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("dealReq", dealReq);

		return "/community/getDeal.jsp";
	}

	@RequestMapping(value = "addDealDriver", method = RequestMethod.POST)
	public String addDealDriver(@ModelAttribute("dealReqDriver") DealReq dealReq,
								Model model) throws Exception {

		System.out.println("/addDealDriver POST");

		communityService.addDealReqDriver(dealReq);
		Call call = callReqService.getCall(dealReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("deal", dealReq);

		return "/community/getDeal.jsp";
	}

	@RequestMapping(value = "addShare", method = RequestMethod.POST)
	public String addShare(@ModelAttribute("call") Call call,
						   @ModelAttribute("pay") Pay pay,
						   HttpSession session,
						   Model model) throws Exception {

		System.out.println("/addShare POST");

		//int userNo=((User)session.getAttribute("user")).getUserNo();
		//call.setUserNo(userNo);
		int userNo = call.getUserNo(); //삭제 예정
		callReqService.addCall(call);
		pay.setMoney(call.getRealPay());
		payService.addPay(pay);

		//int callNo = communityService.getCallNo(userNo);
		int callNo = communityService.getCallNo(userNo);

		int maxShareCount= 4;
		if(call.getCarOpt().equals("중형")) {
			maxShareCount = 6;
		} else if(call.getCarOpt().equals("대형")) {
			maxShareCount = 7;
		}

		model.addAttribute("callNo", callNo);
		model.addAttribute("maxShareCount", maxShareCount);

		return "/community/addShare.jsp";
	}

	@RequestMapping(value = "addShareReq", method = RequestMethod.POST)
	public String addShareReq(@ModelAttribute("shareReq") ShareReq shareReq,
							  Model model) throws Exception {

		System.out.println("/addShareReq POST");

		//int userNo=((User)session.getAttribute("user")).getUserNo();
		//dealReq.setUserNo(userNo);
		communityService.addShareReq(shareReq);
		//communityService.updateShareCode(userNo);
		communityService.updateShareCode(shareReq.getFirstSharePassengerNo());
		Call call = callReqService.getCall(shareReq.getCallNo());

		model.addAttribute("call", call);
		model.addAttribute("shareReq", shareReq);

		return "/community/listShare";
	}

	@RequestMapping(value = "getShareList")
	public String getShareList(@ModelAttribute("search") Search search,
							   Model model) throws Exception {

		System.out.println("/listProduct");

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

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "/community/listShare.jsp";
	}

	@RequestMapping(value = "getDealList")
	public String getDealList(@ModelAttribute("search") Search search,
							   Model model) throws Exception {

		System.out.println("/listDeal");

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

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "/community/listDeal.jsp";
	}
}
