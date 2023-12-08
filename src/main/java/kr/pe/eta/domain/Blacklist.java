package kr.pe.eta.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Blacklist {

	private int driverNo;
	private int passengerNo;
	private int callNo;
	private boolean blacklistCode;

}
