package kr.pe.eta.service.pay.impl;

import kr.pe.eta.domain.Pay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.eta.service.pay.PayDao;
import kr.pe.eta.service.pay.PayService;

@Service
public class PayServiceImpl implements PayService {

	@Autowired
	private PayDao payDao;

	public PayServiceImpl() {
		System.out.println(this.getClass());
	}

	public void addPay(Pay pay) throws Exception {
		payDao.addPay(pay);
	}

}
