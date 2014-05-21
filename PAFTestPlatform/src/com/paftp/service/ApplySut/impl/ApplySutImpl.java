package com.paftp.service.ApplySut.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.ApplySut;
import com.paftp.entity.User;
import com.paftp.service.ApplySut.ApplySutService;

@Service("applySutService")
public class ApplySutImpl implements ApplySutService{

	@Resource
	private BaseDAO<ApplySut> baseDAO;
	
	@Override
	public void saveApplySut(ApplySut applySut) {
		// TODO Auto-generated method stub
		baseDAO.save(applySut);
	}

	@Override
	public void updateApplySut(ApplySut applySut) {
		// TODO Auto-generated method stub
		baseDAO.update(applySut);
	}

	@Override
	public ApplySut findApplySutById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(ApplySut.class, id);
	}

	@Override
	public void deleteApplySut(ApplySut applySut) {
		// TODO Auto-generated method stub
		baseDAO.delete(applySut);
	}

	@Override
	public List<ApplySut> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from applysut u order by u.applytime");
	}

	@Override
	public ApplySut findApplySutByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from applysut u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public ApplySut findApplySutByUser(Integer userId) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from applysut u where u.user_id = ? or u.approver_id = ?",
				new Object[] { userId });
	}


}
