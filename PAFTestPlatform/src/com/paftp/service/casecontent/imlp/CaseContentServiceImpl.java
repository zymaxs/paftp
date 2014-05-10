package com.paftp.service.casecontent.imlp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.CaseContent;
import com.paftp.service.casecontent.CaseContentService;


@Service("casecontentService")
public class CaseContentServiceImpl implements CaseContentService {

	@Resource
	private BaseDAO<CaseContent> baseDAO;

	@Override
	public void saveCaseContent(CaseContent casecontent) {
		baseDAO.save(casecontent);
	}

	@Override
	public void updateCaseContent(CaseContent casecontent) {
		baseDAO.update(casecontent);
	}

	@Override
	public CaseContent findCaseContentById(int id) {
		return baseDAO.get(CaseContent.class, id);
	}

	

	@Override
	public void deleteCaseContent(CaseContent casecontent) {
		baseDAO.delete(casecontent);
	}

	@Override
	public List<CaseContent> findAllList() {
		return baseDAO.find(" from CaseContent u order by u.id");
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
