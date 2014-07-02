package com.paftp.service.Testcase;

import java.util.HashMap;
import java.util.List;

import com.paftp.entity.Testcase;

public interface TestcaseService {

	public void saveTestcase(Testcase testcase);

	public void updateTestcase(Testcase testcase);

	public Testcase findTestcaseById(int id);

	public Testcase findTestcaseByName(String name);
	
	public List<Testcase> findAllCaseByMultiConditions(HashMap<String, Object> conditions);
	
	public Testcase findTestcaseByNameAndTestsuiteid(String name, Integer id);

	public void deleteTestcase(Testcase testcase);

	public List<Testcase> findAllList();
	
	public List<Object[]> queryCountByPriority();
	
	public List<Object[]> queryCountByStatus();
	
	public List<Object[]> queryCountByCasetype();

	public List<Object[]> queryCountByApproval();
	
	public List<Object[]> queryCountByPriorityAndTestsuiteid(Integer id);
	
	public List<Object[]> queryCountByStatusAndTestsuiteid(Integer id);
	
	public List<Object[]> queryCountByCasetypeAndTestsuiteid(Integer id);

	public List<Object[]> queryCountByApprovalAndTestsuiteid(Integer id);
	//public User findUserByNameAndPassword(String username, String password);

}
