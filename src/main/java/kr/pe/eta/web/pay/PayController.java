package kr.pe.eta.web.pay;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.Pay;
import kr.pe.eta.service.pay.PayService;

@Controller
@RequestMapping("/pay/*")
public class PayController {

	@Autowired
	private PayService payService;

	public PayController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "TpayList", method = RequestMethod.GET)
	public String TpayList(@RequestParam("month") String month, @RequestParam("userNo") int userNo, Model model)
			throws Exception {

		System.out.println("/pay/TpayList");
		System.out.println("userNo : " + userNo);
		System.out.println("month : " + month);

		List<Pay> TpayList = payService.getTpayList(userNo, month);
		int myMoney = payService.getMyMoney(userNo);

		model.addAttribute("TpayList", TpayList);
		model.addAttribute("myMoney", myMoney);
		model.addAttribute("month", month);

		return "forward:/pay/TpayList.jsp";
	}

	@RequestMapping(value = "addPay", method = RequestMethod.POST)
	public String addPay(@ModelAttribute("pay") Pay pay, Model model) throws Exception {
		// 선결제, 선결제 취소, 실결제, call의 실결제 update test

		System.out.println("/pay/addPay");
		System.out.println("pay : " + pay);
		int userNo = pay.getUserNo();
		int myMoney = payService.getMyMoney(userNo);

		int callNo = pay.getCallNo();
		int money = pay.getMoney();

		String payType = pay.getPayType();

		int updateMyMoney = 0;
		if (payType.equals("선결제") || payType.equals("실결제")) {
			updateMyMoney = myMoney - pay.getMoney();
			payService.updateMyMoney(userNo, updateMyMoney);
			payService.addPay(pay);
			if (payType.equals("실결제")) {
				payService.updateRealPay(callNo, money); // call의 실결제 금액 update
			}
		} else if (payType.equals("선결제 취소")) {
			updateMyMoney = myMoney + pay.getMoney();
			payService.updateMyMoney(userNo, updateMyMoney);
			payService.addPay(pay);
		}
		String month = null;

		int lastMyMoney = payService.getMyMoney(userNo);
		List<Pay> TpayList = payService.getTpayList(userNo, month);

		model.addAttribute("myMoney", lastMyMoney);
		model.addAttribute("TpayList", TpayList);

		return "forward:/pay/TpayList.jsp";
	}

	@RequestMapping(value = "cashDriverList", method = RequestMethod.GET)
	public String cashDriverList(@RequestParam("month") String month, Model model) throws Exception {

		System.out.println("/pay/cashDriverList");
		System.out.println("month:" + month);

		List<Call> cashDriverList = payService.getCashDriverList(month);
		List<Call> cashDriverListComplete = payService.getCashDriverListComplete(month);
		List<Call> cashDriverListWait = payService.getCashDriverListWait(month);

		int completeTotal = 0;
		int waitTotal = 0;
		double completePay = 0;
		double waitPay = 0;

		for (int i = 0; i < cashDriverListComplete.size(); i++) {
			double completeCash = cashDriverListComplete.get(i).getRealPay();
			// double discountedPay = completeCash - (0.05 * completeCash); // 5% 할인된 금액 계산
			completePay += completeCash;
		}
		completeTotal = (int) (completePay / 10) * 10;
		System.out.println("정산 완료 총 금액 : " + completeTotal);

		for (int i = 0; i < cashDriverListWait.size(); i++) {
			double WaitCash = cashDriverListWait.get(i).getRealPay();
			double discountedPay = WaitCash - (0.05 * WaitCash); // 5% 할인된 금액 계산
			waitPay += discountedPay;
		}
		waitTotal = (int) (waitPay / 10) * 10;
		System.out.println("정산 대기 총 금액 : " + waitTotal);

		int monthTotal = 0;
		int monthTotalCal = 0;
		int adminCashTotal = 0;
		int discountedTotal = 0;
		double discountedRealPay = 0;
		double adminCashCal = 0;

		for (int i = 0; i < cashDriverList.size(); i++) {

			double realPay = cashDriverList.get(i).getRealPay();
			double discountedPay = realPay - (0.05 * realPay); // 5% 할인된 금액 계산

			cashDriverList.get(i).setRealPay((int) (discountedPay / 10) * 10);

			double adminCash = realPay - (0.95 * realPay);
			System.out.println("5%할인된 금액 : " + discountedPay);
			System.out.println("5%금액 : " + adminCash);
			discountedRealPay += discountedPay;
			monthTotalCal += realPay;
			adminCashCal += adminCash;
		}
		discountedTotal = (int) (discountedRealPay / 10) * 10;
		monthTotal = (int) (monthTotalCal / 10) * 10;
		adminCashTotal = (int) (adminCashCal / 10) * 10;

		System.out.println("admin의 수익 : " + adminCashTotal);
		System.out.println("정산 대상 총금액 : " + discountedTotal);

		// 1분기 정산 완료 금액
		List<Call> cashDriverListJan = payService.getCashDriverListComplete("01");
		int cashJan = 0;
		for (int i = 0; i < cashDriverListJan.size(); i++) {
			cashJan += cashDriverListJan.get(i).getRealPay();
		}
		System.out.println("1월 : " + cashJan);
		List<Call> cashDriverListFeb = payService.getCashDriverListComplete("02");
		int cashFeb = 0;
		for (int i = 0; i < cashDriverListFeb.size(); i++) {
			cashFeb += cashDriverListFeb.get(i).getRealPay();
		}
		System.out.println("2월 : " + cashFeb);
		List<Call> cashDriverListMar = payService.getCashDriverListComplete("03");
		int cashMar = 0;
		for (int i = 0; i < cashDriverListMar.size(); i++) {
			cashMar += cashDriverListMar.get(i).getRealPay();
		}
		System.out.println("3월 : " + cashMar);
		int firstSeasonCash = cashJan + cashFeb + cashMar;
		System.out.println(firstSeasonCash);

		// 2분기 정산 완료 금액
		List<Call> cashDriverListApr = payService.getCashDriverListComplete("04");
		int cashApr = 0;
		for (int i = 0; i < cashDriverListApr.size(); i++) {
			cashApr += cashDriverListApr.get(i).getRealPay();
		}
		System.out.println("4월 : " + cashApr);
		List<Call> cashDriverListMay = payService.getCashDriverListComplete("05");
		int cashMay = 0;
		for (int i = 0; i < cashDriverListMay.size(); i++) {
			cashMay += cashDriverListMay.get(i).getRealPay();
		}
		System.out.println("5월 : " + cashMay);
		List<Call> cashDriverListJun = payService.getCashDriverListComplete("06");
		int cashJun = 0;
		for (int i = 0; i < cashDriverListJun.size(); i++) {
			cashJun += cashDriverListJun.get(i).getRealPay();
		}
		System.out.println("6월 : " + cashJun);
		int secondSeasonCash = cashApr + cashMay + cashJun;
		System.out.println(secondSeasonCash);

		// 3분기 정산 완료 금액
		List<Call> cashDriverListJul = payService.getCashDriverListComplete("07");
		int cashJul = 0;
		for (int i = 0; i < cashDriverListJul.size(); i++) {
			cashJul += cashDriverListJul.get(i).getRealPay();
		}
		System.out.println("7월 : " + cashJul);
		List<Call> cashDriverListAug = payService.getCashDriverListComplete("08");
		int cashAug = 0;
		for (int i = 0; i < cashDriverListAug.size(); i++) {
			cashAug += cashDriverListAug.get(i).getRealPay();
		}
		System.out.println("8월 : " + cashAug);
		List<Call> cashDriverListSep = payService.getCashDriverListComplete("09");
		int cashSep = 0;
		for (int i = 0; i < cashDriverListSep.size(); i++) {
			cashSep += cashDriverListSep.get(i).getRealPay();
		}
		System.out.println("9월 : " + cashSep);
		int thirdSeasonCash = cashJul + cashAug + cashSep;
		System.out.println(thirdSeasonCash);

		// 4기 정산 완료 금액
		List<Call> cashDriverListOct = payService.getCashDriverListComplete("10");
		int cashOct = 0;
		for (int i = 0; i < cashDriverListOct.size(); i++) {
			cashOct += cashDriverListOct.get(i).getRealPay();
		}
		System.out.println("10월 : " + cashOct);
		List<Call> cashDriverListNov = payService.getCashDriverListComplete("11");
		int cashNov = 0;
		for (int i = 0; i < cashDriverListNov.size(); i++) {
			cashNov += cashDriverListNov.get(i).getRealPay();
		}
		System.out.println("11월 : " + cashNov);
		List<Call> cashDriverListDec = payService.getCashDriverListComplete("12");
		int cashDec = 0;
		for (int i = 0; i < cashDriverListDec.size(); i++) {
			cashDec += cashDriverListDec.get(i).getRealPay();
		}
		System.out.println("12월 : " + cashDec);
		int fourthSeasonCash = cashOct + cashNov + cashDec;
		System.out.println(fourthSeasonCash);

		model.addAttribute("cashDriverList", cashDriverList);
		model.addAttribute("monthTotal", monthTotal);
		model.addAttribute("discountedTotal", discountedTotal);
		model.addAttribute("month", month);
		model.addAttribute("adminCashTotal", adminCashTotal);
		model.addAttribute("completeTotal", completeTotal);
		model.addAttribute("waitTotal", waitTotal);

		model.addAttribute("firstSeasonCash", firstSeasonCash);
		model.addAttribute("secondSeasonCash", secondSeasonCash);
		model.addAttribute("thirdSeasonCash", thirdSeasonCash);
		model.addAttribute("fourthSeasonCash", fourthSeasonCash);

		return "forward:/pay/cashDriverList.jsp";
	}

	@RequestMapping(value = "myCashList", method = RequestMethod.GET)
	public String myCashList(@RequestParam("userNo") int userNo, @RequestParam("month") String month, Model model)
			throws Exception {

		System.out.println("/pay/myCashList");
		System.out.println("userNo : " + userNo + ", month : " + month);

		List<Call> myCashList = payService.getMyCashList(userNo, month);
		List<Call> myCashListComplete = payService.getMyCashListComplete(userNo, month);
		List<Call> myCashListWait = payService.getMyCashListWait(userNo, month);

		int completeTotal = 0;
		int waitTotal = 0;
		double completePay = 0;
		double waitPay = 0;

		for (int i = 0; i < myCashListComplete.size(); i++) {
			double completeCash = myCashListComplete.get(i).getRealPay();
			// double discountedPay = completeCash - (0.05 * completeCash); // 5% 할인된 금액 계산

			completePay += completeCash;
		}
		completeTotal = (int) (completePay / 10) * 10;
		System.out.println("정산 완료 총 금액 : " + completeTotal);

		for (int i = 0; i < myCashListWait.size(); i++) {
			double WaitCash = myCashListWait.get(i).getRealPay();
			double discountedPay = WaitCash - (0.05 * WaitCash); // 5% 할인된 금액 계산
			waitPay += discountedPay;
		}
		waitTotal = (int) (waitPay / 10) * 10;
		System.out.println("정산 대기 총 금액 : " + waitTotal);

		int monthTotal = 0;
		int discountedTotal = 0;
		double discountedRealPay = 0;
		double totalMonthPay = 0;

		for (int i = 0; i < myCashList.size(); i++) {

			double realPay = myCashList.get(i).getRealPay();
			double discountedPay = realPay - (0.05 * realPay); // 5% 할인된 금액 계산

			System.out.println("5%할인된 금액 : " + discountedPay);

			discountedRealPay += discountedPay;
			totalMonthPay += realPay;
			String calldate = myCashList.get(i).getCallDate();
			String[] parts = calldate.split(" ");
			String callDateResult = parts[0];
			myCashList.get(i).setCallDate(callDateResult);

		}
		discountedTotal = (int) (discountedRealPay / 10) * 10;
		monthTotal = (int) (totalMonthPay / 10) * 10;

		// 1분기 정산 완료 금액
		List<Call> myCashListJan = payService.getMyCashListComplete(userNo, "01");
		int cashJan = 0;
		for (int i = 0; i < myCashListJan.size(); i++) {
			cashJan += myCashListJan.get(i).getRealPay();
		}
		System.out.println("1월 : " + cashJan);
		List<Call> myCashListFeb = payService.getMyCashListComplete(userNo, "02");
		int cashFeb = 0;
		for (int i = 0; i < myCashListFeb.size(); i++) {
			cashFeb += myCashListFeb.get(i).getRealPay();
		}
		System.out.println("2월 : " + cashFeb);
		List<Call> myCashListMar = payService.getMyCashListComplete(userNo, "03");
		int cashMar = 0;
		for (int i = 0; i < myCashListMar.size(); i++) {
			cashMar += myCashListMar.get(i).getRealPay();
		}
		System.out.println("3월 : " + cashMar);
		int firstSeasonCash = cashJan + cashFeb + cashMar;
		System.out.println(firstSeasonCash);

		// 2분기 정산 완료 금액
		List<Call> myCashListApr = payService.getMyCashListComplete(userNo, "04");
		int cashApr = 0;
		for (int i = 0; i < myCashListApr.size(); i++) {
			cashApr += myCashListApr.get(i).getRealPay();
		}
		System.out.println("4월 : " + cashApr);
		List<Call> myCashListMay = payService.getMyCashListComplete(userNo, "05");
		int cashMay = 0;
		for (int i = 0; i < myCashListMay.size(); i++) {
			cashMay += myCashListMay.get(i).getRealPay();
		}
		System.out.println("5월 : " + cashMay);
		List<Call> myCashListJun = payService.getMyCashListComplete(userNo, "06");
		int cashJun = 0;
		for (int i = 0; i < myCashListJun.size(); i++) {
			cashJun += myCashListJun.get(i).getRealPay();
		}
		System.out.println("6월 : " + cashJun);
		int secondSeasonCash = cashApr + cashMay + cashJun;
		System.out.println(secondSeasonCash);

		// 3분기 정산 완료 금액
		List<Call> myCashListJul = payService.getMyCashListComplete(userNo, "07");
		int cashJul = 0;
		for (int i = 0; i < myCashListJul.size(); i++) {
			cashJul += myCashListJul.get(i).getRealPay();
		}
		System.out.println("7월 : " + cashJul);
		List<Call> myCashListAug = payService.getMyCashListComplete(userNo, "08");
		int cashAug = 0;
		for (int i = 0; i < myCashListAug.size(); i++) {
			cashAug += myCashListAug.get(i).getRealPay();
		}
		System.out.println("8월 : " + cashAug);
		List<Call> myCashListSep = payService.getMyCashListComplete(userNo, "09");
		int cashSep = 0;
		for (int i = 0; i < myCashListSep.size(); i++) {
			cashSep += myCashListSep.get(i).getRealPay();
		}
		System.out.println("9월 : " + cashSep);
		int thirdSeasonCash = cashJul + cashAug + cashSep;
		System.out.println(thirdSeasonCash);

		// 4기 정산 완료 금액
		List<Call> myCashListOct = payService.getMyCashListComplete(userNo, "10");
		int cashOct = 0;
		for (int i = 0; i < myCashListOct.size(); i++) {
			cashOct += myCashListOct.get(i).getRealPay();
		}
		System.out.println("10월 : " + cashOct);
		List<Call> myCashListNov = payService.getMyCashListComplete(userNo, "11");
		int cashNov = 0;
		for (int i = 0; i < myCashListNov.size(); i++) {
			cashNov += myCashListNov.get(i).getRealPay();
		}
		System.out.println("11월 : " + cashNov);
		List<Call> myCashListDec = payService.getMyCashListComplete(userNo, "12");
		int cashDec = 0;
		for (int i = 0; i < myCashListDec.size(); i++) {
			cashDec += myCashListDec.get(i).getRealPay();
		}
		System.out.println("12월 : " + cashDec);
		int fourthSeasonCash = cashOct + cashNov + cashDec;
		System.out.println(fourthSeasonCash);

		model.addAttribute("myCashList", myCashList);
		model.addAttribute("monthTotal", monthTotal);
		model.addAttribute("discountedTotal", discountedTotal);
		model.addAttribute("completeTotal", completeTotal);
		model.addAttribute("waitTotal", waitTotal);
		model.addAttribute("month", month);

		model.addAttribute("firstSeasonCash", firstSeasonCash);
		model.addAttribute("secondSeasonCash", secondSeasonCash);
		model.addAttribute("thirdSeasonCash", thirdSeasonCash);
		model.addAttribute("fourthSeasonCash", fourthSeasonCash);

		return "forward:/pay/myCashList.jsp";
	}

}
