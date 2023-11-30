package kr.pe.eta.service.callreq;

import kr.pe.eta.domain.Call;

public interface CallReqService {

    public Call getCall(int callNo) throws Exception;

    public void addCall(Call call) throws Exception;

}
