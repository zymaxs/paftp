package com.paftp.service.auth.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Auth;
import com.paftp.entity.Team;
import com.paftp.entity.User;
import com.paftp.service.auth.AuthService;
import com.paftp.service.team.TeamService;

@Service("authService")
public class AuthServiceImpl implements AuthService {

	@Resource
	private BaseDAO<Auth> baseDAO;

	// @Resource
	// private BaseDAO<User> userDAO;

	@Override
	public void saveAuth(Auth auth) {
		baseDAO.save(auth);
	}

	@Override
	public void updateAuth(Auth auth) {
		baseDAO.update(auth);
	}

	@Override
	public Auth findAuthById(int id) {
		return baseDAO.get(Auth.class, id);
	}

	@Override
	public Auth findAuthByName(String authname) {
		return baseDAO.get(" from Auth u where u.authName = ?",
				new Object[] { authname });
	}

	@Override
	public void deleteAuth(Auth auth) {
		// List<User> users = team.getUsers();
		// int size = team.getUsers().size();
		// for(int i=0;i<size;i++){
		// users.get(i).setTeam(null);
		// userDAO.update(users.get(i));
		// }
		baseDAO.delete(auth);

	}

	@Override
	public List<Auth> findAllList() {
		return baseDAO.find(" from Auth");
	}

}
