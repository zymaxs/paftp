package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.UserinfoDepartment;
import com.paftp.service.StaticColumn.UserinfoDepartmentService;

@Service("userinfoDepartmentService")
public class UserinfoDepartmentServiceImpl implements UserinfoDepartmentService{

	@Resource
	private BaseDAO<UserinfoDepartment> baseDAO;
	
	@Override
	public void saveUserInfoDepartment(UserinfoDepartment userInfoDepartment) {
		// TODO Auto-generated method stub
		baseDAO.save(userInfoDepartment);
	}

	@Override
	public void updateUserInfoDepartment(UserinfoDepartment userInfoDepartment) {
		// TODO Auto-generated method stub
		baseDAO.update(userInfoDepartment);
	}

	@Override
	public UserinfoDepartment findUserInfoDepartmentById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(UserinfoDepartment.class, id);
	}

	@Override
	public List<UserinfoDepartment> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from UserinfoDepartment ud");
	}

}
