package kr.pe.eta.domain;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Data
@Document
public class Message {

    @Id
    private String id;

    private int callNo;
    private String content;
    private String sender;
    private Date timestamp;
    private String time;

}


