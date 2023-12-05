package kr.pe.eta.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pay {

	private int userNo;
	private int callNo;
	private String payType;
	private Date payDate;
	private int money;
	private int cashCode;

	@Override
	public String toString() {
		return "Pay [userNo=" + userNo + ", callNo=" + callNo + ", payCode=" + payType + ", payDate=" + payDate
				+ ", money=" + money + "], cashCode=" + cashCode;
	}

}
