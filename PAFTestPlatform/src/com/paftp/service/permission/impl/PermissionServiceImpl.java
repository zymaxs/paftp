package com.paftp.service.permission.impl;

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

}
