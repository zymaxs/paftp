package com.paftp.service.NetworkResult;

import java.util.List;

import com.paftp.entity.NetworkResult;

public interface NetworkResultService {
	
	public void saveNetworkResult(NetworkResult networkResult);

	public void updateNetworkResult(NetworkResult networkResult);

	public void deleteNetworkResult(NetworkResult networkResult);
	
	public List<NetworkResult> findNetworkResultByStressResultId(int stressResultId);

}
