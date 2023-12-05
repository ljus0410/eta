package kr.pe.eta.service.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.pe.eta.common.Search;
import kr.pe.eta.domain.User;

@Mapper
public interface UserDao {

	public void addUser(User user) throws Exception;

	public List<User> getUserList(Search search) throws Exception;

	public void updateUser(User user) throws Exception;

	public User getNickName(String nickName);

	public User getEmail(String email) throws Exception;

	public void updatePwd(User user) throws Exception;

	public User getUser(String email) throws Exception;

	public void deleteUser(String eamil) throws Exception;

	public int getPassengerCount(Search search) throws Exception;

	public int getDriverCount(Search search) throws Exception;

}