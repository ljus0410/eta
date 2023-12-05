package kr.pe.eta.service.user;

import com.fasterxml.jackson.annotation.JsonProperty;

public class NaverToken {

	@JsonProperty("access_token")
	private String access_token;

	// ���� ��ū, ���� ��ū�� ����� ��� ���� ��ū�� �ٽ� �߱޹��� �� ���
	@JsonProperty
	private String refresh_token;

	// ���� ��ū�� Ÿ������ Bearer�� MAC�� �� ������ ����
	private String token_type;

	// ���� ��ū�� ��ȿ �Ⱓ(�� ����)
	private String expires_in;

	// ���� �ڵ�
	private String error;

	// ���� �޽���
	private String error_description;

	private String code;

	private String state;

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public String getRefresh_token() {
		return refresh_token;
	}

	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}

	public String getToken_type() {
		return token_type;
	}

	public void setToken_type(String token_type) {
		this.token_type = token_type;
	}

	public String getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(String expires_in) {
		this.expires_in = expires_in;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getError_description() {
		return error_description;
	}

	public void setError_description(String error_description) {
		this.error_description = error_description;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}
