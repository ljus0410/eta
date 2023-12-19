package kr.pe.eta.service.community;

import kr.pe.eta.domain.Message;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ChatMessageRepository extends MongoRepository<Message, String> {

    List<Message> findByCallNo(int callNo);
}

