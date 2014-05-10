package com.paftp.service.CaseChangeOperation;

import java.util.List;

import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface CaseChangeOperationService {

	public void saveCaseChangeOperation(CaseChangeOperation casechangeoperation);

	public void updateCaseChangeOperation(CaseChangeOperation casechangeoperation);

	public CaseChangeOperation findCaseChangeOperationById(int id);

	//public Testcase findTestcaseByName(String name);

	public void deleteCaseChangeOperation(CaseChangeOperation casechangeoperation);

	public List<CaseChangeOperation> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
