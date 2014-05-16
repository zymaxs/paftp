package com.paftp.service.TpsResult;

import java.util.List;

import com.paftp.entity.TpsResult;

public interface TpsResultService {

	public void saveTpsResult(TpsResult tpsResult);

	public void updateTpsResult(TpsResult tpsResult);

	public void deleteTpsResult(TpsResult tpsResult);

	public List<TpsResult> findTpsResultByStressResultId();

}
