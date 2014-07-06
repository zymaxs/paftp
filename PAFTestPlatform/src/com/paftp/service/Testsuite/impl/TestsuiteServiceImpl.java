package com.paftp.service.Testsuite.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.ApplySutDto;
import com.paftp.dto.TestcaseDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.TestcaseProject;
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

public TestcaseDto getTestcaseDto(Testcase testcase){
	
	TestcaseDto testcasedto = new TestcaseDto();
	testcasedto.setCaseName(testcase.getCaseName());
	testcasedto.setPriority(testcase.getPriority());
	testcasedto.setCasesteps(testcase.getCasesteps());
	testcasedto.setCasetype(testcase.getCasetype());
	testcasedto.setCreateTime(testcase.getCreateTime());
	testcasedto.setDescription(testcase.getDescription());
	testcasedto.setId(testcase.getId());
	testcasedto.setStatus(testcase.getStatus());
	testcasedto.setCreateTime(testcase.getCreateTime());
	testcasedto.setTestcase_approval(testcase.getTestcase_approval());
	testcasedto.setApproval_comments(testcase.getApproval_comments());
	
	TestcaseProject testcaseproject = new TestcaseProject();
	if(testcase.getTestcaseproject() != null){
		testcaseproject.setName(testcase.getTestcaseproject().getName());
		testcasedto.setTestcaseproject(testcaseproject);
	}
	User user = new User();
	if(testcase.getCreator()!=null){
		user.setId(testcase.getCreator().getId());
		user.setAlias(testcase.getCreator().getAlias());
		user.setDisplayName(testcase.getCreator().getDisplayName());
		testcasedto.setCreator(user);
	}
	
	List<CaseChangeHistory> casechangehistories = new ArrayList<CaseChangeHistory>();
	List<CaseChangeHistory> casechangehistories_source = testcase.getCaseChangeHistorys();
	for (int i=0; i< casechangehistories_source.size(); i++){
		List<CaseChangeOperation> casechangeoperations_source = casechangehistories_source.get(i).getCaseChangeOperations();
		List<CaseChangeOperation> casechangeoperations = new ArrayList<CaseChangeOperation>();
		for (int j=0; j < casechangeoperations_source.size(); j++){
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setId(casechangeoperations_source.get(j).getId());
			casechangeoperation.setField(casechangeoperations_source.get(j).getField());
			casechangeoperation.setNewValue(casechangeoperations_source.get(j).getNewValue());
			casechangeoperation.setOldValue(casechangeoperations_source.get(j).getOldValue());
			casechangeoperations.add(casechangeoperation);
		}
		CaseChangeHistory casechangehistory = new CaseChangeHistory();
		casechangehistory.setCaseChangeOperations(casechangeoperations);
		casechangehistory.setId(casechangehistories_source.get(i).getId());
		casechangehistory.setUpdate_time(casechangehistories_source.get(i).getUpdate_time());
		User updator = new User();
		updator.setId(casechangehistories_source.get(i).getUpdator().getId());
		updator.setAlias(casechangehistories_source.get(i).getUpdator().getAlias());
		updator.setDisplayName(casechangehistories_source.get(i).getUpdator().getDisplayName());
		casechangehistory.setUpdator(updator);
		casechangehistories.add(casechangehistory);
	}
	testcasedto.setCaseChangeHistorys(casechangehistories);
	
	return testcasedto;
}

}
