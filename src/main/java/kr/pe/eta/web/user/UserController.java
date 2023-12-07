package kr.pe.eta.web.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.geo.Point;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.RedisEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.feedback.FeedbackService;
import kr.pe.eta.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private FeedbackService feedback;

	private final RedisService redisService; // RedisService 필드 추가

	@Value("${search.pageSize}")
	private int pageSize;

	@Value("${kakao.redirect}")
	private String redirect;

	private RedisService redisService = null;

	public UserController() {

		this.redisService = redisService; // 여기 추가
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mv) throws Exception {

		System.out.println("/user/login : GET");

		mv.setViewName("redirect:/user/loginView.jsp");

		return mv;

	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/login : POST");
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("user" + user);
		User db = userService.getUser(user.getEmail());

		System.out.println(db);
		System.out.println("code" + db.isBlockCode());

		Point location = userService.calculateRandomLocation();
		double X = location.getX();
		System.out.println("X : " + X);
		double Y = location.getY();
		System.out.println("Y : " + Y);

		if (user.getPwd().equals(db.getPwd()) && user.isBlockCode() == false) {
			RedisEntity redisEntity = new RedisEntity();
			redisEntity.setId(db.getEmail());
			redisEntity.setCurrentX(X);
			redisEntity.setCurrentY(Y);
			redisService.addUser(redisEntity);
			session.setAttribute("user", db);
		}

		modelAndView.setViewName("redirect:/user/getUser.jsp");
		return modelAndView;
	}

	@RequestMapping(value = "addUser", method = RequestMethod.GET)
	public ModelAndView addUser() throws Exception {
		System.out.println("/user/addUser : GET");
		ModelAndView model = new ModelAndView();

		model.setViewName("redirect:/user/addUserView.jsp");

		return model;
	}

	@RequestMapping(value = "addUser", method = RequestMethod.POST)
	public ModelAndView addUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		System.out.println("/user/addUser: POST");

		ModelAndView model = new ModelAndView();

		userService.addUser(user);
		session.setAttribute("user", user);

		model.setViewName("forward:/user/home.jsp");
		return model;

	}

	@RequestMapping(value = "getUser", method = RequestMethod.GET)
	public ModelAndView getUser(@RequestParam("email") String eamil) throws Exception {
		System.out.println("/user/getUser : POST");
		ModelAndView model = new ModelAndView();

		User user = userService.getUser(eamil);

		model.setViewName("forward:/home.jsp");
		model.addObject("user", user);
		return model;

	}

	@RequestMapping(value = "updateUser", method = RequestMethod.GET)
	public ModelAndView updateUserView(@RequestParam("email") String eamil, HttpSession session) throws Exception {
		System.out.println("/user/updateUser : POST");
		ModelAndView model = new ModelAndView();

		User User = userService.getUser(eamil);

		model.setViewName("forward:/user/updateUserView.jsp");
		model.addObject("user", User);
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

	@RequestMapping(value = "logout", method = RequestMethod.POST)
	public ModelAndView logout(HttpSession session) throws Exception {
		System.out.println("/user/logout : POST");
		ModelAndView model = new ModelAndView();
		redisService.deleteUser(session);// 추가
		session.invalidate();

		model.setViewName("redirect:/home.jsp");
		return model;
	}

	@RequestMapping(value = "listUser", method = RequestMethod.GET)
	public ModelAndView getUserList(Search search) throws Exception {
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
}
