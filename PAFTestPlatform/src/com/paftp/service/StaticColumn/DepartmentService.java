package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.Department;

public interface DepartmentService {

	public void saveDepartment(Department department);

	public void updateUserInfoDepartment(Department department);

	public Department findDepartmentById(int id);
	
	public List<Department> findAllList();
	
	public Department findDepartmentByName(String name);
}
