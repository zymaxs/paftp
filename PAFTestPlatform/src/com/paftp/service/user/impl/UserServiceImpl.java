package com.paftp.service.user.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.User;
import com.paftp.service.user.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
	private BaseDAO<User> baseDAO;

	@Override
	public void saveUser(User user) {
		baseDAO.save(user);
	}

	@Override
	public void updateUser(User user) {
		baseDAO.update(user);
	}

	@Override
	public User findUserById(int id) {
		return baseDAO.get(User.class, id);
	}

	@Override
	public User findUserByAlias(String alias) {
		return baseDAO.get(" from User u where u.alias = ?",
				new Object[] { alias });
	}

	@Override
	public void deleteUser(User user) {
		baseDAO.delete(user);
	}

	@Override
	public List<User> findAllList() {
		return baseDAO.find(" from User u order by u.createTime");
	}

	@Override
	public User findUserByAliasAndPassword(String alias, String password) {
		return baseDAO.get(
				" from User u where u.alias = ? and u.password = ? ",
				new Object[] { alias, password });
	}

}
