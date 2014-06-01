package com.paftp.service.permission.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Permission;
import com.paftp.service.permission.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

	@Resource
	private BaseDAO<Permission> baseDAO;

	@Override
	public void savePermission(Permission permission) {
		baseDAO.save(permission);
	}

	@Override
	public void updatePermission(Permission permission) {
		baseDAO.update(permission);
	}

	@Override
	public Permission findPermissionById(int id) {
		return baseDAO.get(Permission.class, id);
	}

	
	@Override
	public void deletePermission(Permission permission) {
		baseDAO.delete(permission);
	}

	@Override
	public Permission findPermissionByScope(String scope) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Permission p where p.scope = ?",
				new Object[] { scope });
	}
	
	@Override
	public List<Permission> findAllList() {
		return baseDAO.find(" from Permission p");
	}


}
