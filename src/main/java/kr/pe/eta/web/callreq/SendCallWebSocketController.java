package kr.pe.eta.web.callreq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SendCallWebSocketController {

	private static final Logger logger = LoggerFactory.getLogger(SendCallWebSocketController.class);

	@Autowired
	private SimpMessagingTemplate template;

	@MessageMapping("/sendCall/{driverNo}")
	public void receiveLocation(@DestinationVariable String driverNo, int callNo) {
		// 로그에 데이터 출력
		logger.info("Received callNo = " + callNo);
		// 위치 데이터 전송
		template.convertAndSend("/topic/call/" + driverNo, callNo);
	}

	@MessageMapping("/sendCall")
	@SendTo("/topic/notifications")
	public String sendNotification(String message) {
		return message;
	}

	@GetMapping("/test")
	public String test() {
		return "test"; // JSP 파일 이름
	}
}
