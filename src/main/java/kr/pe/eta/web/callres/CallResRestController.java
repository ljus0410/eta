package kr.pe.eta.web.callres;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Notice;
import kr.pe.eta.service.callres.CallResService;

@RestController
@RequestMapping("/callres/json/*")
public class CallResRestController {

	@Autowired
	private CallResService callResService;

	public CallResRestController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@RequestMapping(value = "listRecord/{currentpage}")
	public List<Notice> listRecord(@RequestBody Search search) throws Exception {
		System.out.println("/callRes/json/listRecord : GET/POST");

		search.setPageSize(pageSize);

		Map<String, Object> map = callResService.getCallResList(search);
		List<Notice> calllist = (List<Notice>) map.get("list");

		return calllist;
	}

}
