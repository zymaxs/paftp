package com.paftp.service.role.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Role;
import com.paftp.service.role.RoleService;


@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
	private BaseDAO<Role> baseDAO;

	@Override
	public void saveRole(Role role) {
		baseDAO.save(role);
	}

	@Override
	public void updateRole(Role role) {
		baseDAO.update(role);
	}

	@Override
	public Role findRoleById(int id) {
		return baseDAO.get(Role.class, id);
	}

	
	@Override
	public Role findRoleByName(String name) {
		return baseDAO.get(" from Role r where r.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteRole(Role role) {
		baseDAO.delete(role);
	}

	@Override
	public List<Role> findAllList() {
		return baseDAO.find(" from Role r order by r.id");
	}

}
