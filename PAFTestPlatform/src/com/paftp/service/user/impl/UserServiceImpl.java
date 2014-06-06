package com.paftp.service.user.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.ApplySutDto;
import com.paftp.dto.UserDto;
import com.paftp.entity.Permission;
import com.paftp.entity.Role;
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

	@Override
	public UserDto getUserDto(User user) {
		// TODO Auto-generated method stub
		UserDto userDto = new UserDto();

		List<Role> rolesDto = new ArrayList<Role>();
		List<Role> roles = user.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			List<Permission> permissions = roles.get(i).getPermissions();
			if (permissions != null && permissions.size() > 0) {
				rolesDto.get(i).setPermissions(permissions);
			}
		}

		userDto.setRoles(rolesDto);
		userDto.setUserInfo(user.getUserInfo());

		userDto.setAlias(user.getAlias());
		userDto.setCreateTime(user.getCreateTime());
		userDto.setDisplayName(user.getDisplayName());
		userDto.setId(user.getId());
		userDto.setPassword(user.getPassword());
		userDto.setStatus(user.getStatus());
		userDto.setUpdateTime(user.getUpdateTime());

		return userDto;
	}

}
