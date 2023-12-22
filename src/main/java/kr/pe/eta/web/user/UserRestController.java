package kr.pe.eta.web.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Block;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.feedback.FeedbackService;
import kr.pe.eta.service.user.AccountToken;
import kr.pe.eta.service.user.IamportApiRequest;
import kr.pe.eta.service.user.LoginService;
import kr.pe.eta.service.user.UserService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
@RequestMapping("/user/json/*")
public class UserRestController {

	@Autowired
	private UserService userService;

	@Autowired
	private FeedbackService feedback;

	@Autowired
	private LoginService loginService;

	@Autowired
	private CallReqService callReqService;

	@Autowired
	private IamportApiRequest port;

	@Value("${search.pageSize}")
	private int pageSize;

	@Value("${kakao.clienId}")
	String kaclienId;

	@Value("${naver.Secret}")
	String Secret;

	final DefaultMessageService messageService;

	private final RedisService redisService;

	public UserRestController(RedisService redisService) {
		System.out.println(this.getClass());
		this.messageService = NurigoApp.INSTANCE.initialize("NCSMOXVRHXMS5UNM", "ACJ94REWVJTBOWKDKHSM3NBX4KZF1ERP",
				"https://api.coolsms.co.kr");
		this.redisService = redisService;
	}

	@GetMapping("/send-one")
	public Map<String, Object> sendOne(@RequestParam("phone") String phone) {
		System.out.println("메시지 전송");
		System.out.println("num :" + phone);
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

//		Message message = new Message();
//		message.setFrom("01066779045");
//		message.setTo(phone);
//		message.setText("[인증번호 안내] 입력하셔야할 인증번호는[" + numStr + "]입니다");
//
//		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

		// Create a map to hold multiple values
		Map<String, Object> resultMap = new HashMap<>();
		// resultMap.put("response", response);
		resultMap.put("num", numStr);

		System.out.println(resultMap);

		return resultMap;
	}

	@RequestMapping(value = "dupNickName", method = RequestMethod.GET)
	public String dupnickName(@RequestParam("nick") String nickName) throws Exception {
		System.out.println("/Json/dpuNickName : GET");

		System.out.println("nickName==" + nickName);
		boolean duplication = userService.dupNickname(nickName);
		String ment = null;
		if (duplication == true) {
			ment = "1";
		} else {
			ment = "2";
		}
		System.out.println("result===" + duplication);

		return ment;
	}

	@RequestMapping(value = "dupEmail", method = RequestMethod.GET)
	public String dupEmail(@RequestParam("email") String email) throws Exception {

		System.out.println("/json/dupEmail : GET");

		System.out.println("email==" + email);
		boolean duplication = userService.dupEmail(email);
		System.out.println("결과" + userService.dupEmail(email));
		String ment = null;
		if (duplication == true) {
			ment = "1";
		} else {
			ment = "2";
		}
		System.out.println("result===" + duplication);
		return ment;
	}

	@RequestMapping(value = "autoList", method = RequestMethod.POST)
	public Map<String, Object> autoautoList(@RequestBody Search search) throws Exception {

		System.out.println("/Json/autoauoUser : POST");

		ModelAndView model = new ModelAndView();

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {

			search.setCurrentPage(search.getCurrentPage() + 1);

		}
		search.setPageSize(pageSize);

		Map<String, Object> map = userService.autoUserList(search);

		List<User> users = (List<User>) map.get("list");
		List<String> lists = new ArrayList();
		List<String> userName = new ArrayList();
		List<Integer> userNo = new ArrayList();

		for (User user : users) {
			userNo.add(user.getUserNo());
			lists.add(user.getEmail());
			lists.add(user.getName());

		}
		System.out.println("lists-=====" + userNo);
		System.out.println("lists-=====" + lists);

		map.put("lists", lists);
		map.put("list", map.get("list"));
		map.put("userNo", userNo);

		return map;
	}

	@GetMapping("/bankName")
	public String getVbankHolder(@RequestParam("bank_code") String bankCode, @RequestParam("bank_num") String bankNum) {
		System.out.println("예금주 확인");
		System.out.println("bank_code: " + bankCode);
		System.out.println("bank_num :" + bankNum);
		ObjectMapper objectMapper = new ObjectMapper();
		AccountToken account = null;
		try {
			account = objectMapper.readValue(port.getToken(), AccountToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		String accessToken = account.getResponse().getAccessToken();
		// 이 부분을 통해 Access Token을 얻어옵니다
		System.out.println("accessToken = " + accessToken);
		String jsonResponse = port.getVbankHolder(accessToken, bankCode, bankNum);
		String bankName = port.JsonParsing(jsonResponse);
		return bankName;
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public Map<String, Object> login(@RequestBody User user, HttpSession session) throws Exception {
		System.out.println("json");
		// Business Logic
		User db = userService.getUser(user.getEmail());
		System.out.println(db);
		System.out.println("user : " + user);
		System.out.println("login code : " + db.isBlockCode());
		String success = null;
		String fail = null;
		String ment = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 블락테이블 여부를 확인할 수 있는거 해서 있으면 메세지 띄우고
		// 없으면 그냥 로그인 되는걸로 블락여부 로긍여부 만
		if (db.isBlockCode()) {
			int result = feedback.updateBlockCode(db);

			if (result == 1) {
				if (user.getEmail().equals(db.getEmail()) && user.getPwd().equals(db.getPwd())) {
					System.out.println("result = 0 :성공");
					success = "로그인 성공";
				} else {
					System.out.println("실패");
					fail = "로그인 실패";
				}
			} else {
				System.out.println("실패");
				Block block = feedback.getBlock(db.getUserNo());
				Report report = feedback.getReportByReportNo(block.getReportNo());
				System.out.println(block);
				System.out.println(report);
				map.put("block", block);
				map.put("report", report);
				ment = "비활성화 계정";
			}
		} else {
			if (user.getEmail().equals(db.getEmail()) && user.getPwd().equals(db.getPwd())) {
				System.out.println("fasle : 성공");
				success = "로그인 성공";
			} else {
				System.out.println("실패");
				fail = "로그인 실패";
			}
		}

		map.put("success", success);
		map.put("fail", fail);
		map.put("ment", ment);
		return map;
	}

}
