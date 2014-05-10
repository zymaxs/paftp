package com.paftp.service.CaseChangeHistory;

import java.util.List;

import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface CaseChangeHistoryService {

	public void saveCaseChangeHistory(CaseChangeHistory casechangehistory);

	public void updateCaseChangeHistory(CaseChangeHistory casechangehistory);

	public CaseChangeHistory findCaseChangeHistoryById(int id);

	//public Testcase findTestcaseByName(String name);

	public void deleteCaseChangeHistory(CaseChangeHistory casechangehistory);

	public List<CaseChangeHistory> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
