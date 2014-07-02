package com.paftp.service.Testcase.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.TestcaseCountDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.user.UserService;

@Service("testcaseService")
public class TestcaseServiceImpl implements TestcaseService {

	@Resource
	private BaseDAO<Testcase> baseDAO;
	
	@Resource
	private BaseDAO<Object[]> baseDAODto;

	@Override
	public void saveTestcase(Testcase testcase) {
		baseDAO.save(testcase);
	}

	@Override
	public void updateTestcase(Testcase testcase) {
		baseDAO.update(testcase);
	}

	@Override
	public Testcase findTestcaseById(int id) {
		return baseDAO.get(Testcase.class, id);
	}

	@Override
	public Testcase findTestcaseByName(String name) {
		return baseDAO.get(" from Testcase u where u.caseName = ?",
				new Object[] { name });
	}

	@Override
	public void deleteTestcase(Testcase testcase) {
		baseDAO.delete(testcase);
	}

	@Override
	public List<Testcase> findAllList() {
		return baseDAO.find(" from Testcase u order by u.createTime");
	}

	@Override
	public Testcase findTestcaseByNameAndTestsuiteid(String name, Integer id) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Testcase u where u.caseName = ? and testsuite.id = ?",
				new Object[] { name, id });
	}

	@Override
	public List<Testcase> findAllCaseByMultiConditions(
			HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		List<Testcase> testcases = baseDAO.findbyconditions(conditions);
		return testcases;
	}

	@Override
	public List<Object[]> queryCountByPriorityAndTestsuiteid(Integer id) {
		return baseDAODto.getgroup("select t.priority, count(*) from Testcase t where testsuite.id = ? group by t.priority", new Object[] {id});
		
	}

	@Override
	public List<Object[]> queryCountByStatusAndTestsuiteid(Integer id) {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.status, count(*) from Testcase t where testsuite.id = ? group by t.status ", new Object[] {id});
	}

	@Override
	public List<Object[]> queryCountByCasetypeAndTestsuiteid(
			Integer id) {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.casetype, count(*) from Testcase t where testsuite.id = ? group by t.casetype", new Object[] {id});
		
	}

	@Override
	public List<Object[]> queryCountByApprovalAndTestsuiteid(
			Integer id) {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.testcase_approval, count(*) from Testcase t where testsuite.id = ? group by t.testcase_approval", new Object[] {id});
		
	}

	@Override
	public List<Object[]> queryCountByPriority() {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.priority, count(*) from Testcase t group by t.priority");
		
	}

	@Override
	public List<Object[]> queryCountByStatus() {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.status, count(*) from Testcase t group by t.status ");
		
	}

	@Override
	public List<Object[]> queryCountByCasetype() {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.casetype, count(*) from Testcase t group by t.casetype");
		
	}

	@Override
	public List<Object[]> queryCountByApproval() {
		// TODO Auto-generated method stub
		return baseDAODto.getgroup("select t.testcase_approval, count(*) from Testcase t group by t.testcase_approval");
		
	}
	
//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
