package com.paftp.service.TestcassResult;

import java.util.HashMap;
import java.util.List;

import com.paftp.dto.TestcaseResultDto;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.TestcaseResult;

public interface TestcaseResultService {
	public void saveTestcaseResult(TestcaseResult testcaseResult);

	public void updateTestcaseResult(TestcaseResult testcaseResult);

	public TestcaseResult findTestcaseResultById(int id);

	public TestcaseResult findTestcaseResultByName(String name);

	public void deleteTestcaseResult(TestcaseResult testcaseResult);

	public List<TestcaseResult> findAllList();
	
	public List<TestcaseResult> findAllCaseresultByMultiConditions(HashMap<String, Object> conditions);

	public Integer findCountOfCaseresults(HashMap<String, Object> conditions);
	
	public List<Integer> findCountsOfCaseresults(Integer testsuite_id);
	
	public TestcaseResultDto getTestcaseResultDto(TestcaseResult testcaseresult, AnalyseCommentHistory analyseCommentHistory);

	public List<Integer> findPassedCounts(Integer testsuite_id);

	public List<Integer> findFailedCounts(Integer testsuite_id);
}
