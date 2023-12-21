package kr.pe.eta.web.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.Message;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.community.CommunityService;
import kr.pe.eta.service.pay.PayService;
import kr.pe.eta.service.user.UserService;

@RestController
@RequestMapping("/community/json/*")
public class CommunityRestController {

	@Autowired
	private CommunityService communityService;

	@Autowired
	private UserService userService;

	@Autowired
	private CallReqService callReqService;

	@Autowired
	private PayService payService;

	public CommunityRestController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageUnit}")
	int pageUnit;
	@Value("${search.pageSize}")
	int pageSize;

	@RequestMapping(value = "getMyMoney", method = RequestMethod.GET)
	public String getMyMoney(HttpSession session) throws Exception {

		System.out.println("/json/getMyMoney GET");

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();
		int myMoney = payService.getMyMoney(userNo);
		ObjectMapper objectMapper = new ObjectMapper();

		// Java 객체를 JSON 문자열로 변환
		String jsonString = objectMapper.writeValueAsString(myMoney);
		return jsonString;
	}

	@RequestMapping(value = "addDealDriver", method = RequestMethod.POST)
	public Call addDealDriver(@RequestBody DealReq dealReq, HttpSession session) throws Exception {

		System.out.println("/json/addDealDriver POST");

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();
		dealReq.setUserNo(userNo);
		communityService.addDealReq(dealReq);
		communityService.updateDealCode(userNo);
		user = userService.getUser(user.getEmail());
		session.setAttribute("user", user);
		Call call = communityService.getCall(dealReq.getCallNo());

		return call;
	}

	@RequestMapping(value = "deleteDealReq", method = RequestMethod.GET)
	public User deleteDealReq(HttpSession session) throws Exception {

		System.out.println("/json/deleteDealReq GET");

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();
		communityService.deleteDealReqDriver(userNo);
		communityService.updateDealCode(userNo);
		user = userService.getUser(user.getEmail());
		session.setAttribute("user", user);

		return user;
	}

	@RequestMapping(value = "getCallNo", method = RequestMethod.GET)
	public int getCallNo(@RequestParam String callCode, HttpSession session) throws Exception {

		System.out.println("/json/getCallNo GET");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		int callNo = communityService.getDealNo(userNo, callCode);

		return callNo;
	}

	@RequestMapping(value = "deleteDealOther", method = RequestMethod.POST)
	public ResponseEntity<DealReq> deleteDealOther(@RequestBody DealReq dealReq) throws Exception {
		System.out.println("/json/deleteDealOther");

		List<DealReq> list = communityService.getDealDriverList(dealReq.getCallNo());

		for (int i = 0; i < list.size(); i++) {
			int driverNo = list.get(i).getUserNo();
			communityService.updateDealCode(driverNo);
		}
		communityService.deleteDealOther(dealReq);

		return new ResponseEntity<>(dealReq, HttpStatus.OK);
	}

	@RequestMapping(value = "getShare", method = RequestMethod.GET)
	public ShareReq getShare(HttpSession session) throws Exception {

		System.out.println("/json/getShare GET");

		int userNo = ((User) session.getAttribute("user")).getUserNo();
		ShareReq shareReq = communityService.getShare(userNo);

		return shareReq;
	}

	@RequestMapping(value = "addSharePassenger", method = RequestMethod.POST)
	public Call addSharePassenger(@RequestBody ShareReq shareReq, HttpSession session) throws Exception {

		System.out.println("/json/addSharePassenger POST");

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();
		int shareCount = shareReq.getFirstShareCount();
		int callNo = shareReq.getCallNo();
		shareReq = communityService.getShareall(callNo);
		System.out.println(shareReq);
		shareReq.setFirstSharePassengerNo(userNo);
		shareReq.setFirstShareCount(shareCount);
		communityService.addShareReq(shareReq);
		communityService.updateShareCode(userNo);
		user = userService.getUser(user.getEmail());
		session.setAttribute("user", user);
		Call call = communityService.getCall(shareReq.getCallNo());

		return call;
	}

	@RequestMapping(value = "deleteShareReqOther", method = RequestMethod.GET)
	public User deleteShareReqOther(HttpSession session) throws Exception {

		System.out.println("/json/deleteShareReqOther GET");

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();
		communityService.deleteShareOther(userNo);
		communityService.updateShareCode(userNo);
		user = userService.getUser(user.getEmail());
		session.setAttribute("user", user);

		return user;
	}

	@RequestMapping(value = "getChat")
	public Message getChat() throws Exception {
		return new Message();
	}

	@RequestMapping(value = "getShareCallNo")
	public ShareReq getShareCallNo(HttpSession session) throws Exception {

		User user = (User) session.getAttribute("user");
		int userNo = user.getUserNo();

		ShareReq shareReq = communityService.getShareCallNo(userNo);

		/*
		 * if (user.isShareCode()) { shareReq = communityService.getShareCallNo(userNo);
		 * }
		 */

		return shareReq;
	}

}
