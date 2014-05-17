package com.paftp.service.DiskResult;

import java.util.List;

import com.paftp.entity.DiskResult;

public interface DiskResultService {

	public void saveDiskResult(DiskResult diskResult);

	public void updateDiskResult(DiskResult diskResult);

	public void deleteDiskResult(DiskResult diskResult);
	
	public List<DiskResult> findDiskResultByStressResultId( int stressResultId);

}
