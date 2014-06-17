package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.TestcaseProject;

public interface TestcaseProjectService {
	
	public void saveTestcaseProject(TestcaseProject testcaseProject);

	public void updateTestcaseProject(TestcaseProject testcaseProject);

	public TestcaseProject findTestcaseProjectById(int id);

	public void deleteTestcaseProject(TestcaseProject testcaseProject);

	public List<TestcaseProject> findAllList();

	public TestcaseProject findTestcaseProjectByName(String name);
}
