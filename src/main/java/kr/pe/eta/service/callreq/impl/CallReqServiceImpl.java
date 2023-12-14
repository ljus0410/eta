package kr.pe.eta.service.callreq.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Like;
import kr.pe.eta.service.callreq.CallReqDao;
import kr.pe.eta.service.callreq.CallReqService;

@Service("callReqService")
public class CallReqServiceImpl implements CallReqService {

	@Autowired
	@Qualifier("callReqDao")
	private CallReqDao callReqDao;

	public CallReqServiceImpl() {
		System.out.println(this.getClass());
	}

	public List<Call> getEndAddrList(int userNo) throws Exception {
		System.out.println("serviceImpl getEndAddrList userNo : " + userNo);

		List<Call> endAddrList = callReqDao.getEndAddrList(userNo);

		return endAddrList;
	}

	public List<Like> getLikeList(int userNo) throws Exception {
		System.out.println("serviceImpl getLikeList userNo : " + userNo);

		List<Like> likeList = callReqDao.getLikeList(userNo);

		return likeList;
	}

	public void addLikeList(int userNo) throws Exception {
		System.out.println("serviceImpl addLikeList userNo : " + userNo);

		callReqDao.addLikeList(userNo);
	}

	public void addCall(Call call) throws Exception {

		callReqDao.addCall(call);
	}

	public int getCallNo() throws Exception {

		int callNo = callReqDao.getCallNo();

		return callNo;
	}

	@Transactional
	public void deleteCall(int callNo) throws Exception {
		callReqDao.deleteCall(callNo);
	}

	public Integer getCallDriver(String carOpt, boolean petOpt, int driverNo) throws Exception {
		System.out.println("serviceImpl getCallDriverList carOpt : " + carOpt);
		System.out.println("serviceImpl getCallDriverList petOpt : " + petOpt);
		System.out.println("serviceImpl getCallDriverList driverNo : " + driverNo);
		Integer callDriverNo = callReqDao.getCallDriver(carOpt, petOpt, driverNo);

		return callDriverNo;
	}

	public void updateDealCode(int callNo) throws Exception {

		callReqDao.updateDealCode(callNo);
	}

	public void updateShareCode(int callNo) throws Exception {

		callReqDao.updateShareCode(callNo);
	}

	public void updateLikeAddr(String likeAddr, String likeName, int userNo, int likeNo, double likeX, double likeY)
			throws Exception {
		callReqDao.updateLikeAddr(likeAddr, likeName, userNo, likeNo, likeX, likeY);
	}

	public void deleteLikeAddr(int likeNo, int userNo) throws Exception {
		callReqDao.deleteLikeAddr(likeNo, userNo);
	}

	public void deleteCustomName(int userNo) throws Exception {
		callReqDao.deleteCustomName(userNo);
	}

	public List<Integer> getBlackList(int passengerNo) throws Exception {
		System.out.println("serviceImpl getBlackList passengerNo : " + passengerNo);
		List<Integer> blackNoList = callReqDao.getBlackList(passengerNo);

		return blackNoList;
	}

	public Call getCall(int callNo) throws Exception {

		Call call = callReqDao.getCall(callNo);

		return call;
	}

}