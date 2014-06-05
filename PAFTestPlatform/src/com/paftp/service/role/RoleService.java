package com.paftp.service.role;

import java.util.List;

import com.paftp.entity.Role;

public interface RoleService {

	public void saveRole(Role role);

	public void updateRole(Role role);
	
	public void saveorupdateRole(Role role);

	public Role findRoleById(int id);
	
	public Role findRoleByName(String name);
	
	public List<Role> findRoleBySutId(Integer id);
	
	public Role findRoleBySutIdAndName(Integer id, String name);

	public void deleteRole(Role sut);

	public List<Role> findAllList();


}
