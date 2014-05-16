package com.paftp.service.CpuResult.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.CpuResult;
import com.paftp.entity.TpsResult;
import com.paftp.service.CpuResult.CpuResultService;

public class CpuResultServiceImpl implements CpuResultService {

	@Resource
	private BaseDAO<CpuResult> baseDAO;

	@Override
	public void saveCpuResult(CpuResult cpuResult) {
		// TODO Auto-generated method stub
		baseDAO.save(cpuResult);

	}

	@Override
	public void updateCpuResult(CpuResult cpuResult) {
		// TODO Auto-generated method stub
		baseDAO.save(cpuResult);

	}

	@Override
	public List<CpuResult> findCpuResultByStressResultId(int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find("from cpuresult c where c.stress_result_ind = ?",
				new Object[] { stressResultId });
	}

	@Override
	public void deleteCpuResult(CpuResult cpuResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(cpuResult);

	}

}
