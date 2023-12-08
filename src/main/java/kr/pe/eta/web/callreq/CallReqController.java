package kr.pe.eta.web.callreq;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Like;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.pay.PayService;

//==>  Call Req Controller
@Controller
@RequestMapping("/callreq/*")
public class CallReqController {

	@Autowired
	@Qualifier("callReqService")
	private CallReqService callReqService;

	@Autowired
	@Qualifier("payService")
	private PayService payService;

	public CallReqController() {
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

		call.setUserNo(1004); // test

		String callCode = call.getCallCode();

		callReqService.addCall(call); // addCall()

		int callNo = callReqService.getCallNo(); // getCallNo()

		if (callCode == "D") {
			callReqService.updateDealCode(callNo);
		} else if (callCode == "S") {
			callReqService.updateShareCode(callNo);
		}

		boolean petOpt = call.isPetOpt();
		System.out.println("petOpt : " + petOpt);

		String carOpt = call.getCarOpt();
		System.out.println("carOpt : " + carOpt);

		List<User> callDriverList = callReqService.getCallDriverList(carOpt, petOpt); // driver 탐색

		model.addAttribute("call", call);
		model.addAttribute("callNo", callNo);
		model.addAttribute("callDriverList", callDriverList);

		return "forward:/callreq/searchCall.jsp";
	}

	@RequestMapping(value = "deleteCall", method = RequestMethod.POST)
	public String deleteCall(@RequestParam("callNo") int callNo, Model model) throws Exception {

		System.out.println("/callreq/deleteCall");

		System.out.println("callNo : " + callNo);

		callReqService.deleteCall(callNo);

		return "forward:/callreq/selectOptions.jsp";
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
	public String updateLikeAddr(@ModelAttribute("like") Like like, @RequestParam("userNo") int userNo, Model model)
			throws Exception {

		System.out.println("/callreq/updateHomeAddr");
		System.out.println("like : " + like);
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		String likeAddr = like.getLikeAddr();
		String likeName = like.getLikeName();
		int likeNo = like.getLikeNo();

		callReqService.updateLikeAddr(likeAddr, likeName, userNo, likeNo);

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/likeAddrList.jsp";
	}

	@RequestMapping(value = "deleteLikeAddr", method = RequestMethod.POST)
	public String deleteLikeAddr(@ModelAttribute("like") Like like, @RequestParam("userNo") int userNo,
			HttpSession session, Model model) throws Exception {

		System.out.println("/callreq/deleteLikeAddr");
		System.out.println("like : " + like);
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		int likeNo = like.getLikeNo();

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

		return "forward:/callreq/likeAddrList.jsp";
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