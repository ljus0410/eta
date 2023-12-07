package kr.pe.eta.service.user;

import java.util.Map;

import org.springframework.data.geo.Point;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;

public interface UserService {

	// 회원가입
	public void addUser(User user) throws Exception;

	// 내정보확인
	public User getUser(String email) throws Exception;

	// 회원리스트
	public Map<String, Object> getUserList(Search search) throws Exception;

	// 정보수정
	public void updateUser(User user) throws Exception;

	// pwd수정
	public void updatePwd(User user) throws Exception;

	// 이메일 중복체크
	public boolean dupEmail(String eamil) throws Exception;

	// 닉네임 중복체크
	public boolean dupNickname(String nickName) throws Exception;

	// 회원탈퇴
	public void deleteUser(String eamil) throws Exception;

	// aoto
	public Map<String, Object> autoUserList(Search search) throws Exception;

	public int getPassengerCount(Search search) throws Exception;

	public int getDriverCount(Search search) throws Exception;

	public Point calculateRandomLocation();

	public double haversineDistance(double lat1, double lon1, double lat2, double lon2);

}
