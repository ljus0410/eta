package kr.pe.eta.service.callreq;

import kr.pe.eta.domain.Call;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CallReqDao {

    public Call getCall(int callNo) throws Exception;

    public void addCall(Call call) throws Exception;

}
