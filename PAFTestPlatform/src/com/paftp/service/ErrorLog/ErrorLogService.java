package com.paftp.service.ErrorLog;

import java.util.List;

import com.paftp.entity.ErrorLog;

public interface ErrorLogService {
	public void saveErrorLogService(ErrorLog errorLog);

	public void updateErrorLogService(ErrorLog errorLog);

	public List<ErrorLog> findErrorLogByStressResultId(int stressResultId);

	public void deleteErrorLogService(ErrorLog errorLog);

}
