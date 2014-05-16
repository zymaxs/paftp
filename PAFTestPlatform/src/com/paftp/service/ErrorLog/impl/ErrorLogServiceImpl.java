package com.paftp.service.ErrorLog.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.ErrorLog;
import com.paftp.entity.TpsResult;
import com.paftp.service.ErrorLog.ErrorLogService;

public class ErrorLogServiceImpl implements ErrorLogService {

	@Resource
	private BaseDAO<ErrorLog> baseDAO;

	@Override
	public void saveErrorLogService(ErrorLog errorLog) {
		baseDAO.save(errorLog);
	}

	@Override
	public void updateErrorLogService(ErrorLog errorLog) {
		// TODO Auto-generated method stub
		baseDAO.save(errorLog);
	}

	@Override
	public List<ErrorLog> findErrorLogByStressResultId(int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find("from errorlog e where e.stress_result_id = ?",
				new Object[] { stressResultId });
	}

	@Override
	public void deleteErrorLogService(ErrorLog errorLog) {
		// TODO Auto-generated method stub
		baseDAO.delete(errorLog);

	}

}
