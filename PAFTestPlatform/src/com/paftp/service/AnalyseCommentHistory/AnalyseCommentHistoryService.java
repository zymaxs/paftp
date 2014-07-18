package com.paftp.service.AnalyseCommentHistory;

import java.util.List;

import com.paftp.entity.AnalyseCommentHistory;

public interface AnalyseCommentHistoryService {
	
	public void saveAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public void updateAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public AnalyseCommentHistory findAnalyseCommentHistoryById(int id);

	public void deleteAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public List<AnalyseCommentHistory> findAllList();

	List<String> findAllStatues(Integer id);
	
	List<AnalyseCommentHistory> findAllListByTime(Integer id);
}
