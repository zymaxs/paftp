package com.paftp.service.Testpass.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.TestpassDto;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testpass;
import com.paftp.entity.Version;
import com.paftp.service.Testpass.TestpassService;

@Service("testpassService")
public class TestpassServiceImpl implements TestpassService{

	@Resource
	private BaseDAO<Testpass> baseDAO;
	
	@Override
	public void saveTestpass(Testpass testpass) {
		// TODO Auto-generated method stub
		baseDAO.save(testpass);
	}

	@Override
	public void updateTestpass(Testpass testpass) {
		// TODO Auto-generated method stub
		baseDAO.update(testpass);
	}

	@Override
	public Testpass findTestpassById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(Testpass.class, id);
	}

	@Override
	public Testpass findTestpassByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from testpass u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteTestpass(Testpass testpass) {
		// TODO Auto-generated method stub
		baseDAO.delete(testpass);
	}

	@Override
	public List<Testpass> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from testpass u order by u.id");
	}

	@Override
	public TestpassDto getTestpassDto(Testpass testpass, Integer passcount, Integer failcount, Integer total, Float percentage) {
		// TODO Auto-generated method stub
		TestpassDto testpassdto = new TestpassDto();
		
		testpassdto.setId(testpass.getId());
		testpassdto.setTestset(testpass.getTestset());
		Version version = new Version();
		version.setVersionNum(testpass.getVersion().getVersionNum());
		testpassdto.setCreatetime(testpass.getCreatetime());
		testpassdto.setVersion(version);
		testpassdto.setTag(testpass.getTag());
		testpassdto.setPasscount(passcount);
		testpassdto.setFailcount(failcount);
		testpassdto.setTotal(total);
		testpassdto.setPercentage(percentage);
		testpassdto.setEnv(testpass.getEnv());
		
		return testpassdto;
	}

	@Override
	public List<Testpass> findAllTestpassByMultiConditions(
			HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		List<Testpass> testpasses = baseDAO.findbyconditionsfortestpasses(conditions);
		return testpasses;
	}

}
