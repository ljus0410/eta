package kr.pe.eta.web.community;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import kr.pe.eta.domain.Location;
import kr.pe.eta.domain.Message;
import kr.pe.eta.domain.ShareReq;
import kr.pe.eta.service.community.ChatMessageRepository;
import kr.pe.eta.service.community.CommunityService;

@Controller
public class ChatController {

	@Autowired
	private ChatMessageRepository chatMessageRepository;

	@Autowired
	private CommunityService communityService;

	@Autowired
	private SimpMessagingTemplate messagingTemplate;

	@MessageMapping("/chat/start/{callNo}")
	@SendTo("/topic/messages/{callNo}")
	public List<Message> getMessage(@DestinationVariable int callNo) {
		System.out.println("chatcontroller/start");

		List<Message> messages = chatMessageRepository.findByCallNo(callNo);
		System.out.println(messages);

		return messages;
	}

	@MessageMapping("/chat/{callNo}")
	@SendTo("/topic/messages/{callNo}")
	public Message sendMessage(@DestinationVariable int callNo, Message chatMessage) {
		System.out.println("chatcontroller/callNo");

		if (chatMessage.getContent() == "합승") {
			System.out.println(chatMessage);
		} else {
			chatMessage.setTimestamp(new Date());
			System.out.println(chatMessage);

			// 새로운 메시지 저장
			chatMessageRepository.save(chatMessage);
		}

		return chatMessage;
	}

	@MessageMapping("/deal/{driverNo}")
	@SendTo("/topic/deal/{driverNo}")
	public Message sendDeal(Message message) throws Exception {
		System.out.println("chatcontroller/deal");
		return message;
	}

	@MessageMapping("/chat/shareStart/{callNo}")
	public void startShare(@DestinationVariable int callNo, Location location) throws Exception {
		System.out.println("chatcontroller/startShare");

		List<ShareReq> list = communityService.getSharePassengerList(callNo, "운행중");
		System.out.println(list);
		for (int i = 0; i < list.size(); i++) {
			int passengerNo = list.get(i).getFirstSharePassengerNo();
			System.out.println(passengerNo);
			messagingTemplate.convertAndSend("/topic/location/" + passengerNo, location);
		}
	}

	@MessageMapping("/chat/shareEnd/{callNo}")
	public void shareEnd(@DestinationVariable int callNo, String message) throws Exception {
		System.out.println("chatcontroller/shareEnd");

		List<ShareReq> list = communityService.getSharePassengerList(callNo, "운행중");
		System.out.println(list);
		for (int i = 0; i < list.size(); i++) {
			int passengerNo = list.get(i).getFirstSharePassengerNo();
			System.out.println(passengerNo);
			messagingTemplate.convertAndSend("/topic/notifications/" + passengerNo, message);
		}
	}

}
