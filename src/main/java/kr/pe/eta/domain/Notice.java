package kr.pe.eta.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeDate;
	private String noticeDetail;

}
