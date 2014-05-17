package com.paftp.service.ResponseTime;

import java.util.List;

import com.paftp.entity.ResponseTimeResult;

public interface ResponseTimeService {

	public void saveResponseTime(ResponseTimeResult responseTimeResult);

	public void updateResponseTime(ResponseTimeResult responseTimeResult);
	
	public List<ResponseTimeResult> findResponseTimeResultByStressResultId(int stressResultId);

	public void deleteResponseTime(ResponseTimeResult responseTimeResult);

}
