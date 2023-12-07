package kr.pe.eta.web.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.community.CommunityService;
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

	public CommunityRestController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageUnit}")
	int pageUnit;
	@Value("${search.pageSize}")
	int pageSize;

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

}
