package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.ApplySutStatus;
import com.paftp.entity.Department;
import com.paftp.service.StaticColumn.ApplySutStatusService;

@Service("applySutStatusService")
public class ApplySutStatusImpl implements ApplySutStatusService {

	@Resource
	private BaseDAO<ApplySutStatus> baseDAO;
	
	@Override
	public void saveApplySutStatus(ApplySutStatus applySutStatus) {
		// TODO Auto-generated method stub
		baseDAO.save(applySutStatus);
	}

	@Override
	public void updateApplySutStatus(ApplySutStatus applySutStatus) {
		// TODO Auto-generated method stub
		baseDAO.update(applySutStatus);
	}

	@Override
	public ApplySutStatus findApplySutStatusById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(ApplySutStatus.class, id);
	}

	@Override
	public List<ApplySutStatus> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from ApplySutStatus");
	}

	@Override
	public ApplySutStatus findApplySutStatusByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from ApplySutStatus u where u.name = ?",
				new Object[] { name });
	}
	

}
