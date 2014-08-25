package com.paftp.service.AnalyseCommentHistory;

import java.util.List;

import com.paftp.dto.AnalyseCommentHistoryDto;
import com.paftp.entity.AnalyseCommentHistory;

public interface AnalyseCommentHistoryService {
	
	public void saveAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public void updateAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public AnalyseCommentHistory findAnalyseCommentHistoryById(int id);

	public void deleteAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory);

	public List<AnalyseCommentHistory> findAllList();

	public List<String> findAllStatues(Integer id);
	
	public List<AnalyseCommentHistory> findAllListByTime(Integer id);

	public List<AnalyseCommentHistoryDto> getAnalyseCommentHistoriesDto(List<AnalyseCommentHistory> analysecommenthistories);

	public AnalyseCommentHistory findRecentOne(Integer testcaseresult_id);
}
