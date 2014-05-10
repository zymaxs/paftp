package com.paftp.service.auth;

import java.util.List;

import com.paftp.entity.Auth;

public interface AuthService {

	public void saveAuth(Auth auth);

	public void updateAuth(Auth Auth);

	public Auth findAuthById(int id);

	public Auth findAuthByName(String name);

	public void deleteAuth(Auth auth);

	public List<Auth> findAllList();

	// public User findUserByNameAndPassword(String username, String password);

}
