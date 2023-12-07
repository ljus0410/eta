package kr.pe.eta.web.notice;

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

import kr.pe.eta.common.Page;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Notice;
import kr.pe.eta.service.notice.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	public NoticeController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@GetMapping(value = "addNotice")
	public ModelAndView addNotice() throws Exception {
		System.out.println("/notice/addNotice : GET");
		String viewName = "/notice/addNotice.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		return modelAndView;
	}

	@PostMapping(value = "addNotice")
	public ModelAndView addNotice(@ModelAttribute Notice notice) throws Exception {
		System.out.println("/notice/addNotice : POST");
		String viewName = "redirect:/notice/listNotice";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		noticeService.addNotice(notice);

		return modelAndView;
	}

	@RequestMapping(value = "listNotice")
	public ModelAndView listNotice(@ModelAttribute("search") Search search) throws Exception {
		System.out.println("/notice/listNotice : GET/POST");
		String viewName = "/notice/listNotice.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = noticeService.getNoticeList(search);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		modelAndView.addObject("noticelist", map.get("noticelist"));
		modelAndView.addObject("resultPage", resultPage);
		return modelAndView;
	}

	@RequestMapping(value = "getNotice")
	public ModelAndView getNotice(@RequestParam("noticeNo") int noticeNo) throws Exception {
		System.out.println("/notice/getNotice : GET/POST");
		String viewName = "/notice/getNotice.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		modelAndView.addObject("notice", noticeService.getNotice(noticeNo));

		return modelAndView;
	}

	@RequestMapping(value = "deleteNotice")
	public ModelAndView deleteNotice(@RequestParam("noticeNo") int noticeNo) throws Exception {
		System.out.println("/notice/delteNotice : GET/POST");
		String viewName = "redirect:/notice/listNotice";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		noticeService.deleteNotice(noticeNo);

		return modelAndView;
	}

	@GetMapping(value = "updateNotice")
	public ModelAndView updateNotice(@RequestParam("noticeNo") int noticeNo) throws Exception {
		System.out.println("/notice/updateNotice : GET");
		String viewName = "/notice/updateNotice.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		modelAndView.addObject("notice", noticeService.getNotice(noticeNo));
		return modelAndView;
	}

	@PostMapping(value = "updateNotice")
	public ModelAndView updateNotice(@ModelAttribute Notice notice) throws Exception {
		System.out.println("/notice/updateNotice : POST");
		String viewName = "redirect:/notice/listNotice";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);

		noticeService.addNotice(notice);

		return modelAndView;
	}

}
