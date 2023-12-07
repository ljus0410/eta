package kr.pe.eta.web.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.user.UserService;

@RestController
@RequestMapping("/user/json/*")
public class UserRestController {

	@Autowired
	private UserService userService;

	@Value("${search.pageSize}")
	private int pageSize;

	public UserRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "dupNickName/{nickName}", method = RequestMethod.GET)
	public String dupnickName(@PathVariable String nickName) throws Exception {
		System.out.println("/Json/dpuNickName : GET");

		System.out.println("nickName==" + nickName);
		boolean duplication = userService.dupNickname(nickName);
		String ment = null;
		if (duplication == true) {
			ment = "사용가능한 닉네임 입니다";
		} else {
			ment = "사용중인 닉네임 입니다";
		}
		System.out.println("result===" + duplication);

		return ment;
	}

	@RequestMapping(value = "dupEmail/{email}", method = RequestMethod.GET)
	public String dupEmail(@PathVariable String email) throws Exception {

		System.out.println("/json/dupEmail : GET");

		System.out.println("email==" + email);
		boolean duplication = userService.dupEmail(email);
		String ment = null;
		if (duplication == true) {
			ment = "사용가능한 닉네임 입니다";
		} else {
			ment = "사용중인 닉네임 입니다";
		}
		System.out.println("result===" + duplication);
		return ment;
	}

	@RequestMapping(value = "autoList", method = RequestMethod.POST)
	public ModelAndView autoautoList(@RequestBody Search search) throws Exception {

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

		for (User user : users) {
			lists.add(user.getEmail());
			userName.add(user.getName());
		}
		System.out.println("lists-=====" + lists);
		System.out.println("listName======" + userName);

		model.addObject("list", lists);
		model.addObject(userName);

		return model;

	}

}
