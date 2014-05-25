package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.UserinfoDepartment;

public interface UserinfoDepartmentService {

	public void saveUserInfoDepartment(UserinfoDepartment userInfoDepartment);

	public void updateUserInfoDepartment(UserinfoDepartment userInfoDepartment);

	public UserinfoDepartment findUserInfoDepartmentById(int id);
	
	public List<UserinfoDepartment> findAllList();
}
