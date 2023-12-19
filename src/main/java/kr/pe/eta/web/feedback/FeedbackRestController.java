package kr.pe.eta.web.feedback;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Blacklist;
import kr.pe.eta.domain.Block;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.Star;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.feedback.FeedbackService;

@RestController
@RequestMapping("/feedback/json/*")
public class FeedbackRestController {

	@Autowired
	private FeedbackService feedbackService;

	public FeedbackRestController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@PostMapping(value = "addStar")
	public void addStar(@RequestBody Star star, HttpSession session) throws Exception {
		System.out.println("/feedback/json/addStar : POST");

		System.out.println(star);
		star.setPassengerNo(((User) session.getAttribute("user")).getUserNo());
		Call call = feedbackService.getCall(star.getCallNo());

		if (call.getCallCode().equals("S"))
			feedbackService.addShareStar(star);
		else
			feedbackService.addStar(star);

	}

	@PostMapping(value = "updateStar")
	public void updateStar(@RequestBody Star star, HttpSession session) throws Exception {
		System.out.println("/feedback/json/updateStar : POST");
		User user = (User) session.getAttribute("user");
		Call call = feedbackService.getCall(star.getCallNo());

		star.setPassengerNo(user.getUserNo());
		System.out.println("//" + star);
		int result = call.getCallCode().equals("S") ? feedbackService.updateShareStar(star)
				: feedbackService.updateStar(star);

	}

	@PostMapping(value = "addReport")
	public void addReport(@RequestBody Report report, HttpSession session) throws Exception {
		System.out.println("/feedback/json/addReport : POST");
		User user = (User) session.getAttribute("user");
		System.out.println(user);
		System.out.println(report);
		report.setReportUserNo(user.getUserNo());
		report.setReportRole(user.getRole());
		System.out.println(report);
		feedbackService.addReport(report);

	}

	@PostMapping(value = "updateDisReportCode")
	public void updateDisReportCode(@RequestBody Report report) throws Exception {
		System.out.println("/feedback/json/updateDisReportCode : POST");

		System.out.println(report);
		feedbackService.updateDisReportCode(report.getReportNo());

	}

	@GetMapping(value = "addBlock/{userNo}")
	public int addBlock(@PathVariable int userNo) throws Exception {
		Block block = Block.builder().userNo(userNo).build();
		return feedbackService.addBlock(block);
	}

	@PostMapping(value = "addBlacklist")
	public ResponseEntity<Integer> addBlacklist(@RequestBody Blacklist blacklist) throws Exception {
		System.out.println("/feedback/json/addBlacklist : POST");

		blacklist = feedbackService.getBlacklist(blacklist);
		int result = !blacklist.isBlacklistCode() ? feedbackService.addBlacklist(blacklist) : 0;

		return ResponseEntity.ok(result);

	}

	@PostMapping(value = "deleteBlacklist")
	public ResponseEntity<Integer> deleteBlacklist(@RequestBody Blacklist blacklist) throws Exception {
		System.out.println("/feedback/json/deleteBlacklist : POST");

		blacklist = feedbackService.getBlacklist(blacklist);
		int result = blacklist.isBlacklistCode() ? feedbackService.deleteBlacklist(blacklist) : 0;

		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = "listReport")
	public List<Report> listReport(@RequestBody Search search, HttpSession session) throws Exception {
		System.out.println("/feedback/json/listReport : GET/POST");
		;
		search.setPageSize(pageSize);
		System.out.println(search);

		Map<String, Object> map = feedbackService.getReportList(search);

		List<Report> reportList = (List<Report>) map.get("reportlist");
		System.out.println("////" + reportList);
		return reportList;
	}

}
