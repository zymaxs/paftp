package com.paftp.service.Testcase;

import java.util.HashMap;
import java.util.List;

import com.paftp.dto.TestcaseCountDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface TestcaseService {

	public void saveTestcase(Testcase testcase);

	public void updateTestcase(Testcase testcase);

	public Testcase findTestcaseById(int id);

	public Testcase findTestcaseByName(String name);
	
	public List<Testcase> findAllCaseByMultiConditions(HashMap<String, Object> conditions);
	
	public Testcase findTestcaseByNameAndTestsuiteid(String name, Integer id);

	public void deleteTestcase(Testcase testcase);

	public List<Testcase> findAllList();
	
	public List<TestcaseCountDto> queryCountByColumn(String name);
	
	public List<TestcaseCountDto> queryCountByPriority();
	
	public List<TestcaseCountDto> queryCountByStatus();
	
	public List<TestcaseCountDto> queryCountByCasetype();

	public List<TestcaseCountDto> queryCountByApproval();
	
	public List queryCountByPriorityAndTestsuiteid(Integer id);
	
	public List queryCountByStatusAndTestsuiteid(Integer id);
	
	public List queryCountByCasetypeAndTestsuiteid(Integer id);

	public List queryCountByApprovalAndTestsuiteid(Integer id);
	//public User findUserByNameAndPassword(String username, String password);

}
