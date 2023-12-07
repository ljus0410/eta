package kr.pe.eta.service.pay.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Cash;
import kr.pe.eta.domain.Pay;
import kr.pe.eta.service.pay.PayDao;
import kr.pe.eta.service.pay.PayService;

@Service("payService")
public class PayServiceImpl implements PayService {

	@Autowired
	@Qualifier("payDao")
	private PayDao payDao;

	public PayServiceImpl() {
		System.out.println(this.getClass());
	}

	public int getMyMoney(int userNo) throws Exception {
		System.out.println("serviceImpl getMyMoney userNo : " + userNo);

		int myMoney = payDao.getMyMoney(userNo);

		return myMoney;
	}

	public void addCharge(int userNo, int Tpay) throws Exception {
		System.out.println("serviceImpl addCharge userNo : " + userNo + ", " + Tpay);

		payDao.addCharge(userNo, Tpay);
	}

	public void updateMyMoney(int userNo, int updateMyMoney) throws Exception {
		System.out.println("serviceImpl updateMyMoney userNo : " + userNo + ", " + updateMyMoney);

		payDao.updateMyMoney(userNo, updateMyMoney);
	}

	public List<Pay> getTpayList(int userNo, String month) throws Exception {
		System.out.println("serviceImpl getTpayList userNo : " + userNo);

		List<Pay> TpayList = payDao.getTpayList(userNo, month);

		return TpayList;
	}

	public void addPay(Pay pay) throws Exception {
		System.out.println("serviceImpl addPay : " + pay);

		payDao.addPay(pay);
	}

	public List<Call> getCashDriverList(String month) throws Exception {

		List<Call> cashDriverList = payDao.getCashDriverList(month);

		return cashDriverList;
	}

	public void addCash(Cash cash) throws Exception {
		System.out.println("serviceImpl addCash : " + cash);

		payDao.addCash(cash);
	}

	public List<Call> getMyCashList(int userNo, String month) throws Exception {

		List<Call> myCashList = payDao.getMyCashList(userNo, month);

		return myCashList;
	}

	public void updateRealPay(int callNo, int money) throws Exception {
		System.out.println("serviceImpl updateRealPay : " + callNo + ", " + money);

		payDao.updateRealPay(callNo, money);
	}

}
