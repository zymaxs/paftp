package com.paftp.service.permission;

import com.paftp.entity.Permission;

public interface PermissionService {

	public void savePermission(Permission permission);

	public void updatePermission(Permission permission);

	public Permission findPermissionById(int id);

	public void deletePermission(Permission permission);

}
