package com.paftp.service.StressResult.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.StressResult;
import com.paftp.service.StressResult.StressResultService;

@Service("StressResultService")
public class StressResultServiceImpl implements StressResultService {

	@Resource
	private BaseDAO<StressResult> baseDAO;

	@Override
	public void saveStressResult(StressResult stressResult) {
		baseDAO.save(stressResult);

	}

	@Override
	public void updateStressResult(StressResult stressResult) {
		baseDAO.save(stressResult);

	}

	@Override
	public StressResult findStressResultById(int id) {
		return baseDAO.get(StressResult.class, id);
	}

	@Override
	public StressResult findStressResultBySceneId(int sceneId) {
		return baseDAO.get("from stressresult s where s.scene_id = ?",
				new Object[] { sceneId });
	}

	@Override
	public StressResult findStressResultByStreategyType(int strategyTypeId) {
		return baseDAO.get("from stresssult s where s.strategytype_id =?",
				new Object[] { strategyTypeId });
	}

	@Override
	public void deleteStressResult(StressResult stressResult) {
		baseDAO.delete(stressResult);;
	}
	
	
	public List<User> 

}
