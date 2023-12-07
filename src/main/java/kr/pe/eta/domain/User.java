package kr.pe.eta.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {

	private int userNo;
	private String name;
	private String email;
	private String pwd;
	private String birth;
	private String gender;
	private String phone;
	private String role;
	private String nickName;
	private boolean dealCode;
	private boolean shareCode;
	private boolean blockCode;
	private String carOpt;
	private boolean petOpt;
	private String carNum;
	private String bank;
	private String account;
	private double currentX;
	private double currentY;
	private String myMoney;
	private String regDate;

	@Override
	public String toString() {
		return "User [userNo=" + userNo + ", name=" + name + ", email=" + email + ", pwd=" + pwd + ", birth=" + birth
				+ ", gender=" + gender + ", phone=" + phone + ", role=" + role + ", nickName=" + nickName
				+ ", dealCode=" + dealCode + ", shareCode=" + shareCode + ", blockCode=" + blockCode + ", carOpt="
				+ carOpt + ", petOpt=" + petOpt + ", carNum=" + carNum + ", bank=" + bank + ", account=" + account
				+ ", currentX=" + currentX + ", currentY=" + currentY + "]";
	}
}
