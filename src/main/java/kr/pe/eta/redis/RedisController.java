package kr.pe.eta.redis;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class RedisController {

	private final RedisService serivce;

	@PostMapping("/redis/v1/post")
	public RedisEntity addUser(@RequestBody RedisEntity user) {
		log.info("Controller Request: {}", user);

		RedisEntity result = serivce.addUser(user);

		log.info("Controller result: {}", result);

		return result;
	}// save

	@GetMapping("/redis/v1/getUser")
	public RedisEntity getUser(@RequestParam String email) {
		RedisEntity userEmail = serivce.getUserById(email);
		return userEmail;
	}

	@DeleteMapping("/redis/v1/deleteUser")
	public void deleteUser(HttpSession session) {
		// 세션에서 user 객체를 가져옵니다.
		User user = (User) session.getAttribute("user");

		if (user != null) {
			int userNo = user.getUserNo();
			log.info("Deleting user with ID: {}", userNo);

			// Redis에서 사용자 정보를 삭제합니다.
			serivce.deleteUser(session);

			log.info("User with ID: {} deleted successfully", userNo);
		} else {
			// 세션에 user 정보가 없을 경우의 처리
			log.error("No user found in session");
		}
	}

}
