package com.paftp.service.permission;

import java.util.List;

import com.paftp.entity.Permission;

public interface PermissionService {

	public void savePermission(Permission permission);

	public void updatePermission(Permission permission);

	public Permission findPermissionById(int id);

	public Permission findPermissionByScope(String scope);
	
	public void deletePermission(Permission permission);
	
	public List<Permission> findAllList();

}
