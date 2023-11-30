package kr.pe.eta.service.callreq.impl;

import kr.pe.eta.domain.Call;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.service.callreq.CallReqDao;
import kr.pe.eta.service.callreq.CallReqService;

@Service
public class CallReqServiceImpl implements CallReqService {

	@Autowired
	private CallReqDao callReqDao;

	public CallReqServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Call getCall(int callNo) throws Exception {
		Call call = callReqDao.getCall(callNo);
		return call;
	}

	@Override
	public void addCall(Call call) throws Exception {
		callReqDao.addCall(call);
	}
}