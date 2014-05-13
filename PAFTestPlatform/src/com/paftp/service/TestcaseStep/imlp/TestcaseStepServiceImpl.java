package com.paftp.service.TestcaseStep.imlp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TestcaseStep;
import com.paftp.service.TestcaseStep.TestcaseStepService;


@Service("casecontentService")
public class TestcaseStepServiceImpl implements TestcaseStepService {

	@Resource
	private BaseDAO<TestcaseStep> baseDAO;

	@Override
	public void saveTestcaseStep(TestcaseStep testcasestep) {
		baseDAO.save(testcasestep);
	}

	@Override
	public void updateTestcaseStep(TestcaseStep testcasestep) {
		baseDAO.update(testcasestep);
	}

	@Override
	public TestcaseStep findTestcaseStepById(int id) {
		return baseDAO.get(TestcaseStep.class, id);
	}

	

	@Override
	public void deleteTestcaseStep(TestcaseStep testcasestep) {
		baseDAO.delete(testcasestep);
	}

	@Override
	public List<TestcaseStep> findAllList() {
		return baseDAO.find(" from testcasestep u order by u.id");
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
