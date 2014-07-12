package com.paftp.service.TestcassResult.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testsuite;
import com.paftp.service.TestcassResult.TestcaseResultService;

@Service("testcaseResultService")
public class TestcaseResultServiceImpl implements TestcaseResultService{

	@Resource
	private BaseDAO<TestcaseResult> baseDAO;
	
	@Override
	public void saveTestcaseResult(TestcaseResult testcaseResult) {
		// TODO Auto-generated method stub
		baseDAO.save(testcaseResult);
	}

	@Override
	public void updateTestcaseResult(TestcaseResult testcaseResult) {
		// TODO Auto-generated method stub
		baseDAO.update(testcaseResult);
	}

	@Override
	public TestcaseResult findTestcaseResultById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(TestcaseResult.class, id);
	}

	@Override
	public TestcaseResult findTestcaseResultByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from testcaseresult u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteTestcaseResult(TestcaseResult testcaseResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(testcaseResult);
	}

	@Override
	public List<TestcaseResult> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from testcaseresult u order by u.id");
	}

	@Override
	public List<TestcaseResult> findAllCaseresultByMultiConditions(
			HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		List<TestcaseResult> testcase_results = baseDAO.findbyconditionsfortestsuites(conditions);
		return testcase_results;
	}

}
