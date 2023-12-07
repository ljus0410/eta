package kr.pe.eta.route;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/route")
public class RouteRestController {

	private final RouteService routeService;

	@Autowired
	public RouteRestController(RouteService routeService) {
		this.routeService = routeService;
	}

	@PostMapping("/saveRoute")
	public ResponseEntity<?> saveRoute(@RequestBody RouteDTO routeDto) {
		System.out.println("routesqveRoute");
		try {
			routeService.saveCallData(routeDto);
			return ResponseEntity.ok().body("Route data saved successfully");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving route data");
		}
	}

	@GetMapping("/{id}")
	public ResponseEntity<?> getRouteById(@PathVariable String id) {
		int routeId = Integer.parseInt(id);
		RouteEntity route = routeService.findById(routeId);
		System.out.println("Received request for ID: " + id);
		if (route != null) {
			return ResponseEntity.ok(route);
		} else {
			System.out.println("No route found for ID: " + id);
			return ResponseEntity.notFound().build();
		}
	}
}
