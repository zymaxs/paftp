package com.paftp.service.MemoryResult;

import java.util.List;

import com.paftp.entity.MemoryResult;

public interface MemoryResultService {
	public void saveMemoryResult(MemoryResult memoryResult);

	public void updateMemoryResult(MemoryResult memoryResult);

	public void deleteMemoryResult(MemoryResult memoryResult);
	
	public List<MemoryResult> findMemoryResultByStressResultId( int stressResultId);

}
