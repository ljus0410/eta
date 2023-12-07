package kr.pe.eta.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cash {

	private int cashNo;
	private int cashDriverNo;
	private int cashTotal;
	private String cashMonth;
	private int cashCode;
	private Date cashDate;

	@Override
	public String toString() {
		return "Cash [cashNo=" + cashNo + ", cashDriverNo=" + cashDriverNo + ", cashTotal=" + cashTotal + ", cashMonth="
				+ cashMonth + ", cashCode=" + cashCode + "], cashDate=" + cashDate;
	}

}
