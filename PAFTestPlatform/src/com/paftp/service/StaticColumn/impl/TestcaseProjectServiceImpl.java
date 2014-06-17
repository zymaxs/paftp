package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TestcaseProject;
import com.paftp.service.StaticColumn.TestcaseProjectService;

@Service("testcaseProjectService")
public class TestcaseProjectServiceImpl implements TestcaseProjectService{

	@Resource
	private BaseDAO<TestcaseProject> baseDAO;
	
	@Override
	public void saveTestcaseProject(TestcaseProject testcaseProject) {
		// TODO Auto-generated method stub
		baseDAO.save(testcaseProject);
	}

	@Override
	public void updateTestcaseProject(TestcaseProject testcaseProject) {
		// TODO Auto-generated method stub
		baseDAO.update(testcaseProject);
	}

	@Override
	public TestcaseProject findTestcaseProjectById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(TestcaseProject.class, id);
	}

	@Override
	public void deleteTestcaseProject(TestcaseProject testcaseProject) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TestcaseProject> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from TestcaseProject t");
	}

	@Override
	public TestcaseProject findTestcaseProjectByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from TestcaseProject t where t.name = ?",
				new Object[] { name });
	}

}
