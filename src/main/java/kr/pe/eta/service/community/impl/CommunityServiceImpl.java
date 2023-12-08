package kr.pe.eta.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
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
	public Map<String, Object> getDealDriverList(int callNo) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		List<DealReq> list = communityDao.getDealDriverList(callNo);

		map.put("list", list);
		return map;
	}

	@Override
	public void deleteDealReq(int callNo) throws Exception {
		communityDao.deleteDealReq(callNo);
	}

	@Override
	public Map<String, Object> getDealList(Search search) throws Exception {
		List<DealReq> dealList = communityDao.getDealList(search);
		List<Call> callList = communityDao.getDealCallList(search);
		int totalCount = communityDao.getDealCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dealList", dealList);
		map.put("callList", callList);
		map.put("totalCount", totalCount);
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

}
