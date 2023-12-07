package kr.pe.eta.web.callreq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.pe.eta.service.callreq.CallReqService;

@RestController
@RequestMapping("/callreq/json/*")
public class CallReqRestController {

	@Autowired
	private CallReqService callReqService;

	public CallReqRestController() {
		System.out.println(this.getClass());
	}

}
