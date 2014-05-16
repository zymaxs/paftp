package com.paftp.service.CpuResult;

import java.util.List;

import com.paftp.entity.CpuResult;

public interface CpuResultService {
	
	public void saveCpuResult(CpuResult cpuResult);
	
	public void updateCpuResult(CpuResult cpuResult);
	
	public List<CpuResult> findCpuResultByStressResultId( int stressResultId);
	
	public void deleteCpuResult(CpuResult cpuResult);

}
