package kr.pe.eta.web.callreq;

import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Like;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.pay.PayService;

//==>  Call Req Controller
@Controller
@ServerEndpoint("/websocket")
@RequestMapping("/callreq/*")
public class CallReqController extends Socket {

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

	@OnOpen
	public void open(Session newUser) {
		System.out.println("connected");
		session.add(newUser);
		System.out.println(newUser.getId());
	}

	@OnMessage
	public void getMsg(Session recieveSession, String msg) {
		for (int i = 0; i < session.size(); i++) {
			if (!recieveSession.getId().equals(session.get(i).getId())) {
				try {
					session.get(i).getBasicRemote().sendText("배차번호 : " + msg);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} /*
				 * else { try { session.get(i).getBasicRemote().sendText("나 : " + msg); } catch
				 * (IOException e) { e.printStackTrace(); } }
				 */
		}
	}

	@MessageMapping("/test")
	@SendTo("/topic/test")
	public String handleTestMessage(String message) {
		System.out.println("Received message: " + message);
		return "Received message: " + message;
	}

	@RequestMapping(value = "inputAddress", method = RequestMethod.GET)
	public String inputAddress(@RequestParam("userNo") int userNo, Model model) throws Exception {

		System.out.println("/callreq/inputAddress");
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic
		List<Call> endAddrList = callReqService.getEndAddrList(userNo); // 도착지 키워드, 주소 리스트
		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("endAddrList", endAddrList);
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/inputAddress.jsp";
	}

	@RequestMapping(value = "selectOptions", method = RequestMethod.GET)
	public String selectOptions(@RequestParam("userNo") int userNo, Model model) throws Exception {

		System.out.println("/callreq/selectOptions");
		System.out.println("userNo : " + userNo);

		int myMoney = payService.getMyMoney(userNo);

		model.addAttribute("myMoney", myMoney);

		return "forward:/callreq/selectOptions.jsp";
	}

	@RequestMapping(value = "addCall", method = RequestMethod.POST)
	public String addCall(@ModelAttribute("call") Call call, Model model) throws Exception {

		System.out.println("/callreq/addCall");

		System.out.println("call : " + call);

		call.setUserNo(1004); // test
		call.setCallCode("N"); // test

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
		int likeNo = like.getLikeNo();

		callReqService.updateLikeAddr(likeAddr, userNo, likeNo);

		List<Like> likeList = callReqService.getLikeList(userNo); // 즐겨찾기 리스트

		// Model 과 View 연결
		model.addAttribute("likeList", likeList);

		return "forward:/callreq/likeAddrList.jsp";
	}

	@RequestMapping(value = "updateLikeName", method = RequestMethod.POST)
	public String updateLikeName(@ModelAttribute("like") Like like, @RequestParam("userNo") int userNo, Model model)
			throws Exception {

		System.out.println("/callreq/updateLikeName");
		System.out.println("like : " + like);
		System.out.println("userNo : " + userNo);
		// userNo = "1004";
		// Business Logic

		String likeName = like.getLikeName();

		callReqService.updateCustomName(likeName, userNo);

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