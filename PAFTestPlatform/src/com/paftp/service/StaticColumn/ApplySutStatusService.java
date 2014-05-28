package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.ApplySutStatus;

public interface ApplySutStatusService {

	public void saveApplySutStatus(ApplySutStatus applySutStatus);

	public void updateApplySutStatus(ApplySutStatus applySutStatus);

	public ApplySutStatus findApplySutStatusById(int id);

	public List<ApplySutStatus> findAllList();

	public ApplySutStatus findApplySutStatusByName(String groupname);
}
