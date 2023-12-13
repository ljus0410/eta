package kr.pe.eta.web.user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.geo.Point;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.RedisEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.callreq.CallReqService;
import kr.pe.eta.service.feedback.FeedbackService;
import kr.pe.eta.service.user.KakaoProfile;
import kr.pe.eta.service.user.LoginService;
import kr.pe.eta.service.user.NaveLoginProfile;
import kr.pe.eta.service.user.NaverToken;
import kr.pe.eta.service.user.OAuthToken;
import kr.pe.eta.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private FeedbackService feedback;

	@Autowired
	private LoginService loginService;

	@Autowired
	private CallReqService callReqService;

	@Value("${search.pageSize}")
	private int pageSize;

	@Value("${naver.baseUrl}")
	String baseUrl;

	@Value("${naver.clientId}")
	String clientId;

	@Value("${naver.redirectUrl}")
	String redirectUrl;

	@Value("${naver.Secret}")
	String Secret;

	@Value("${kakao.clienId}")
	String kaclienId;

	@Value("${kakao.redirect}")
	String karedirect;

	@Value("${kakao.scope}")
	String scope;

	@Value("${kakao.url}")
	String url;

	@Value("${kakao.logout}")
	String logout;

	private final RedisService redisService;

	public UserController(RedisService redisService) {
		this.redisService = redisService; // 여기 추가
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mv) throws Exception {

		System.out.println("/user/login : GET");

		mv.setViewName("redirect:/user/login.jsp");

		return mv;

	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/login : POST");
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("user : " + user);
		User db = userService.getUser(user.getEmail());

		System.out.println(db);
		System.out.println("login code : " + db.isBlockCode());

		Point location = userService.calculateRandomLocation();
		double X = location.getX();
		System.out.println("X : " + X);
		double Y = location.getY();
		System.out.println("Y : " + Y);

		if (db.getRole().equals("driver")) {
			RedisEntity redisEntity = new RedisEntity();
			String userNo = String.valueOf(db.getUserNo());
			redisEntity.setId(userNo);
			redisEntity.setCurrentX(X);
			redisEntity.setCurrentY(Y);
			redisService.addUser(redisEntity);
		}

		if (db.isBlockCode()) {
			// feedback 로직
			int result = feedback.updateBlockCode(db);
			System.out.println("UpdateCode : " + feedback.updateBlockCode(db));

			// 다시 code 확인
			if (result == 1) {
				// 블록 코드가 false이면 로그인 로직을 타게 하거나 다른 처리를 수행
				if (user.getEmail().equals(db.getEmail()) && user.getPwd().equals(db.getPwd())) {
					session.setAttribute("user", db);
					System.out.println("로그인성공");
					session.setAttribute("user", db);
					modelAndView.setViewName("redirect:/home.jsp");
				}
				System.out.println("로그인실패");
				modelAndView.setViewName("redirect:/home.jsp");
			} else {
				// 여전히 true인 경우, home 화면으로 이동
				System.out.println("로그인실패");
				modelAndView.setViewName("redirect:/home.jsp");
			}
		} else {
			// 코드가 이미 false인 경우, 로그인 로직 수행
			if (user.getEmail().equals(db.getEmail()) && user.getPwd().equals(db.getPwd())) {
				session.setAttribute("user", db);
				System.out.println("로그인성공");
				modelAndView.addObject("successMessage", "로그인 성공");
				modelAndView.setViewName("redirect:/home.jsp");
			}
			System.out.println("로그인실패");
			modelAndView.setViewName("redirect:/home.jsp");
		}

		return modelAndView;
	}

	@RequestMapping(value = "addUser", method = RequestMethod.GET)
	public ModelAndView addUser() throws Exception {
		System.out.println("/user/addUser : GET");
		ModelAndView model = new ModelAndView();

		model.setViewName("redirect:/user/addUser.jsp");

		return model;
	}

	@RequestMapping(value = "addUser", method = RequestMethod.POST)
	public ModelAndView addUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		System.out.println("/user/addUser: POST");

		ModelAndView model = new ModelAndView();

		userService.addUser(user);
		session.setAttribute("user", user);
		User newuser = userService.getUser(user.getEmail());
		if (newuser.getRole().equals("passenger")) {
			callReqService.addLikeList(newuser.getUserNo());
		}
		System.out.println("방금 만든 회원 : " + userService.getUser(user.getEmail()));
		System.out.println("즐겨찾기 보자 : " + callReqService.getLikeList(newuser.getUserNo()));
		model.setViewName("forward:/user/home.jsp");
		return model;

	}

	@RequestMapping(value = "/getUser", method = RequestMethod.GET)
	public ModelAndView getUser(@RequestParam(name = "email", required = false) String email,
			@RequestParam(name = "userNo", required = false) Integer userNo) throws Exception {
		System.out.println("/user/getUser : GET");
		ModelAndView model = new ModelAndView();
		User user = null;

		if (email == null) {
			user = userService.getUsers(userNo);
		} else {
			user = userService.getUser(email);
		}

		System.out.println("userInfo = " + user);
		model.setViewName("forward:/user/getUser.jsp");
		model.addObject("user", user);
		return model;
	}

	@RequestMapping(value = "updateUser", method = RequestMethod.GET)
	public ModelAndView updateUserView(@RequestParam("email") String eamil, HttpSession session) throws Exception {
		System.out.println("/user/updateUser : POST");
		ModelAndView model = new ModelAndView();

		model.setViewName("forward:/user/updateUserView.jsp");
		return model;
	}

	@RequestMapping(value = "updateUser", method = RequestMethod.POST)
	public ModelAndView updateUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		System.out.println("/user/updateUser : POST");
		ModelAndView model = new ModelAndView();

		userService.updateUser(user);

		String sessionEmail = ((User) session.getAttribute("user")).getEmail();
		if (sessionEmail.equals(user.getEmail())) {
			session.setAttribute("user", user);
		}

		model.setViewName("forward:/user/home.jsp");
		return model;
	}

	@RequestMapping(value = "updatePwd", method = RequestMethod.GET)
	public ModelAndView updatePwdView(@RequestParam("email") String eamil) throws Exception {
		System.out.println("/user/updatePwd : GET");
		ModelAndView model = new ModelAndView();

		User user = userService.getUser(eamil);

		model.setViewName("forward:/user/updatepwd.jsp");
		model.addObject("user", user);
		return model;

	}

	@RequestMapping(value = "updatePwd", method = RequestMethod.POST)
	public ModelAndView updatePwd(@ModelAttribute("user") User user) throws Exception {
		System.out.println("/user/updatePwd : POST");
		ModelAndView model = new ModelAndView();

		userService.updatePwd(user);

		model.setViewName("forward:/user/home.jsp");
		return model;

	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpSession session) throws Exception {
		System.out.println("/user/logout : GET");
		ModelAndView model = new ModelAndView();
		// redisService.deleteUser(session);// 추가
		session.invalidate();

		model.setViewName("redirect:/home.jsp");
		return model;
	}

	@RequestMapping(value = "listUser", method = RequestMethod.GET)
	public ModelAndView getUserList(@ModelAttribute("search") Search search) throws Exception {
		System.out.println("/user/listUser : POST");
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		userService.getUserList(search);
		ModelAndView model = new ModelAndView();

		Map<String, Object> map = userService.getUserList(search);
		System.out.println("map");
		User user = new User();

		System.out.println("code" + user.isBlockCode());
		model.addObject("list", map.get("list"));
		model.addObject("passenger", map.get("passengertotalCount"));
		model.addObject("driver", map.get("drivertotalCount"));
		model.setViewName("forward:/user/listUser.jsp");
		model.addObject("search", search);

		return model;

	}

	@RequestMapping(value = "deleteUserView", method = RequestMethod.GET)
	public ModelAndView deleteUserVuew(@RequestParam("email") String email, ModelAndView model) throws Exception {
		System.out.println("/user/deleteUser : GET");

		User user = userService.getUser(email);
		model.setViewName("forward:/user/delete.jsp");
		model.addObject("user", user);
		return model;

	}

	@RequestMapping(value = "deleteUser", method = RequestMethod.POST)
	public ModelAndView deleteUser(@RequestParam("detailPwd") String detailPwd, @RequestParam("email") String email)
			throws Exception {

		System.out.println("/user/deleteUser : POST");

		User user = userService.getUser(email);
		if (user.getPwd().equals(detailPwd)) {
			userService.deleteUser(email);
		}
		ModelAndView model = new ModelAndView();

		model.setViewName("redirect:/home.jsp");
		return model;

	}

	@GetMapping("/auth/kakao/callback")
	public @ResponseBody ModelAndView kakaoCallback(String code, HttpSession session) throws Exception {// Data를 리턴해주는
																										// 컨트롤러
		System.out.println("카카오톡 로그인");
		// Post방식으로 key=value 데이터를 요청(카카오쪽으로)
		// HttpURLConnection
		// RestTemplate

		RestTemplate rt = new RestTemplate();

		// HttpHeaders 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HttBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", kaclienId);
		params.add("redirect_uri", karedirect);
		params.add("code", code);

		// HttpHeaders 와 HttBody룰 하나의 오브젝트에 담기 request
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

		// 요청부분 Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange( // exchange가 HttpEntity를 담음
				"https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class// 응답받을 데이터
		);
		// gson, Jsonsimple, objectmapper 라이브러리
		// accessToken 매핑
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		System.out.println("oauthToken" + oauthToken.getAccess_token());
		RestTemplate rt2 = new RestTemplate();

		// HttpHeaders 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HttpHeaders 와 HttBody룰 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoprofileRequest2 = new HttpEntity<>(headers2);

		// 요청부분 Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음
		ResponseEntity<String> response2 = rt2.exchange( // exchange가 HttpEntity를 담음
				"https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoprofileRequest2, String.class);

		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoprofile = null;
		try {
			kakaoprofile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		// body만 보는거
		ModelAndView model = new ModelAndView();
		String email = kakaoprofile.getKakao_account().getEmail();
		User user = userService.getUser(email);
		if (user != null && email.equals(user.getEmail())) {
			session.setAttribute("user", user);
			model.setViewName("redirect:/user/home.jsp");
		} else {
			model.setViewName("redirect:/user/addUser.jsp");
		}

		// User
		System.out.println("kakaoprofile ID" + kakaoprofile.getId());
		System.out.println("kakaoprofile Email" + kakaoprofile.getKakao_account().getEmail());

		model.addObject("kakaoProfile", kakaoprofile);
		return model;
	}

	@GetMapping("/auth/naver/callback")
	public @ResponseBody ModelAndView callBack(String code, String state, HttpSession session,
			HttpServletResponse response) throws Exception {
		System.out.println("네이버 로그인");
		RestTemplate restTemplate = new RestTemplate();

		// Naver OAuth 토큰 요청 URL
		String naverTokenUrl = "https://nid.naver.com/oauth2.0/token";

		// 요청 파라미터 설정
		MultiValueMap<String, String> naverTokenParams = new LinkedMultiValueMap<>();
		naverTokenParams.add("grant_type", "authorization_code");
		naverTokenParams.add("client_id", clientId);
		naverTokenParams.add("client_secret", Secret);
		naverTokenParams.add("code", code);
		naverTokenParams.add("state", state);

		// 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		// HttpEntity 생성
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(naverTokenParams, headers);

		// 요청 보내기
		ResponseEntity<String> naverTokenResponse = restTemplate.exchange(naverTokenUrl, HttpMethod.POST,
				naverTokenRequest, String.class);

		ObjectMapper objectmapper = new ObjectMapper();
		NaverToken naverToken = null;

		try {
			naverToken = objectmapper.readValue(naverTokenResponse.getBody(), NaverToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		String naverAccessToken = naverToken.getAccess_token();
		Cookie cookie = new Cookie("naverAccessToken", naverAccessToken);
		cookie.setMaxAge(60 * 60); // 쿠키 만료 시간 설정 (예: 1시간)
		cookie.setPath("/");
		response.addCookie(cookie);
		// 응답 확인
		System.out.println("getAccess_token" + naverToken.getAccess_token());
		System.out.println("naverToken.getToken_type()" + naverToken.getToken_type());

		RestTemplate rt2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", naverToken.getToken_type() + " " + naverToken.getAccess_token());

		String naverTokenUrl2 = "https://openapi.naver.com/v1/nid/me";

		HttpEntity<String> naverTokenRequest2 = new HttpEntity<>(null, headers2);

		ResponseEntity<String> response2 = rt2.exchange(naverTokenUrl2, HttpMethod.POST, naverTokenRequest2,
				String.class

		);// exchange가 HttpEntity를 담음
		System.out.println("결과값 : " + response2.getBody());
		ObjectMapper objectMapper2 = new ObjectMapper();
		NaveLoginProfile naverProfile = null;
		try {
			naverProfile = objectMapper2.readValue(response2.getBody(), NaveLoginProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		ModelAndView model = new ModelAndView();
		String email = naverProfile.getResponse().getEmail();
		User user = userService.getUser(email);
		if (user != null && email.equals(user.getEmail())) {
			session.setAttribute("user", user);
			model.setViewName("redirect:/user/home.jsp");
		} else {
			model.setViewName("redirect:/user/addUser.jsp");
		}
		System.out.println("email" + naverProfile.getResponse().getEmail());
		model.addObject("naverProfile", naverProfile);
		return model;

	}

	@GetMapping("/kakao-login")
	public void kakao(HttpServletRequest request, HttpServletResponse response)
			throws MalformedURLException, UnsupportedEncodingException, URISyntaxException {
		System.out.println("kakao-login");
		String url = loginService.kakaoUrl("authorize");
		System.out.println("url========" + url);
		try {
			response.sendRedirect(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/naver-login")
	public void naverLogin(HttpServletRequest request, HttpServletResponse response)
			throws MalformedURLException, UnsupportedEncodingException, URISyntaxException {
		System.out.println("naver-login");
		String url = loginService.getNaverAuthorizeUrl("authorize");
		try {
			response.sendRedirect(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/kakao-logOut")
	public ModelAndView kakaoLoOut(@RequestParam(name = "token", required = false) String access_token,
			HttpServletRequest request, HttpServletResponse response, HttpServletRequest request1)
			throws MalformedURLException, UnsupportedEncodingException, URISyntaxException {
		System.out.println("kakao-logout");
		System.out.println("token : " + access_token);

		ModelAndView modelAndView = new ModelAndView();

		if (access_token == null) {
			try {
				// access_token이 null인 경우 Kakao 로그아웃 URL 생성 및 리다이렉트
				String url = loginService.kakaoLoOut(request1);
				modelAndView.setViewName("redirect:/home.jsp");
			} catch (IOException e) {
				e.printStackTrace(); // 또는 로깅 등의 적절한 예외 처리 로직을 추가할 수 있습니다.
			}

		} else {
			// access_token이 null이 아닌 경우 Naver 로그아웃 URL 생성 및 리다이렉트
			String url = loginService.naverLoOut(access_token, request1, response);
			modelAndView.setViewName("redirect:/home.jsp");
		}

		return modelAndView;
	}

	@GetMapping("/auth/kakao/logout")
	public @ResponseBody ModelAndView logOut(HttpSession session) throws Exception {
		System.out.println("카카오 로그아웃 컨트롤");
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/user/login.jsp");
		// redisService.deleteUser(session);// 추가
		session.invalidate();

		return model;
	}

//	@GetMapping("naverLogout")
//	public void naverLogout(@RequestParam("token") String access_token, HttpServletResponse response) throws Exception {
//		System.out.println("token : " + access_token);
//		String url = loginService.naverLoOut(access_token);
//		try {
//			response.sendRedirect(url);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//	}

}
