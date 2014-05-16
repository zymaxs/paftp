package com.paftp.service.NetworkResult.impl;

import java.util.List;

import javax.annotation.Resource;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.NetworkResult;
import com.paftp.service.NetworkResult.NetworkResultService;

public class NetworkResultImpl implements NetworkResultService {

	@Resource
	private BaseDAO<NetworkResult> baseDAO;

	@Override
	public void saveNetworkResult(NetworkResult networkResult) {
		// TODO Auto-generated method stub
		baseDAO.save(networkResult);

	}

	@Override
	public void updateNetworkResult(NetworkResult networkResult) {
		// TODO Auto-generated method stub
		baseDAO.save(networkResult);
	}

	@Override
	public void deleteNetworkResult(NetworkResult networkResult) {
		// TODO Auto-generated method stub
		baseDAO.delete(networkResult);

	}

	@Override
	public List<NetworkResult> findNetworkResultByStressResultId(
			int stressResultId) {
		// TODO Auto-generated method stub
		return baseDAO.find(
				"from networkresult n where n.stress_result_ind = ?",
				new Object[] { stressResultId });
	}

}
