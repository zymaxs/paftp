package com.paftp.service.AnalyseCommentHistory.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.AnalyseCommentHistoryDto;
import com.paftp.dto.ApplySutDto;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.ApplySut;
import com.paftp.entity.User;
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
		List<String> result  = baseStringDAO.getgroup("select newstatus from AnalyseCommentHistory a where testcase_result.id = ? order by a.createtime desc", new Object[] { id });
		return result;
	}
	
	@Override
	public List<AnalyseCommentHistory> findAllListByTime(Integer id) {
		// TODO Auto-generated method stub
		return baseDAO.getgroup("from AnalyseCommentHistory a where testcase_result.id = ? order by a.createtime desc", new Object[] { id });
	}

	@Override
	public List<AnalyseCommentHistoryDto> getAnalyseCommentHistoriesDto(List<AnalyseCommentHistory> analysecommenthistories){
		
		List<AnalyseCommentHistoryDto> analyseCommentHistoryDtoes = new ArrayList<AnalyseCommentHistoryDto>();
		
		for(int i=0; i<analysecommenthistories.size(); i++){
			
			AnalyseCommentHistoryDto analyseCommentHistoryDto = new AnalyseCommentHistoryDto();
			analyseCommentHistoryDto.setCreatetime(analysecommenthistories.get(i).getCreatetime());
			analyseCommentHistoryDto.setOldstatus(analysecommenthistories.get(i).getOldstatus());
			analyseCommentHistoryDto.setOldcomment(analysecommenthistories.get(i).getOldcomment());
			analyseCommentHistoryDto.setNewcomment(analysecommenthistories.get(i).getNewcomment());
			analyseCommentHistoryDto.setNewstatus(analysecommenthistories.get(i).getNewstatus());
			User user = new User();
			user.setAlias(analysecommenthistories.get(i).getUpdator().getAlias());
			user.setId(analysecommenthistories.get(i).getUpdator().getId());
			user.setDisplayName(analysecommenthistories.get(i).getUpdator().getDisplayName());
			analyseCommentHistoryDto.setUpdator(user);
			
			analyseCommentHistoryDtoes.add(analyseCommentHistoryDto);
			
		}
		
		return analyseCommentHistoryDtoes;
		
	}
}
