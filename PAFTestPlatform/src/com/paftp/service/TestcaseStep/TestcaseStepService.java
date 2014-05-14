package com.paftp.service.TestcaseStep;

import java.util.List;

import com.paftp.entity.TestcaseStep;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface TestcaseStepService {

	public void saveTestcaseStep(TestcaseStep testcasestep);

	public void updateTestcaseStep(TestcaseStep testcasestep);

	public TestcaseStep findTestcaseStepById(int id);

	//public CaseContent findCaseContentByName(String name);

	public void deleteTestcaseStep(TestcaseStep testcasestep);

	public List<TestcaseStep> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
