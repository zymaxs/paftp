package com.paftp.service.user;

import java.util.List;

import com.paftp.entity.User;

public interface UserService {

	public void saveUser(User user);

	public void updateUser(User user);

	public User findUserById(int id);

	public User findUserByAlias(String alias);

	public void deleteUser(User user);

	public List<User> findAllList();

	public User findUserByAliasAndPassword(String alias, String password);

}
