package kr.pe.eta.domain;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class Call {

	private int callNo;
	private String callCode;
	private int userNo;
	private int realPay;
	private String startAddr;
	private String startKeyword;
	private double startX;
	private double startY;
	private String endAddr;
	private String endKeyword;
	private double endX;
	private double endY;
	private String callStateCode;
	private String routeOpt;
	private String carOpt;
	private boolean petOpt;
	private String callDate;

	@Override
	public String toString() {
		return "Call [callNo=" + callNo + ", callCode=" + callCode + ", userNo=" + userNo + ", realPay=" + realPay
				+ ", startAddr=" + startAddr + ", startKeyword=" + startKeyword + ", startX=" + startX + ", startY="
				+ startY + ", endAddr=" + endAddr + ", endKeyword=" + endKeyword + ", endX=" + endX + ", startX="
				+ startX + ", endY=" + endY + ", callStateCode=" + callStateCode + ", routeOpt=" + routeOpt
				+ ", carOpt=" + carOpt + ", petOpt=" + petOpt + ", callDate=" + callDate + "]";
	}

}
