package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Department;
import com.paftp.service.StaticColumn.DepartmentService;

@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService{

	@Resource
	private BaseDAO<Department> baseDAO;
	
	@Override
	public void saveDepartment(Department department) {
		// TODO Auto-generated method stub
		baseDAO.save(department);
	}

	@Override
	public void updateUserInfoDepartment(Department department) {
		// TODO Auto-generated method stub
		baseDAO.update(department);
	}

	@Override
	public Department findDepartmentById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(Department.class, id);
	}

	@Override
	public List<Department> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from Department d");
	}

	@Override
	public Department findDepartmentByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Department dp where dp.name = ?",
				new Object[] { name });
	}

}
