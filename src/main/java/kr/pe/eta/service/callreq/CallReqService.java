package kr.pe.eta.service.callreq;

import java.util.List;

import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Like;
import kr.pe.eta.domain.User;

public interface CallReqService {

	public List<Call> getEndAddrList(int userNo) throws Exception;

	public List<Like> getLikeList(int userNo) throws Exception;

	public void addLikeList(int userNo) throws Exception;

	public void addCall(Call call) throws Exception;

	public int getCallNo() throws Exception;

	public void deleteCall(int callNo) throws Exception;

	public List<User> getCallDriverList(String carOpt, boolean petOpt) throws Exception;

	public void updateDealCode(int callNo) throws Exception;

	public void updateShareCode(int callNo) throws Exception;

	public void updateLikeAddr(String likeAddr, int userNo, int likeNo) throws Exception;

	public void updateCustomName(String likeName, int userNo) throws Exception;

	public void deleteLikeAddr(int likeNo, int userNo) throws Exception;

	public void deleteCustomName(int userNo) throws Exception;

}
