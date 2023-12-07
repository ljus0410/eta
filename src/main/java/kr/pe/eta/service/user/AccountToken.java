package kr.pe.eta.service.user;

public class AccountToken {
	public int code;
	public Object message;
	public Response response;

	public class Response {
		public String access_token;
		public int now;
		public int expired_at;

		public String getAccessToken() {
			return access_token;
		}

		public void setAccessToken(String access_token) {
			this.access_token = access_token;
		}

		public Integer getNow() {
			return now;
		}

		public void setNow(Integer now) {
			this.now = now;
		}

		public Integer getExpiredAt() {
			return expired_at;
		}

		public void setExpiredAt(Integer expired_at) {
			this.expired_at = expired_at;
		}

	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public Object getMessage() {
		return message;
	}

	public void setMessage(Object message) {
		this.message = message;
	}

	public Response getResponse() {
		return response;
	}

	public void setResponse(Response response) {
		this.response = response;
	}

}
