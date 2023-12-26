package kr.pe.eta.web.callres;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Notice;
import kr.pe.eta.domain.User;
import kr.pe.eta.redis.AddCallEntity;
import kr.pe.eta.redis.RedisService;
import kr.pe.eta.service.callres.CallResService;

@RestController
@RequestMapping("/callres/json/*")
public class CallResRestController {

	@Autowired
	private CallResService callResService;

	@Autowired
	private final RedisService redisService;

	public CallResRestController(RedisService redisService) {
		this.redisService = redisService;
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@RequestMapping(value = "listCallRecord/{currentpage}")
	public List<Notice> listCallRecord(@RequestBody Search search, @RequestParam("month") String month)
			throws Exception {
		System.out.println("/callRes/json/listRecord : GET/POST");

		search.setPageSize(pageSize);

		Map<String, Object> map = callResService.getCallResList(search, month);
		List<Notice> calllist = (List<Notice>) map.get("list");

		return calllist;
	}

	@RequestMapping(value = "listRecord/{currentpage}")
	public List<Notice> listRecord(@RequestBody Search search, HttpSession session, String month) throws Exception {
		System.out.println("/callRes/json/listRecord : GET/POST");
		int userNo = ((User) session.getAttribute("user")).getUserNo();

		search.setPageSize(pageSize);

		Map<String, Object> map = callResService.getRecordList(search, userNo, month);
		List<Notice> calllist = (List<Notice>) map.get("list");

		return calllist;
	}

	@RequestMapping(value = "getRequest")
	public Call getRequest(Model model, HttpSession session) throws Exception {
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		String driverNo = String.valueOf(userNo);
		AddCallEntity callRequest = redisService.getCallById(driverNo);
		int callNo = callRequest.getCallNo();
		Call call = callResService.getCallByNo(callNo);

		return call;
	}

	@RequestMapping(value = "deleteRequest/{callNo}")
	public void deleteRequest(@PathVariable int callNo, Model model, HttpSession session) throws Exception {
		int userNo = ((User) session.getAttribute("user")).getUserNo();
		String driverNo = String.valueOf(userNo);
		AddCallEntity deleteEntity = new AddCallEntity();
		deleteEntity.setCallNo(callNo);
		deleteEntity.setId(driverNo);
		redisService.deleteCall(deleteEntity);
	}

}
