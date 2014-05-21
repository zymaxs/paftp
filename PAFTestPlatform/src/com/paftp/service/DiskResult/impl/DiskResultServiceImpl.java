package com.paftp.service.DiskResult.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.DiskResult;
import com.paftp.service.DiskResult.DiskResultService;

public class DiskResultServiceImpl implements DiskResultService {

	@Resource
	private BaseDAO<DiskResult> baseDAO;

	@Override
	public void saveDiskResult(DiskResult diskResult) {
		// TODO Auto-generated method stub
		baseDAO.save(diskResult);

	}

	@Override
	public void updateDiskResult(DiskResult diskResult) {
		// TODO Auto-generated method stub
		baseDAO.save(diskResult);

	}

	@Override
	public void deleteDiskResult(DiskResult diskResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(diskResult);

	}

	@Override
	public List<DiskResult> findDiskResultByStressResultId(int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find("from diskreslut d where d.stress_result_ind = ?",
				new Object[] { stressResultId });
	}

}
