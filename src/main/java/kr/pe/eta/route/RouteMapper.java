package kr.pe.eta.route;

public class RouteMapper {

	public RouteEntity toEntity(RouteDTO dto) {
		RouteEntity Routentity = new RouteEntity();
		Routentity.setCallNo(dto.getCallNo());
		Routentity.setRoute(dto.getRoute());
		return Routentity;
	}

	public RouteDTO toDto(RouteEntity entity) {
		RouteDTO dto = new RouteDTO();
		dto.setCallNo(entity.getCallNo());
		dto.setRoute(entity.getRoute());
		return dto;
	}
}
