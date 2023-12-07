package kr.pe.eta.route;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RouteService {

	private final RouteRepository routeRepository;

	@Autowired
	public RouteService(RouteRepository routeRepository) {
		this.routeRepository = routeRepository;
	}

	public void saveCallData(RouteDTO routeDto) {
		RouteEntity routeEntity = new RouteEntity();
		routeEntity.setCallNo(routeDto.getCallNo());
		routeEntity.setRoute(routeDto.getRoute());
		routeRepository.save(routeEntity);
	}

	public RouteEntity findById(int routeId) {
		return routeRepository.findById(routeId).orElse(null);
	}

	// 기타 메소드
}
