package kr.pe.eta.route;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface RouteRepository extends MongoRepository<RouteEntity, Integer> {
	// 기본 CRUD 메소드 제공
}
