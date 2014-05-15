package com.paftp.service.TestsuiteResult;

import java.util.List;

import com.paftp.entity.TestsuiteResult;

public interface TestsuiteResultService {

	public void saveTestsuiteResult(TestsuiteResult testsuiteResult);

	public void updateTestsuiteResult(TestsuiteResult testsuiteResult);

	public TestsuiteResult findTestsuiteResultById(int id);

	public TestsuiteResult findTestsuiteResultByName(String name);

	public void deleteTestsuiteResult(TestsuiteResult testsuiteResult);

	public List<TestsuiteResult> findAllList();
}
