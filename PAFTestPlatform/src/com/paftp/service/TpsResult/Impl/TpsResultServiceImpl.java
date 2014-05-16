package com.paftp.service.TpsResult.Impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.TpsResult;
import com.paftp.entity.User;
import com.paftp.service.TpsResult.TpsResultService;

public class TpsResultServiceImpl implements TpsResultService {

	@Resource
	private BaseDAO<TpsResult> baseDAO;

	@Override
	public void saveTpsResult(TpsResult tpsResult) {
		baseDAO.save(tpsResult);
	}

	@Override
	public void updateTpsResult(TpsResult tpsResult) {
		baseDAO.save(tpsResult);

	}

	@Override
	public void deleteTpsResult(TpsResult tpsResult) {
		baseDAO.delete(tpsResult);

	}

	@Override
	public List<TpsResult> findTpsResultByStressResultId(int stressResultId) {
		return baseDAO.find("from tpsresult t where t.stress_result_ind = ?",
				new Object[] { stressResultId });
	}

}
