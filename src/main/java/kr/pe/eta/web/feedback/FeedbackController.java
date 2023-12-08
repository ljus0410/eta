package kr.pe.eta.web.feedback;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Blacklist;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.Star;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.feedback.FeedbackService;

@Controller
@RequestMapping("/feedback/*")
public class FeedbackController {

	@Autowired
	private FeedbackService feedbackService;

	public FeedbackController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@GetMapping(value = "addStar")
	public ModelAndView addStar(HttpSession session) throws Exception {
		System.out.println("/feedback/addStar : GET");
		String viewName = "/feedback/addStar.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		User user = (User) session.getAttribute("user");
		int callNo = feedbackService.getCallNo(user);
		int driverNo = feedbackService.getDriverNoByCallNo(callNo);
		Star star = Star.builder().callNo(callNo).driverNo(driverNo).build();

		modelAndView.addObject("star", star);
		return modelAndView;
	}

	@PostMapping(value = "addStar")
	public ModelAndView addStar(@ModelAttribute Star star, HttpSession session) throws Exception {
		System.out.println("/feedback/addStar : POST");
		String viewName = "home.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		star.setPassengerNo(((User) session.getAttribute("user")).getUserNo());
		Call call = feedbackService.getCall(star.getCallNo());

		if (call.getCallCode().equals("S"))
			feedbackService.addShareStar(star);
		else
			feedbackService.addStar(star);

		return modelAndView;
	}

	@GetMapping(value = "updateStar")
	public ModelAndView updateStar(HttpSession session) throws Exception {
		System.out.println("/feedback/updateStar : GET");
		String viewName = "/feedback/updateStar.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		User user = (User) session.getAttribute("user");
		int callNo = feedbackService.getCallNo(user);
		int driverNo = feedbackService.getDriverNoByCallNo(callNo);
		Star star = Star.builder().callNo(callNo).driverNo(driverNo).build();
		int starCount = 0;
		star.setPassengerNo(((User) session.getAttribute("user")).getUserNo());
		Call call = feedbackService.getCall(star.getCallNo());

		starCount = call.getCallCode().equals("S") ? feedbackService.getShareStar(star) : feedbackService.getStar(star);

		star.setStar(starCount);
		System.out.println(star);
		modelAndView.addObject("star", star);
		return modelAndView;
	}

	@GetMapping(value = "addReport")
	public ModelAndView addReport(@RequestParam("badCallNo") int badCallNo) throws Exception {
		System.out.println("/feedback/addReport : GET");
		String viewName = "/feedback/addReport.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("badCallNo", badCallNo);
		return modelAndView;
	}

	@RequestMapping(value = "listReport")
	public ModelAndView listReport(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		System.out.println("/feedback/listReport : GET/POST");
		String viewName = "/feedback/listReport.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		User user = (User) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();

		if (user.getRole().equals("admin")) {
			map = feedbackService.getReportList(search);
		} else {
			search.setSearchKeyword("" + user.getUserNo());
			map = feedbackService.getUserReportList(search);
		}

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		modelAndView.addObject("reportlist", map.get("reportlist"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
	}

	@RequestMapping(value = "getReport")
	public ModelAndView getNotice(@RequestParam("reportNo") int reportNo, @RequestParam("badCallNo") int badCallNo,
			@RequestParam("reportRole") String reportRole, HttpSession session) throws Exception {
		System.out.println("/feedback/getReport : GET/POST");
		String viewName = "/feedback/getReport.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		User user = (User) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		Report report = Report.builder().reportNo(reportNo).badCallNo(badCallNo).reportRole(reportRole).build();

		if (user.getRole().equals("admin") & feedbackService.getReportCode(reportNo) == 1)
			feedbackService.updateReportCode(reportNo);

		map = feedbackService.getReport(report);
		modelAndView.addObject("reportlist", map.get("reportlist"));

		return modelAndView;
	}

	@GetMapping(value = "addBlacklist")
	public ModelAndView addBlacklist(HttpSession session) throws Exception {
		System.out.println("/feedback/addBlacklist : GET");
		String viewName = "/feedback/addBlacklist.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		User user = (User) session.getAttribute("user");
		int callNo = feedbackService.getCallNo(user);
		int userNo = feedbackService.getPassNoByCallNo(callNo);
		Call call = feedbackService.getCall(callNo);
		List<Blacklist> blacklistList = new ArrayList<>();

//		if (!call.getCallCode().equals("S")) {
//			Blacklist blacklist = Blacklist.builder().driverNo(user.getUserNo()).passengerNo(userNo).callNo(callNo)
//					.build();
//			blacklistList.add(0, feedbackService.getBlacklist(blacklist));
//			System.out.println("합승아님");
//
//		} else {
		System.out.println("합승임");
		blacklistList = feedbackService.getBlacklistList(1001);

		for (int i = 0; i < blacklistList.size(); i++) {
			feedbackService.getBlacklist(blacklistList.get(i));

//			}

		}
		modelAndView.addObject("blacklistList", blacklistList);

		return modelAndView;
	}

	// update또한 현재는 최신배차만 가능 why? 이용기록 또는 운행기록을 통해서 들어오기떄문에 get이 필요없음
	@GetMapping(value = "updateBlacklist")
	public ModelAndView updateBlacklist(HttpSession session) throws Exception {
		System.out.println("/feedback/updateBlacklist : GET");
		String viewName = "/feedback/updateBlacklist.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		User user = (User) session.getAttribute("user");
		int callNo = feedbackService.getCallNo(user);
		int userNo = feedbackService.getPassNoByCallNo(callNo);
		Blacklist blacklist = Blacklist.builder().driverNo(user.getUserNo()).passengerNo(userNo).callNo(callNo).build();
		blacklist = feedbackService.getBlacklist(blacklist);
		modelAndView.addObject("blacklist", blacklist);
		return modelAndView;
	}

}
