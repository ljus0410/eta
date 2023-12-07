package kr.pe.eta.web.feedback;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.pe.eta.service.feedback.FeedbackService;

@RestController
@RequestMapping("/feedback/json/*")
public class FeedbackRestController {

	@Autowired
	private FeedbackService feedbackService;

	public FeedbackRestController() {
		System.out.println(this.getClass());
	}

}
