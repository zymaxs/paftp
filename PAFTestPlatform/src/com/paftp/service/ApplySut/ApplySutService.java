package com.paftp.service.ApplySut;

import java.util.List;

import com.paftp.entity.ApplySut;

public interface ApplySutService {

	public void saveApplySut(ApplySut applySut);

	public void updateApplySut(ApplySut applySut);

	public ApplySut findApplySutById(int id);
	
	public ApplySut findApplySutByName(String name);

	public ApplySut findApplySutByUser(Integer userId);
	
	public void deleteApplySut(ApplySut applySut);

	public List<ApplySut> findAllList();

}