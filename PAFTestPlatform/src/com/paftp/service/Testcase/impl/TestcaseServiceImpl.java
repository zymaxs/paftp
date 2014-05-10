package com.paftp.service.Testcase.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.user.UserService;

@Service("testcaseService")
public class TestcaseServiceImpl implements TestcaseService {

	@Resource
	private BaseDAO<Testcase> baseDAO;

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
		return baseDAO.get(" from Testcase u where u.name = ?",
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

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
