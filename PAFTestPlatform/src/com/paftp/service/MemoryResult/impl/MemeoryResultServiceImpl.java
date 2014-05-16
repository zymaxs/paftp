package com.paftp.service.MemoryResult.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.MemoryResult;
import com.paftp.service.MemoryResult.MemoryResultService;

public class MemeoryResultServiceImpl implements MemoryResultService {

	@Resource
	private BaseDAO<MemoryResult> baseDAO;

	@Override
	public void saveMemoryResult(MemoryResult memoryResult) {
		// TODO Auto-generated method stub
		baseDAO.save(memoryResult);

	}

	@Override
	public void updateMemoryResult(MemoryResult memoryResult) {
		// TODO Auto-generated method stub
		baseDAO.save(memoryResult);

	}

	@Override
	public void deleteMemoryResult(MemoryResult memoryResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(memoryResult);

	}

	@Override
	public List<MemoryResult> findMemoryResultByStressResultId(
			int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find(
				"from memeoryresult m where m.stress_result_ind = ?",
				new Object[] { stressResultId });
	}

}
