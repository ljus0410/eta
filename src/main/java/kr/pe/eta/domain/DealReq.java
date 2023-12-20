package kr.pe.eta.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DealReq {

	private int userNo;
	private int callNo;
	private String callCode;
	private int passengerOffer;
	private String limitTime;
	private int driverOffer;
	private double starAvg;

	@Override
	public String toString() {
		return "DealReq [userNo=" + userNo + ", callNo=" + callNo + ", callCode=" + callCode + ", passengerOffer="
				+ passengerOffer + ", limitTime=" + limitTime + ", driverOffer=" + driverOffer + ", starAvg=" + starAvg
				+ "]";
	}

}
