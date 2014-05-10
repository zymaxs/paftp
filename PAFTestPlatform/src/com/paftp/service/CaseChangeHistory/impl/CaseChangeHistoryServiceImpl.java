package com.paftp.service.CaseChangeHistory.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.service.CaseChangeHistory.CaseChangeHistoryService;


@Service("casechangehistoryService")
public class CaseChangeHistoryServiceImpl implements CaseChangeHistoryService {

	@Resource
	private BaseDAO<CaseChangeHistory> baseDAO;

	@Override
	public void saveCaseChangeHistory(CaseChangeHistory casechangehistory) {
		baseDAO.save(casechangehistory);
	}

	@Override
	public void updateCaseChangeHistory(CaseChangeHistory casechangehistory) {
		baseDAO.update(casechangehistory);
	}

	@Override
	public CaseChangeHistory findCaseChangeHistoryById(int id) {
		return baseDAO.get(CaseChangeHistory.class, id);
	}

	

	@Override
	public void deleteCaseChangeHistory(CaseChangeHistory casechangehistory) {
		baseDAO.delete(casechangehistory);
	}

	@Override
	public List<CaseChangeHistory> findAllList() {
		return baseDAO.find(" from CaseChangeHistory u order by u.id");
	}

//	@Override
//	public User findUserByNameAndPassword(String username, String password) {
//		return baseDAO.get(
//				" from User u where u.userName = ? and u.password = ? ",
//				new Object[] { username, password });
//	}

}
