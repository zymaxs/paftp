package com.paftp.service.StressResult;

import com.paftp.entity.StressResult;

public interface StressResultService {

	public void saveStressResult(StressResult stressResult);

	public void updateStressResult(StressResult stressResult);

	public StressResult findStressResultById(int id);

	public StressResult findStressResultBySceneId(int sceneId);

	public StressResult findStressResultByStreategyType(int strategyTypeId);

	public void deleteStressResult(StressResult stressResult);

}
