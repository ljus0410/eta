package kr.pe.eta.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShareReq {

	private int shareReqNo;
	private String callCode;
	private int callNo;
	private int firstSharePassengerNo;
	private int firstShareCount;
	private int startShareCount;
	private int maxShareCount;
	private String shareDate;

	@Override
	public String toString() {
		return "ShareReq [shareReqNo=" + shareReqNo + ", callCode=" + callCode + ", callNo=" + callNo
				+ ", firstSharePassengerNo=" + firstSharePassengerNo + ", firstShareCount=" + firstShareCount
				+ ", startShareCount=" + startShareCount + ", maxShareCount=" + maxShareCount + ", shareDate="
				+ shareDate + "]";
	}

}
