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
		ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND, "/common/404.jsp");
		ErrorPage errorPage400 = new ErrorPage(HttpStatus.BAD_REQUEST, "/common/400.jsp");
		ErrorPage errorPage500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/common/500.jsp");
		ErrorPage errorPageEx = new ErrorPage(RuntimeException.class, "/common/500ex.jsp");
		factory.addErrorPages(errorPage404, errorPage400, errorPage500, errorPageEx);
	}
}