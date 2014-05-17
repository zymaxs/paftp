package com.paftp.service.ResponseTime.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.ErrorLog;
import com.paftp.entity.ResponseTimeResult;
import com.paftp.service.ResponseTime.ResponseTimeService;

public class ResponseTimeResultServiceImpl implements ResponseTimeService {

	@Resource
	private BaseDAO<ResponseTimeResult> baseDAO;

	@Override
	public void saveResponseTime(ResponseTimeResult responseTimeResult) {
		// TODO Auto-generated method stub
		baseDAO.save(responseTimeResult);
	}

	@Override
	public void updateResponseTime(ResponseTimeResult responseTimeResult) {
		// TODO Auto-generated method stub
		baseDAO.save(responseTimeResult);

	}

	@Override
	public List<ResponseTimeResult> findResponseTimeResultByStressResultId(
			int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find(
				"from responsetimeresult r where r.stress_result_id = ? ",
				new Object[] { stressResultId });
	}

	@Override
	public void deleteResponseTime(ResponseTimeResult responseTimeResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(responseTimeResult);

	}

}
