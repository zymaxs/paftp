package com.paftp.service.TestcassResult.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.TestcaseResultDto;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.Testcase;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testsuite;
import com.paftp.service.TestcassResult.TestcaseResultService;

@Service("testcaseResultService")
public class TestcaseResultServiceImpl implements TestcaseResultService{

	@Resource
	private BaseDAO<TestcaseResult> baseDAO;
	@Resource
	private BaseDAO<Integer> baseIntegerDAO;
	
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
		return baseDAO.get(" from TestcaseResult u where u.name = ?",
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
		return baseDAO.find(" from TestcaseResult u order by u.id");
	}

	@Override
	public List<TestcaseResult> findAllCaseresultByMultiConditions(
			HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		List<TestcaseResult> testcase_results = baseDAO.findbyconditionsforcaseresults(conditions);
		return testcase_results;
	}
	
	@Override
	public Integer findCountOfCaseresults(HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		Boolean tag = true;
		Iterator<Entry<String, Object>> iter = conditions.entrySet().iterator();
		StringBuffer sqlbuffer = new StringBuffer();
		sqlbuffer.append("select count(*) from TestcaseResult u ");
		while (iter.hasNext()){
			if (tag){
				sqlbuffer.append("where ");
				tag = false;
			} else{
				sqlbuffer.append("and ");
			}
			Entry<String, Object> condition = iter.next();
			if (condition != null && condition.equals("") == false){
				if (condition.getKey().indexOf(".") != -1){
			sqlbuffer.append(condition.getKey() + " = " + condition.getValue() + " ");
				} else{
					sqlbuffer.append("u." + condition.getKey() + " = " + condition.getValue() + " ");
				}
			}
		}
		Long i = baseDAO.count(sqlbuffer.toString());
		return Integer.parseInt(i.toString());

	}
	
	@Override
	public List<Integer> findCountsOfCaseresults(Integer testsuite_id) {
		// TODO Auto-generated method stub
		return baseIntegerDAO.find("select count(*) from TestcaseResult t where testsuite_result.id = ? group by ispass", new Object[] { testsuite_id });
	}

	@Override
	public List<Integer> findPassedCounts(Integer testsuite_id) {
		// TODO Auto-generated method stub
		return baseIntegerDAO.find("select count(*) from TestcaseResult t where testsuite_result.id = ? and ispass=0", new Object[] { testsuite_id });
	}

	@Override
	public List<Integer> findFailedCounts(Integer testsuite_id) {
		// TODO Auto-generated method stub
		return baseIntegerDAO.find("select count(*) from TestcaseResult t where testsuite_result.id = ? and ispass=1", new Object[] { testsuite_id });
	}
	
	@Override
	public TestcaseResultDto getTestcaseResultDto(TestcaseResult testcaseresult, AnalyseCommentHistory analyseCommentHistory) {
		// TODO Auto-generated method stub
		TestcaseResultDto testcaseresultDto = new TestcaseResultDto();
		
		testcaseresultDto.setId(testcaseresult.getId());
		testcaseresultDto.setIspass(testcaseresult.getIspass());
		testcaseresultDto.setDescription(testcaseresult.getDescription());
		testcaseresultDto.setCasename(testcaseresult.getCasename());
		
		Testcase testcase = new Testcase();
		if(testcaseresult.getTestcase() != null){
			testcase.setDescription(testcaseresult.getTestcase().getDescription());
			testcase.setCasetype(testcaseresult.getTestcase().getCasetype());
		}
		testcaseresultDto.setTestcase(testcase);
		
		if (analyseCommentHistory != null){
			testcaseresultDto.setStatus(analyseCommentHistory.getNewstatus());
		} else {
			testcaseresultDto.setStatus("未处理");
		}
		
		return testcaseresultDto;
	}


}
