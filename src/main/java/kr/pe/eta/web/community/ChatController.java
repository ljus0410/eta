package kr.pe.eta.web.community;

import jakarta.websocket.server.PathParam;
import kr.pe.eta.domain.Call;
import kr.pe.eta.domain.DealReq;
import kr.pe.eta.domain.Message;
import kr.pe.eta.service.community.ChatMessageRepository;
import kr.pe.eta.service.community.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ChatController {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private CommunityService communityService;

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

        chatMessage.setTimestamp(new Date());
        System.out.println(chatMessage);

            // 새로운 메시지 저장
        chatMessageRepository.save(chatMessage);

        return chatMessage;
    }

    @MessageMapping("/deal/{driverNo}")
    @SendTo("/topic/deal/{driverNo}")
    public Message sendDeal(Message message) throws Exception {
        return message;
    }
}
