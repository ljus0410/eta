package kr.pe.eta.service.callres;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.User;

@Mapper
public interface CallResDao {
	public Call getRecordPassenger(int callNo) throws Exception;

	public Call getRecordDriver(int callNo) throws Exception;

	public List<Object> getRecordList(Search search, int userNo) throws Exception;

	public List<Object> getReservationList(Search search, int userNo) throws Exception;

	public void updateCallStateCode(Call call) throws Exception;

	public List<Object> getCallResList(Search search) throws Exception;

	public void updateEndXY(Call call) throws Exception;

	public int getTotalCount(Search search) throws Exception;

	public void updateMatchDriver(int callNo, int driverNo) throws Exception;

	public Call getCallByNo(int callNo);

	public User getUserByCallNop(int callNo);

	public List<ShareReq> getSharesByCallNop(int callNo);

	public User getUserByCallNod(int callNo);

	public int getMatchByCallnod(int callNo);

	public List<ShareReq> getSharesByCallNod(int callNo);

	public int getBlacklistByCallNod(int callNo);

	public User getUserByUserNo(int userNo);

	public void updateRealPay(Call call) throws Exception;
}
