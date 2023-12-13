package kr.pe.eta.service.community;

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

	public Map<String, Object> getDealDriverList(int callNo) throws Exception;

	public void deleteDealReq(int callNo) throws Exception;

	public Map<String, Object> getDealList(Search search) throws Exception;

	public int getDealNo(int userNo, String callCode) throws Exception;

	public void deleteDealReqDriver(int userNo) throws Exception;

	public void addShareReq(ShareReq shareReq) throws Exception;

	public void updateShareCode(int userNo) throws Exception;

	public Map<String, Object> getShareList(Search search) throws Exception;

	public ShareReq getShare(int userNo) throws Exception;

	public void deleteShareReq(int callNo) throws Exception;

}
