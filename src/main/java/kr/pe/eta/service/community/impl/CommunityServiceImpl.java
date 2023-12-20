package kr.pe.eta.service.community.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.service.community.CommunityDao;
import kr.pe.eta.service.community.CommunityService;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;

	public CommunityServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addReservation(Call call) throws Exception {
		communityDao.addReservation(call);
	}

	@Override
	public int getCallNo(int userNo, String callCode) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userNo", userNo);
		param.put("callCode", callCode);

		int callNo = communityDao.getCallNo(param);
		return callNo;
	}

	@Override
	public void addDealReq(DealReq dealReq) throws Exception {
		communityDao.addDealReq(dealReq);
	}

	@Override
	public void updateDealCode(int userNo) throws Exception {
		communityDao.updateDealCode(userNo);
	}

	@Override
	public Call getCall(int callNo) throws Exception {
		Call call = communityDao.getCall(callNo);
		return call;
	}

	@Override
	public DealReq getDeal(int userNo) throws Exception {
		DealReq dealReq = communityDao.getDeal(userNo);
		return dealReq;
	}

	@Override
	public List<DealReq> getDealDriverList(int callNo) throws Exception {

		List<DealReq> list = communityDao.getDealDriverList(callNo);

		return list;
	}

	@Override
	public void deleteDealReq(int callNo) throws Exception {
		communityDao.deleteDealReq(callNo);
	}

	@Override
	public Map<String, Object> getDealList() throws Exception {
		List<DealReq> list = communityDao.getDealList();
		List<Call> callList = communityDao.getDealCallList();
		List<DealReq> dealList = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();

		for (int i = 0; i < list.size(); i++) {
			DealReq listItem = list.get(i);
			String callDate = callList.get(i).getCallDate();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime parsedTime = LocalDateTime.parse(callDate, formatter);
			LocalDateTime newTime = parsedTime.plusMinutes(10);
			String limitTime = newTime.format(formatter);
			listItem.setLimitTime(limitTime);
			dealList.add(listItem);
		}

		map.put("dealList", dealList);
		map.put("callList", callList);
		return map;
	}

	@Override
	public int getDealNo(int userNo, String callCode) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userNo", userNo);
		param.put("callCode", callCode);

		int callNo = communityDao.getDealNo(param);
		return callNo;
	}

	@Override
	public void deleteDealReqDriver(int userNo) throws Exception {
		communityDao.deleteDealReqDriver(userNo);
	}

	@Override
	public void deleteDealOther(DealReq dealReq) throws Exception {
		communityDao.deleteDealOther(dealReq);
	}

	@Override
	public void addShareReq(ShareReq shareReq) throws Exception {
		communityDao.addShareReq(shareReq);
	}

	@Override
	public void updateShareCode(int userNo) throws Exception {
		communityDao.updateShareCode(userNo);
	}

	@Override
	public Map<String, Object> getShareList(Search search) throws Exception {
		List<ShareReq> shareList = communityDao.getShareList(search);
		List<Call> callList = communityDao.getShareCallList(search);
		int totalCount = communityDao.getTotalCountPassShare(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("shareList", shareList);
		map.put("callList", callList);
		map.put("totalCount", totalCount);
		return map;
	}

	@Override
	public ShareReq getShare(int userNo) throws Exception {
		ShareReq shareReq = communityDao.getShare(userNo);
		return shareReq;
	}

	@Override
	public ShareReq getShareall(int callNo) throws Exception {
		ShareReq shareReq = communityDao.getShareall(callNo);
		return shareReq;
	}

	@Override
	public void deleteShareReq(int callNo) throws Exception {
		communityDao.deleteShareReq(callNo);
	}

	@Override
	public int getShareCount(int callNo) throws Exception {
		return communityDao.getShareCount(callNo);
	}

	@Override
	public int getShareCallNo(int userNo) throws Exception {
		return communityDao.getShareCallNo(userNo);
	}
}
