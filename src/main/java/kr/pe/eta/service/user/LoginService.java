package kr.pe.eta.service.user;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

	@Value("${naver.baseUrl}")
	String baseUrl;

	@Value("${naver.clientId}")
	String clientId;

	@Value("${naver.redirectUrl}")
	String redirectUrl;

	@Value("${naver.Secret}")
	String Secret;

	@Value("${kakao.clienId}")
	String kaclienId;

	@Value("${kakao.redirect}")
	String karedirect;

	@Value("${kakao.scope}")
	String scope;

	@Value("${kakao.url}")
	String url;

	@Value("${kakao.logout}")
	String logout;

	public String kakaoUrl(String type) throws URISyntaxException, MalformedURLException, UnsupportedEncodingException {

		UriComponents uriComponents = UriComponentsBuilder.fromUriString(url + "/" + type)
				.queryParam("response_type", "code").queryParam("client_id", kaclienId)
				.queryParam("redirect_uri", karedirect).queryParam("scope", scope).build();

		return uriComponents.toString();
	}

	public String getNaverAuthorizeUrl(String type)
			throws URISyntaxException, MalformedURLException, UnsupportedEncodingException {
		System.out.println("service naver======");
		UriComponents uriComponents = UriComponentsBuilder.fromUriString(baseUrl + "/" + type)
				.queryParam("client_id", clientId).queryParam("response_type", "code")
				.queryParam("redirect_uri", URLEncoder.encode(redirectUrl, "UTF-8"))
				.queryParam("state", URLEncoder.encode("123456", "UTF-8")).build();
		System.out.println("url = = " + uriComponents.toString());
		return uriComponents.toString();
	}

	public String kakaoLoOut() throws URISyntaxException, MalformedURLException, UnsupportedEncodingException {

		System.out.println("카카오 URL서비스");

		UriComponents uriComponents = UriComponentsBuilder.fromUriString("https://kauth.kakao.com/oauth/logout?")
				.queryParam("client_id", kaclienId).queryParam("logout_redirect_uri", logout).build();
		System.out.println("uriComponents" + uriComponents.toString());
		return uriComponents.toString();
	}

}