package com.paftp.service.StressResult;

import java.util.List;

import com.paftp.entity.StressResult;

public interface StressResultService {

	public void saveStressResult(StressResult stressResult);

	public void updateStressResult(StressResult stressResult);

	public StressResult findStressResultById(int id);

	public List<StressResult> findStressResultBySceneId(int sceneId);

	public List<StressResult> findStressResultByStreategyType(int strategyTypeId);

	public void deleteStressResult(StressResult stressResult);

}
