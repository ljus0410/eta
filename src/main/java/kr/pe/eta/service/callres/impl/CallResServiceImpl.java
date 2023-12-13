package kr.pe.eta.service.callres.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.callres.CallResDao;
import kr.pe.eta.service.callres.CallResService;

@Service("CallResService")
public class CallResServiceImpl implements CallResService {

	@Autowired
	@Qualifier("callResDao")
	private CallResDao callResDao;

	public void setCallResDao(CallResDao callResDao) {
		this.callResDao = callResDao;
	}

	public CallResServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Call getRecordDriver(int callNo) throws Exception {
		// TODO Auto-generated method stub
		return callResDao.getRecordDriver(callNo);
	}

	@Override
	public Call getRecordPassenger(int callNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("grpSI");
		System.out.println(callNo);
		return callResDao.getRecordPassenger(callNo);
	}

	@Override
	public Map<String, Object> getRecordList(Search search, int userNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(search);
		List<Object> list = callResDao.getRecordList(search, userNo);
		System.out.println(list);
		int totalCount = callResDao.getTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public Map<String, Object> getReservationList(Search search, int userNo) throws Exception {
		// TODO Auto-generated method stub
		List<Object> list = callResDao.getReservationList(search, userNo);
		int totalCount = callResDao.getTotalCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public void updateCallStateCode(Call call) throws Exception {
		// TODO Auto-generated method stub
		callResDao.updateCallStateCode(call);
	}

	@Override
	public void updateMatchDriver(int callNo, int driverNo) throws Exception {
		// TODO Auto-generated method stub
		callResDao.updateMatchDriver(callNo, driverNo);
	}

	@Override
	public Map<String, Object> getCallResList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Object> list = callResDao.getCallResList(search);
		System.out.println(list);
		int totalCount = callResDao.getTotalCount(search);
		System.out.println(totalCount);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public void updateEndXY(Call call) throws Exception {
		callResDao.updateEndXY(call);

	}

	@Override
	public Call getCallByNo(int callNo) {
		// TODO Auto-generated method stub
		return callResDao.getCallByNo(callNo);

	}

	@Override
	public User getUserByCallNop(int callNo) {
		// TODO Auto-generated method stub
		return callResDao.getUserByCallNop(callNo);

	}

	@Override
	public List<ShareReq> getSharesByCallNop(int callNo) {
		List<ShareReq> sharelist = callResDao.getSharesByCallNop(callNo);

		return sharelist;

	}

	@Override
	public User getUserByCallNod(int callNo) {
		// TODO Auto-generated method stub
		return callResDao.getUserByCallNod(callNo);
	}

	@Override
	public int getMatchByCallnod(int callNo) {
		// TODO Auto-generated method stub
		return callResDao.getMatchByCallnod(callNo);
	}

	@Override
	public List<ShareReq> getSharesByCallNod(int callNo) {
		List<ShareReq> sharelist = callResDao.getSharesByCallNod(callNo);

		return sharelist;

	}

	@Override
	public int getBlacklistByCallNod(int callNo) {
		Integer result = callResDao.getBlacklistByCallNod(callNo);
		if (result == null) {
			return 0;
		}
		return result;
	}

	@Override
	public User getUserByUserNo(int userNo) {
		// TODO Auto-generated method stub
		return callResDao.getUserByUserNo(userNo);
	}

	@Override
	public void updateRealPay(Call call) throws Exception {
		// TODO Auto-generated method stub
		callResDao.updateRealPay(call);
	}

}
