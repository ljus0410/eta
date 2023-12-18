package kr.pe.eta.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Report {

	private int reportNo;
	private String reportCategory;
	private String reportDetail;
	private int reportCode;
	private int reportUserNo;
	private int badCallNo;
	private int badUserNo;
	private Date reportDate;
	private String reportRole;
	private String regDate;

}
