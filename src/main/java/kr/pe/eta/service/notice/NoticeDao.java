package kr.pe.eta.service.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Notice;

@Mapper
public interface NoticeDao {

	public int addNotice(Notice notice) throws Exception;

	public Notice getNotice(int noticeNo) throws Exception;

	public List<Notice> getNoticeList(Search search) throws Exception;

	public int updateNotice(Notice notice) throws Exception;

	public int deleteNotice(int noticeNo) throws Exception;

	public int getTotalCount(Search search) throws Exception;

}
