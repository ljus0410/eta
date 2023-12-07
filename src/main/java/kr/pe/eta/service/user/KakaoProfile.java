
package kr.pe.eta.service.user;

import lombok.Data;

@Data
public class KakaoProfile {

	private Long id;
	private String connected_at;
	private Properties properties;
	private kakao_account kakao_account;

	@Data
	public class Properties {

		private String nickname;

		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

	}

	@Data
	public class kakao_account {

		private Boolean profile_nickname_needs_agreement;
		private Boolean profile_image_needs_agreement;
		private Profile profile;
		private Boolean has_email;
		private Boolean email_needs_agreement;
		private Boolean is_email_valid;
		private Boolean is_email_verified;
		private String email;
		private Boolean has_birthday;
		private Boolean birthday_needs_agreement;
		private Boolean has_gender;
		private Boolean gender_needs_agreement;
		private String gender;

		@Data
		public class Profile {

			private String nickname;

			public String getNickname() {
				return nickname;
			}

			public void setNickname(String nickname) {
				this.nickname = nickname;
			}

		}

		public Boolean getProfile_nickname_needs_agreement() {
			return profile_nickname_needs_agreement;
		}

		public void setProfile_nickname_needs_agreement(Boolean profile_nickname_needs_agreement) {
			this.profile_nickname_needs_agreement = profile_nickname_needs_agreement;
		}

		public Boolean getProfile_image_needs_agreement() {
			return profile_image_needs_agreement;
		}

		public void setProfile_image_needs_agreement(Boolean profile_image_needs_agreement) {
			this.profile_image_needs_agreement = profile_image_needs_agreement;
		}

		public Profile getProfile() {
			return profile;
		}

		public void setProfile(Profile profile) {
			this.profile = profile;
		}

		public Boolean getHas_email() {
			return has_email;
		}

		public void setHas_email(Boolean has_email) {
			this.has_email = has_email;
		}

		public Boolean getIs_email_valid() {
			return is_email_valid;
		}

		public void setIs_email_valid(Boolean is_email_valid) {
			this.is_email_valid = is_email_valid;
		}

		public Boolean getIs_email_verified() {
			return is_email_verified;
		}

		public void setIs_email_verified(Boolean is_email_verified) {
			this.is_email_verified = is_email_verified;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public Boolean getHas_birthday() {
			return has_birthday;
		}

		public void setHas_birthday(Boolean has_birthday) {
			this.has_birthday = has_birthday;
		}

		public Boolean getBirthday_needs_agreement() {
			return birthday_needs_agreement;
		}

		public void setBirthday_needs_agreement(Boolean birthday_needs_agreement) {
			this.birthday_needs_agreement = birthday_needs_agreement;
		}

		public Boolean getHas_gender() {
			return has_gender;
		}

		public void setHas_gender(Boolean has_gender) {
			this.has_gender = has_gender;
		}

		public Boolean getGender_needs_agreement() {
			return gender_needs_agreement;
		}

		public void setGender_needs_agreement(Boolean gender_needs_agreement) {
			this.gender_needs_agreement = gender_needs_agreement;
		}

		public Boolean getEmail_needs_agreement() {
			return email_needs_agreement;
		}

		public void setEmail_needs_agreement(Boolean email_needs_agreement) {
			this.email_needs_agreement = email_needs_agreement;
		}

		public String getGender() {
			return gender;
		}

		public void setGender(String gender) {
			this.gender = gender;
		}
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getConnected_at() {
		return connected_at;
	}

	public void setConnected_at(String connected_at) {
		this.connected_at = connected_at;
	}

	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	public kakao_account getKakao_account() {
		return kakao_account;
	}

	public void setKakao_account(kakao_account kakao_account) {
		this.kakao_account = kakao_account;
	}
}
