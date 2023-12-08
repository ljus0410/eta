package kr.pe.eta.service.community;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;

@Mapper
public interface CommunityDao {

	public void addReservation(Call call) throws Exception;

	public int getCallNo(Map param) throws Exception;

	public void addDealReq(DealReq dealReq) throws Exception;

	public void updateDealCode(int userNo) throws Exception;

	public Call getCall(int callNo) throws Exception;

	public DealReq getDeal(int dealNo) throws Exception;

	public List<DealReq> getDealDriverList(int callNo) throws Exception;

	public void deleteDealReq(int callNo) throws Exception;

	public List<DealReq> getDealList(Search search) throws Exception;

	public List<Call> getDealCallList(Search search) throws Exception;

	public int getDealCount(Search search) throws Exception;

	public int getDealNo(Map param) throws Exception;

	public void deleteDealReqDriver(int userNo) throws Exception;
}
