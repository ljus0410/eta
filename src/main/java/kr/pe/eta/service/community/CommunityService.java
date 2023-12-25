package kr.pe.eta.service.community;

import java.util.List;
import java.util.Map;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.ShareReq;

public interface CommunityService {

	public void addReservation(Call call) throws Exception;

	public int getCallNo(int userNo, String callCode) throws Exception;

	public void addDealReq(DealReq dealReq) throws Exception;

	public void updateDealCode(int userNo) throws Exception;

	public Call getCall(int callNo) throws Exception;

	public DealReq getDeal(int userNo) throws Exception;

	public List<DealReq> getDealDriverList(int callNo) throws Exception;

	public void deleteDealReq(int callNo) throws Exception;

	public Map<String, Object> getDealList() throws Exception;

	public Integer getDealNo(int userNo, String callCode) throws Exception;

	public void deleteDealReqDriver(int userNo) throws Exception;

	public void deleteDealOther(DealReq dealReq) throws Exception;

	public void addShareReq(ShareReq shareReq) throws Exception;

	public void updateShareCode(int userNo) throws Exception;

	public Map<String, Object> getShareList(Search search) throws Exception;

	public ShareReq getShare(int userNo) throws Exception;

	public ShareReq getShareall(int callNo) throws Exception;

	public void deleteShareReq(int callNo) throws Exception;

	public int getShareCount(int callNo) throws Exception;

	public ShareReq getShareCallNo(int userNo) throws Exception;

	public void deleteShareOther(int userNo) throws Exception;

	public List<ShareReq> getSharePassengerList(int callNo, String callStateCode) throws Exception;

	public int getShareReqPassenger(int callNo) throws Exception;

	public List<ShareReq> getSharePassengerallList(int callNo) throws Exception;

}
