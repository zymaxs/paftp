package com.paftp.service.Testsuite.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.ApplySutDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.Version;
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

	@Override
	public List<Testsuite> findAllSuiteByMultiConditions(
			HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		List<Testsuite> testsuites = baseDAO.findbyconditionsfortestsuites(conditions);
		return testsuites;
	}

public TestsuiteDto getTestsuiteDto(Testsuite testsuite){
		
	TestsuiteDto testsuitedto = new TestsuiteDto();
	testsuitedto.setId(testsuite.getId());
	testsuitedto.setName(testsuite.getName());
	testsuitedto.setDescription(testsuite.getDescription());
	testsuitedto.setStatus(testsuite.getStatus());
	Version testsuitedto_version = new Version();
	testsuitedto_version.setVersionNum(testsuite.getVersion().getVersionNum());
	Sut testsuitedto_sut = new Sut();
	testsuitedto_sut.setName(testsuite.getSut().getName());
	testsuitedto.setVersion(testsuitedto_version);
	testsuitedto.setSut(testsuitedto_sut);
	
	return testsuitedto;
}

}
