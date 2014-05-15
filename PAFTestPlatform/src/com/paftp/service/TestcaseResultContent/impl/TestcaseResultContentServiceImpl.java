package com.paftp.service.TestcaseResultContent.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.service.TestcaseResultContent.TestcaseResultContentService;

@Service("testcaseResultContentService")
public class TestcaseResultContentServiceImpl implements TestcaseResultContentService{

	@Resource
	private BaseDAO<TestcaseResultContent> baseDAO;
	
	@Override
	public void saveTestcaseResultContent(
			TestcaseResultContent testcaseResultContent) {
		// TODO Auto-generated method stub
		baseDAO.save(testcaseResultContent);
	}

	@Override
	public void updateTestcaseResultContent(
			TestcaseResultContent testcaseResultContent) {
		// TODO Auto-generated method stub
		baseDAO.update(testcaseResultContent);
	}

	@Override
	public TestcaseResultContent findTestcaseResultContentById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(TestcaseResultContent.class, id);
	}

	@Override
	public void deleteTestcaseResultContent(
			TestcaseResultContent testcaseResultContent) {
		// TODO Auto-generated method stub
		baseDAO.delete(testcaseResultContent);
	}

	@Override
	public List<TestcaseResultContent> findAllList() {
		// TODO Auto-generated method stub\
		return baseDAO.find(" from testcaseresultcontent u order by u.id");
	}

}
