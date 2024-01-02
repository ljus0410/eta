package kr.pe.eta.web.callreq;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@Transactional
	@RequestMapping(value = "updateCount", method = RequestMethod.POST)
	public Map<String, Object> updateCount() throws Exception {
		Map<String, Object> responseMap = new HashMap<>();
		System.out.println("1111");
		callReqService.updateCount();

		int visitCount = callReqService.getCount();
		System.out.println("getCount111: " + visitCount);

		responseMap.put("visitCount", visitCount);
		responseMap.put("success", true);

		return responseMap;
	}

}
