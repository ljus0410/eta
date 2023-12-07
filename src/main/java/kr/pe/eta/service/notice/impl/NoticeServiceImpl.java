package kr.pe.eta.service.notice.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Notice;
import kr.pe.eta.service.notice.NoticeDao;
import kr.pe.eta.service.notice.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	public NoticeServiceImpl() {
		System.out.println(this.getClass());
	}

	public int addNotice(Notice notice) throws Exception {
		return noticeDao.addNotice(notice);
	}

	public Notice getNotice(int noticeNo) throws Exception {
		return noticeDao.getNotice(noticeNo);
	}

	public Map<String, Object> getNoticeList(Search search) throws Exception {
		List<Notice> noticelist = noticeDao.getNoticeList(search);
		int totalCount = noticeDao.getTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticelist", noticelist);
		map.put("totalCount", totalCount);
		return map;
	}

	public int updateNotice(Notice notice) throws Exception {
		return noticeDao.updateNotice(notice);
	}

	public int deleteNotice(int noticeNo) throws Exception {
		return noticeDao.deleteNotice(noticeNo);
	}

}
