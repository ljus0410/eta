package kr.pe.eta.service.pay;

import java.util.List;

import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Cash;
import kr.pe.eta.domain.Pay;

public interface PayService {

	public int getMyMoney(int userNo) throws Exception;

	public void addCharge(int userNo, int Tpay) throws Exception;

	public void updateMyMoney(int userNo, int updateMyMoney) throws Exception;

	public List<Pay> getTpayList(int userNo, String month) throws Exception;

	public void addPay(Pay pay) throws Exception;

	public List<Call> getCashDriverList(String month) throws Exception;

	public void addCash(Cash cash) throws Exception;

	public List<Call> getMyCashList(int userNo, String month) throws Exception;

	public void updateRealPay(int callNo, int money) throws Exception;

	public List<Call> getCashDriverListComplete(String month) throws Exception;

	public List<Call> getCashDriverListWait(String month) throws Exception;

	public List<Call> getMyCashListWait(int userNo, String month) throws Exception;

	public List<Call> getMyCashListComplete(int userNo, String month) throws Exception;

}
