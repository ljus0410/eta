package kr.pe.eta.service.community;

import java.sql.Time;
import java.util.Date;
import java.util.Map;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.ShareReqPassenger;

public interface CommunityService {

	public void addReservation(Call call) throws Exception;

	public int getCallNo(int userNo) throws Exception;

	public void addDealReq(DealReq dealReq) throws Exception;

	public void addDealReqDriver(DealReq dealReq) throws Exception;

	public void deleteDealReq(int userNo) throws Exception;

	public void deleteDealReqDriver(int userNo) throws Exception;

	public DealReq getDeal(int userNo) throws Exception;

	public Map<String, Object> getDealDriverList(Search search, int callNo) throws Exception;

	public Map<String, Object> getDealList(Search search) throws Exception;

	public void addShareReq(ShareReq shareReq) throws Exception;

	public void addShareReqOther(ShareReqPassenger shareReqPassenger) throws Exception;

	public void deleteShareReq(int userNo) throws Exception;

	public void deleteShareReqOther(int userNo) throws Exception;

	public Map<String, Object> getShareList(Search search) throws Exception;

	public void updateDealCode(int userNo) throws Exception;

	public void updateShareCode(int userNo) throws Exception;

}
