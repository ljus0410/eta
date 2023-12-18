package kr.pe.eta.redis;

import org.springframework.data.redis.core.RedisHash;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@RedisHash("AddCallEntity")
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AddCallEntity {

	@Id
	private String id;// driverNo

	private int callNo;

}