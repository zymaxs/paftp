package com.paftp.service.Testsuite;

import java.util.List;

import com.paftp.entity.Testsuite;
import com.paftp.entity.User;

public interface TestsuiteService {

	public void saveTestsuite(Testsuite testsuite);

	public void updateTestsuite(Testsuite testsuite);

	public Testsuite findTestsuiteById(int id);

	public Testsuite findTestsuiteByName(String name);

	public void deleteTestsuite(Testsuite testsuite);

	public List<Testsuite> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
