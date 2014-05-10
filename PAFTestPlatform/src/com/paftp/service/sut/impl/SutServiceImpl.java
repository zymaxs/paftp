package com.paftp.service.sut.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;

@Service("sutService")
public class SutServiceImpl implements SutService {

	@Resource
	private BaseDAO<Sut> baseDAO;

	@Override
	public void saveSut(Sut testcase) {
		baseDAO.save(testcase);
	}

	@Override
	public void updateSut(Sut testcase) {
		baseDAO.update(testcase);
	}

	@Override
	public Sut findSutById(int id) {
		return baseDAO.get(Sut.class, id);
	}

	@Override
	public Sut findSutByName(String name) {
		return baseDAO.get(" from Sut u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteSut(Sut testcase) {
		baseDAO.delete(testcase);
	}

	@Override
	public List<Sut> findAllList() {
		return baseDAO.find(" from Sut u order by u.id");
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
