package kr.pe.eta.service.feedback;

import java.util.Map;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Blacklist;
import kr.pe.eta.domain.Block;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.Star;
import kr.pe.eta.domain.User;

public interface FeedbackService {
	public int addStar(Star star) throws Exception;

	public int updateStar(Star star) throws Exception;

	public Star getStar(Star star) throws Exception;

	public Star getShareStar(Star star) throws Exception;

	public int addBlacklist(Blacklist blacklist) throws Exception;

	public int deleteBlacklist(Blacklist blacklist) throws Exception;

	public Blacklist getBlacklist(Blacklist blacklist) throws Exception;

	public int addReport(Report report) throws Exception;

	public Call getCall(int callNo) throws Exception;

	public Map<String, Object> getReport(Report report) throws Exception;

	public Map<String, Object> getReportList(Search search) throws Exception;

	public int updateReportCode(int reportNo) throws Exception;

	public int updateDisReportCode(int reportNo) throws Exception;

	public Report getReportCode(int reportNo) throws Exception;

	public int addBlock(Block block) throws Exception;

	public int updateBlockCode(User user) throws Exception;

	public int avgStar(User user) throws Exception;

	public int addShareStar(Star star) throws Exception;

	public int updateShareStar(Star star) throws Exception;

}
