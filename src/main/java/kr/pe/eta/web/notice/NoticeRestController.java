package kr.pe.eta.web.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Notice;
import kr.pe.eta.service.notice.NoticeService;

@RestController
@RequestMapping("/notice/json/*")
public class NoticeRestController {

	@Autowired
	private NoticeService noticeService;

	public NoticeRestController() {
		System.out.println(this.getClass());
	}

	@Value("${search.pageSize}")
	int pageSize;

	@Value("${search.pageUnit}")
	int pageUnit;

	@RequestMapping(value = "listNotice/{currentpage}")
	public List<Notice> listNotice(@RequestBody Search search) throws Exception {
		System.out.println("/notice/json/listNotice : GET/POST");

		search.setPageSize(pageSize);

		Map<String, Object> map = noticeService.getNoticeList(search);
		List<Notice> noticeList = (List<Notice>) map.get("noticelist");

		return noticeList;
	}

}
