package kr.pe.eta;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class EtaApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(EtaApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		// TODO Auto-generated method stub
		return builder.sources(EtaApplication.class);
//		return super.configure(builder);
	}
//	@Bean
//	public ServerEndpointExporter serverEndpointExporter() {
//		return new ServerEndpointExporter();
//	}

}
