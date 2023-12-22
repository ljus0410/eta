package kr.pe.eta.config;

import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Component
public class WebServerCustomizer implements WebServerFactoryCustomizer<ConfigurableWebServerFactory> {
	@Override
	public void customize(ConfigurableWebServerFactory factory) {
		System.out.println("error 페이지 등록");
		ErrorPage errorPage400 = new ErrorPage(HttpStatus.BAD_REQUEST, "/error/400");
		ErrorPage errorPage401 = new ErrorPage(HttpStatus.UNAUTHORIZED, "/error/401");
		ErrorPage errorPage403 = new ErrorPage(HttpStatus.FORBIDDEN, "/error/403");
		ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND, "/error/404");
		ErrorPage errorPage500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500");
		ErrorPage errorPageEx = new ErrorPage(RuntimeException.class, "/error/500ex");
		factory.addErrorPages(errorPage400, errorPage401, errorPage403, errorPage404, errorPage500, errorPageEx);
	}
}