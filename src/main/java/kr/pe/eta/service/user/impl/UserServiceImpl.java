package kr.pe.eta.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Point;
import org.springframework.stereotype.Service;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;
import kr.pe.eta.service.user.UserDao;
import kr.pe.eta.service.user.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addUser(User user) throws Exception {
		userDao.addUser(user);

	}

	@Override
	public User getUser(String email) throws Exception {

		return userDao.getUser(email);
	}

	@Override
	public Map<String, Object> getUserList(Search search) throws Exception {
		List<User> list = userDao.getUserList(search);
		Map<String, Object> map = new HashMap<String, Object>();
		int drivertotalCount = userDao.getDriverCount(search);
		int passengertotalCount = userDao.getPassengerCount(search);
		map.put("list", list);
		map.put("drivertotalCount", new Integer(drivertotalCount));
		map.put("passengertotalCount", new Integer(passengertotalCount));

		System.out.println("passengertotalCount " + passengertotalCount);
		System.out.println("drivertotalCount " + drivertotalCount);
		map.put("list", list);
		return map;
	}

	@Override
	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);

	}

	@Override
	public void updatePwd(User user) throws Exception {
		userDao.updatePwd(user);

	}

	@Override
	public void deleteUser(String eamil) throws Exception {
		userDao.deleteUser(eamil);
	}

	@Override
	public boolean dupEmail(String eamil) throws Exception {
		boolean result = true;
		User user = userDao.getEmail(eamil);

		// 중복이 false
		if (user != null) {
			result = false;
		}
		return result;
	}

	@Override
	public boolean dupNickname(String nickName) throws Exception {
		boolean result = true;
		User user = userDao.getNickName(nickName);

		// 중복이 false
		if (user != null) {
			result = false;
		}
		return result;
	}

	@Override
	public Map<String, Object> autoUserList(Search search) throws Exception {
		List<User> list = userDao.getUserList(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);

		return map;
	}

	public int getPassengerCount(Search search) throws Exception {
		return userDao.getPassengerCount(search);
	}

	public int getDriverCount(Search search) throws Exception {
		return userDao.getDriverCount(search);

	}

	@Override
	public User getUsers(int userNo) throws Exception {
		return userDao.getUsers(userNo);
	}

	public double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
		double EARTH_RADIUS_KM = 6371.0;
		// 위도, 경도를 라디안으로 변환
		double dLat = Math.toRadians(lat2 - lat1);
		double dLon = Math.toRadians(lon2 - lon1);
		lat1 = Math.toRadians(lat1);
		lat2 = Math.toRadians(lat2);

		// 헤버사인 공식 적용
		double a = Math.pow(Math.sin(dLat / 2), 2) + Math.pow(Math.sin(dLon / 2), 2) * Math.cos(lat1) * Math.cos(lat2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		// 최종 거리 계산
		return EARTH_RADIUS_KM * c;
	}

	@Override
	public Point calculateRandomLocation() {
		double up = 37.52649623241025;// 압구정역
		double down = 37.470153474090004;// 양재시민의 숲역
		double right = 127.06318985913586;// 대치역
		double left = 126.99360017801428;// 내방역
		Random random = new Random();
		double randomupdown = down + (up - down) * random.nextDouble();
		double randomleftright = left + (right - left) * random.nextDouble();

		return new Point(randomupdown, randomleftright);
	}
}
