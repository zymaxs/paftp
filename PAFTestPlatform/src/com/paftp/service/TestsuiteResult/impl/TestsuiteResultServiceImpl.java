package com.paftp.service.TestsuiteResult.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TestsuiteResult;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;

@Service("testsuiteResultService")
public class TestsuiteResultServiceImpl implements TestsuiteResultService{

	@Resource
	private BaseDAO<TestsuiteResult> baseDAO;
	
	@Override
	public void saveTestsuiteResult(TestsuiteResult testsuiteResult) {
		// TODO Auto-generated method stub
		baseDAO.save(testsuiteResult);
	}

	@Override
	public void updateTestsuiteResult(TestsuiteResult testsuiteResult) {
		// TODO Auto-generated method stub
		baseDAO.update(testsuiteResult);
	}

	@Override
	public TestsuiteResult findTestsuiteResultById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(TestsuiteResult.class, id);
	}

	@Override
	public TestsuiteResult findTestsuiteResultByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from testsuiteresult u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteTestsuiteResult(TestsuiteResult testsuiteResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(testsuiteResult);
	}

	@Override
	public List<TestsuiteResult> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from testsuiteresult u order by u.id");
	}

}
