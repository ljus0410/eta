package kr.pe.eta.redis;

import org.springframework.data.redis.core.RedisHash;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@RedisHash("RedisEntity")
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class RedisEntity {

	@Id
	private String id;// email

	private Double CurrentX;
	private Double CurrentY;

	// private List<String> skils; // List 필요시

}