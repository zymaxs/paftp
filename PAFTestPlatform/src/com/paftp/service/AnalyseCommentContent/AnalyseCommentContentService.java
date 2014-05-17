package com.paftp.service.AnalyseCommentContent;

import java.util.List;

import com.paftp.entity.AnalyseCommentContent;

public interface AnalyseCommentContentService {

	public void saveAnalyseCommentContent(AnalyseCommentContent analyseCommentContent);

	public void updateAnalyseCommentContent(AnalyseCommentContent analyseCommentContent);

	public AnalyseCommentContent findAnalyseCommentContentById(int id);

	public void deleteAnalyseCommentContent(AnalyseCommentContent analyseCommentContent);

	public List<AnalyseCommentContent> findAllList();
	
}
