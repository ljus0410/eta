package kr.pe.eta.service.feedback.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Blacklist;
import kr.pe.eta.domain.Block;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Report;
import kr.pe.eta.domain.Star;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.feedback.FeedbackDao;
import kr.pe.eta.service.feedback.FeedbackService;

@Service
public class FeedbackServiceImpl implements FeedbackService {

	@Autowired
	private FeedbackDao feedbackDao;

	public FeedbackServiceImpl() {
		System.out.println(this.getClass());
	}

	public int addStar(Star star) throws Exception {
		return feedbackDao.updateStar(star);
	}

	public int updateStar(Star star) throws Exception {
		return feedbackDao.updateStar(star);
	}

	public int getStar(Star star) throws Exception {
		return feedbackDao.getStar(star);
	}

	public int getShareStar(Star star) throws Exception {
		return feedbackDao.getShareStar(star);
	}

	public int addBlacklist(Blacklist blacklist) throws Exception {
		return feedbackDao.addBlacklist(blacklist);
	}

	public int deleteBlacklist(Blacklist blacklist) throws Exception {
		return feedbackDao.deleteBlacklist(blacklist);
	}

	public Blacklist getBlacklist(Blacklist blacklist) throws Exception {
		int blacklistCount = feedbackDao.getBlacklistCount(blacklist);

		if (blacklistCount == 0) {
			// blacklist1 = new Blacklist();
			blacklist.setBlacklistCode(false);
			;
		} else {
			blacklist.setBlacklistCode(true);
		}
		return blacklist;
	}

	public int addReport(Report report) throws Exception {
		return feedbackDao.addReport(report);
	}

	public Map<String, Object> getReport(Report report) throws Exception {

		List<Report> reportlist = feedbackDao.getReport(report);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportlist", reportlist);
		return map;
	}

	public Map<String, Object> getReportList(Search search) throws Exception {

		List<Report> reportlist = feedbackDao.getReportList(search);
		int totalCount = feedbackDao.getReportTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportlist", reportlist);
		map.put("totalCount", totalCount);
		return map;

	}

	public Call getCall(int callNo) throws Exception {
		return feedbackDao.getCall(callNo);
	}

	public int updateReportCode(int reportNo) throws Exception {
		return feedbackDao.updateReportCode(reportNo);
	}

	public int updateDisReportCode(int reportNo) throws Exception {
		return feedbackDao.updateDisReportCode(reportNo);
	}

	public int getReportCode(int reportNo) throws Exception {
		return feedbackDao.getReportCode(reportNo);
	}

	public int addBlock(Block block) throws Exception {
		block.setBlockCount(feedbackDao.getBlockCount(block));

		if (block.getBlockCount() < 4) {
			feedbackDao.addBlock(block);
			feedbackDao.addBlockCode(block);
		}
		return block.getBlockCount();
	}

	public int updateBlockCode(User user) throws Exception {
		Block block = feedbackDao.getUnblockDate(user);
		Date now = new Date();
		if (block.getUnblockDate().before(now)) {
			return feedbackDao.updateBlockCode(user);
		} else {
			return 0;
		}

	}

	public int avgStar(User user) throws Exception {
		return feedbackDao.avgStar(user);
	}

	public int addShareStar(Star star) throws Exception {
		return feedbackDao.updateShareStar(star);
	}

	public int updateShareStar(Star star) throws Exception {
		return feedbackDao.updateShareStar(star);
	}

	public int getCallNo(User user) throws Exception {
		return feedbackDao.getCallNo(user);
	}

	public int getDriverNoByCallNo(int callNo) throws Exception {
		return feedbackDao.getDriverNoByCallNo(callNo);
	}

	public Map<String, Object> getUserReportList(Search search) throws Exception {

		List<Report> reportlist = feedbackDao.getUserReportList(search);

		int totalCount = feedbackDao.getUserReportTotalCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportlist", reportlist);
		map.put("totalCount", totalCount);
		return map;
	}

	public int getPassNoByCallNo(int callNo) throws Exception {
		return feedbackDao.getPassNoByCallNo(callNo);
	}

	public List<Blacklist> getBlacklistList(int callno) throws Exception {

//		List<Report> blacklistList = feedbackDao.getBlacklistList(callno);
//
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("blacklistList", blacklistList);

		return feedbackDao.getBlacklistList(callno);
	}

	public Map<String, Object> getShareReport(Report report) throws Exception {

		List<Report> reportlist = feedbackDao.getShareReport(report);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportlist", reportlist);
		return map;
	}

	public int getBlockCount(int userNo) throws Exception {
		Block block = Block.builder().userNo(userNo).build();
		return feedbackDao.getBlockCount(block);
	}

	public Block getBlock(int userNo) throws Exception {
		Block block = feedbackDao.getBlock(userNo);
		block.setBlockCount(feedbackDao.getBlockCount(block));
		return block;
	}

	public Report getReportByReportNo(int reportNo) throws Exception {
		return feedbackDao.getReportByReportNo(reportNo);
	}

}
