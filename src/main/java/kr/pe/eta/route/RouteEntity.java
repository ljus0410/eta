package kr.pe.eta.route;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "route")
public class RouteEntity {
	@Id
	private int callNo;
	private double[] route;

	public int getCallNo() {
		return callNo;
	}

	public void setCallNo(int callNo) {
		this.callNo = callNo;
	}

	public double[] getRoute() {
		return route;
	}

	public void setRoute(double[] ds) {
		this.route = ds;
	}

	// Getters and Setters
}