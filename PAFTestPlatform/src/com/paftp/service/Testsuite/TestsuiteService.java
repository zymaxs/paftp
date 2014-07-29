package com.paftp.service.Testsuite;

import java.util.HashMap;
import java.util.List;

import com.paftp.dto.TestcaseDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;

public interface TestsuiteService {

	public void saveTestsuite(Testsuite testsuite);

	public void updateTestsuite(Testsuite testsuite);

	public Testsuite findTestsuiteById(int id);
	
	public Testsuite findTestsuiteByNameAndSutid(String name, Integer id);
	
	public List<Testsuite> findTestsuiteByVersionAndSutid(String version_num, Integer id);

	public void deleteTestsuite(Testsuite testsuite);

	public List<Testsuite> findAllList();
	
	public List<Testsuite> findAllSuiteByMultiConditions(HashMap<String, Object> conditions);

	public TestsuiteDto getTestsuiteDto(Testsuite testsuite);
	
	public TestcaseDto getTestcaseDto(Testcase testcase, List<CaseChangeHistory> casechangehistories_source);

}
