package kr.pe.eta.redis;

import org.springframework.data.repository.CrudRepository;

public interface RedisRepository extends CrudRepository<RedisEntity, String> {

}