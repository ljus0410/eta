package kr.pe.eta.service.community;

import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.domain.ShareReqPassenger;
import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;

@Mapper
public interface CommunityDao {

	public void addReservation(Call call) throws Exception;

	public int getCallNo(int userNo) throws Exception;

	public void addDealReq(DealReq dealReq) throws Exception;

	public void deleteDealReq(int userNo) throws Exception;

	public DealReq getDeal(int dealNo) throws Exception;

	public List<DealReq> getDealDriverList(Map param) throws Exception;

	public List<DealReq> getDealList(Search search) throws Exception;

	public int getTotalCountPass(Search search) throws Exception;

	public int getTotalCountDriver(int call_no) throws Exception;

	public void addShareReq(ShareReq shareReq) throws Exception;

	public void addShareReqOther(ShareReqPassenger shareReqPassenger) throws Exception;

	public void deleteShareReq(int userNo) throws Exception;

	public List<DealReq> getShareList(Search search) throws Exception;

	public void updateDealCode(int userNo) throws Exception;

	public void updateShareCode(int userNo) throws Exception;

}
