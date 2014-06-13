package com.paftp.service.Testsuite.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.user.UserService;

@Service("testsuiteService")
public class TestsuiteServiceImpl implements TestsuiteService {

	@Resource
	private BaseDAO<Testsuite> baseDAO;

	@Override
	public void saveTestsuite(Testsuite testsuite) {
		baseDAO.save(testsuite);
	}

	@Override
	public void updateTestsuite(Testsuite testsuite) {
		baseDAO.update(testsuite);
	}

	@Override
	public Testsuite findTestsuiteById(int id) {
		return baseDAO.get(Testsuite.class, id);
	}

	@Override
	public void deleteTestsuite(Testsuite testsuite) {
		baseDAO.delete(testsuite);
	}

	@Override
	public List<Testsuite> findAllList() {
		return baseDAO.find(" from Testsuite u order by u.id");
	}

	@Override
	public Testsuite findTestsuiteByNameAndSutid(String name, Integer id) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Testsuite u where u.name = ? and sut.id = ?",
				new Object[] { name, id });
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
