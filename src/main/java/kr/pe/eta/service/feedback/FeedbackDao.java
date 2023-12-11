package kr.pe.eta.service.feedback;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Blacklist;
import kr.pe.eta.domain.Block;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.Star;
import kr.pe.eta.domain.User;

@Mapper
public interface FeedbackDao {

	public int updateStar(Star star) throws Exception;

	public int getStar(Star star) throws Exception;

	public int getShareStar(Star star) throws Exception;

	public int addBlacklist(Blacklist blacklist) throws Exception;

	public int deleteBlacklist(Blacklist blacklist) throws Exception;

	public int getBlacklistCount(Blacklist blacklist) throws Exception;

	public int addReport(Report report) throws Exception;

	public Call getCall(int callNo) throws Exception;

	public List<Report> getReport(Report report) throws Exception;

	public List<Report> getReportList(Search search) throws Exception;

	public int updateReportCode(int reportNo) throws Exception;

	public int updateDisReportCode(int reportNo) throws Exception;

	public int getReportCode(int reportNo) throws Exception;

	public int addBlock(Block block) throws Exception;

	public int getBlockCount(Block block) throws Exception;

	public int updateBlockCode(User user) throws Exception;

	public Block getUnblockDate(User user) throws Exception;

	public int avgStar(User user) throws Exception;

	public int updateShareStar(Star star) throws Exception;

	public int getCallNo(User user) throws Exception;

	public int getDriverNoByCallNo(int callNo) throws Exception;

	public List<Report> getUserReportList(Search search) throws Exception;

	public int getUserReportTotalCount(Search search) throws Exception;

	public int getReportTotalCount(Search search) throws Exception;

	public int getPassNoByCallNo(int callNo) throws Exception;

	public List<Blacklist> getBlacklistList(int callno) throws Exception;

	public List<Report> getShareReport(Report report) throws Exception;

	public int addBlockCode(Block block) throws Exception;
}
