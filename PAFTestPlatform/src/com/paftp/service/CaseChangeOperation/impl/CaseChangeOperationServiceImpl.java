package com.paftp.service.CaseChangeOperation.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.service.CaseChangeHistory.CaseChangeHistoryService;
import com.paftp.service.CaseChangeOperation.CaseChangeOperationService;


@Service("casechangeoperationService")
public class CaseChangeOperationServiceImpl implements CaseChangeOperationService {

	@Resource
	private BaseDAO<CaseChangeOperation> baseDAO;

	@Override
	public void saveCaseChangeOperation(CaseChangeOperation casechangeoperation) {
		baseDAO.save(casechangeoperation);
	}

	@Override
	public void updateCaseChangeOperation(CaseChangeOperation casechangeoperation) {
		baseDAO.update(casechangeoperation);
	}

	@Override
	public CaseChangeOperation findCaseChangeOperationById(int id) {
		return baseDAO.get(CaseChangeOperation.class, id);
	}

	

	@Override
	public void deleteCaseChangeOperation(CaseChangeOperation casechangeoperation) {
		baseDAO.delete(casechangeoperation);
	}

	@Override
	public List<CaseChangeOperation> findAllList() {
		return baseDAO.find(" from CaseChangeOperation u order by u.id");
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
