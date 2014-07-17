package com.paftp.service.AnalyseCommentHistory.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.service.AnalyseCommentHistory.AnalyseCommentHistoryService;

@Service("analysecommenthistoryService")
public class AnalyseCommentHistoryServiceImpl implements AnalyseCommentHistoryService{


	@Resource
	private BaseDAO<AnalyseCommentHistory> baseDAO;
	@Resource
	private BaseDAO<String> baseStringDAO;
	
	@Override
	public void saveAnalyseCommentHistory(
			AnalyseCommentHistory analyseCommentHistory) {
		// TODO Auto-generated method stub
		baseDAO.save(analyseCommentHistory);
	}

	@Override
	public void updateAnalyseCommentHistory(
			AnalyseCommentHistory analyseCommentHistory) {
		// TODO Auto-generated method stub
		baseDAO.update(analyseCommentHistory);
	}

	@Override
	public AnalyseCommentHistory findAnalyseCommentHistoryById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(AnalyseCommentHistory.class, id);
	}

	@Override
	public void deleteAnalyseCommentHistory(
			AnalyseCommentHistory analyseCommentHistory) {
		// TODO Auto-generated method stub
		baseDAO.delete(analyseCommentHistory);
	}

	@Override
	public List<AnalyseCommentHistory> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from analysecommenthistory u order by u.id");
	}
	
	@Override
	public List<String> findAllStatues(Integer id) {
		// TODO Auto-generated method stub
		return baseStringDAO.getgroup("select status from AnalyseCommentHistory a where testcaseresult.id = ? order by a.createtime desc", new Object[] { id });
	}

}
