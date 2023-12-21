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
public class Block {

	private int userNo;
	private boolean blockCode;
	private Date blockDate;
	private Date unblockDate;
	private String unblockDateStr;
	private int blockOpt;
	private int blockCount;
	private int reportNo;

}
