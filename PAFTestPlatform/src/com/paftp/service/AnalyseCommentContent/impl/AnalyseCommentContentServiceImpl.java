package com.paftp.service.AnalyseCommentContent.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.AnalyseCommentContent;
import com.paftp.service.AnalyseCommentContent.AnalyseCommentContentService;

@Service("analysecommentcontentService")
public class AnalyseCommentContentServiceImpl implements AnalyseCommentContentService {


	@Resource
	private BaseDAO<AnalyseCommentContent> baseDAO;
	
	@Override
	public void saveAnalyseCommentContent(
			AnalyseCommentContent analyseCommentContent) {
		// TODO Auto-generated method stub
		baseDAO.save(analyseCommentContent);
	}

	@Override
	public void updateAnalyseCommentContent(
			AnalyseCommentContent analyseCommentContent) {
		// TODO Auto-generated method stub
		baseDAO.update(analyseCommentContent);
	}

	@Override
	public AnalyseCommentContent findAnalyseCommentContentById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(AnalyseCommentContent.class, id);
	}

	@Override
	public void deleteAnalyseCommentContent(
			AnalyseCommentContent analyseCommentContent) {
		// TODO Auto-generated method stub
		baseDAO.delete(analyseCommentContent);
	}

	@Override
	public List<AnalyseCommentContent> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from analysecommentcontent u order by u.id");
	}

}
