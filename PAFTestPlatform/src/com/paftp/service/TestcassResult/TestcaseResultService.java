package com.paftp.service.TestcassResult;

import java.util.List;

import com.paftp.entity.TestcaseResult;

public interface TestcaseResultService {
	public void saveTestcaseResult(TestcaseResult testcaseResult);

	public void updateTestcaseResult(TestcaseResult testcaseResult);

	public TestcaseResult findTestcaseResultById(int id);

	public TestcaseResult findTestcaseResultByName(String name);

	public void deleteTestcaseResult(TestcaseResult testcaseResult);

	public List<TestcaseResult> findAllList();
}
