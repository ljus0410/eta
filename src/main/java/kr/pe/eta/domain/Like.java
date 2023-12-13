package kr.pe.eta.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Like {

	private int likeNo;
	private int userNo;
	private String likeName;
	private String likeAddr;
	private double likeX;
	private double likeY;

	@Override
	public String toString() {
		return "Like userNo=" + userNo + ", likeNo=" + likeNo + ", likeName=" + likeName + ", likeAddr=" + likeAddr
				+ ", likeX=" + likeX + ", likeY=" + likeY;
	}

}
