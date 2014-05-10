package com.paftp.service.casecontent;

import java.util.List;

import com.paftp.entity.CaseContent;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface CaseContentService {

	public void saveCaseContent(CaseContent casecontent);

	public void updateCaseContent(CaseContent casecontent);

	public CaseContent findCaseContentById(int id);

	//public CaseContent findCaseContentByName(String name);

	public void deleteCaseContent(CaseContent casecontent);

	public List<CaseContent> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
