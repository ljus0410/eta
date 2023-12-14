package kr.pe.eta.redis;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpSession;
import kr.pe.eta.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RedisService {

	private final RedisRepository repository;
	private final AddCallRepository addCallRepository;

	@Transactional
	public RedisEntity addUser(RedisEntity user) {
		// save
		RedisEntity save = repository.save(user);

		// find
		Optional<RedisEntity> result = repository.findById(save.getId());

		// Handling
		// 해당 data 존재시 return.
		if (result.isPresent()) {
			return result.get();
		} else {
			throw new RuntimeException("Database has no Data");
		}
	}// save

	@Transactional(readOnly = true)
	public RedisEntity getUserById(String reqId) {
		Optional<RedisEntity> result = repository.findById(reqId);

		// Handling
		if (result.isPresent()) {
			return result.get();
		} else {
			throw new RuntimeException("Database has no Data");
		}
	}

	@Transactional(readOnly = true)
	public List<RedisEntity> getAllUser() {
		List<RedisEntity> userList = (List<RedisEntity>) repository.findAll();

		// Handling
		if (!userList.isEmpty()) {
			return userList;
		} else {
			throw new RuntimeException("Database has no Data");
		}
	}

	@Transactional
	public void deleteUser(HttpSession session) {
		// Redis에서 사용자 정보를 삭제합니다.

		User user = (User) session.getAttribute("user");
		String userNo = String.valueOf(user.getUserNo());

		repository.deleteById(userNo);
	}

	@Transactional
	public void addCall(AddCallEntity call) {
		// save
		addCallRepository.save(call);

	}

	@Transactional
	public void deleteCall(AddCallEntity call) {
		// Redis에서 사용자 정보를 삭제합니다.

		addCallRepository.delete(call);
	}

}