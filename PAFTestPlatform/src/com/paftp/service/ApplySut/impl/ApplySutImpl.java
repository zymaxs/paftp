package com.paftp.service.ApplySut.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.ApplySut;
import com.paftp.service.ApplySut.ApplySutService;

@Service("ApplySutService")
public class ApplySutImpl implements ApplySutService{

	@Resource
	private BaseDAO<ApplySut> baseDAO;
	
	@Override
	public void saveApplySut(ApplySut ApplySut) {
		// TODO Auto-generated method stub
		baseDAO.save(ApplySut);
	}

	@Override
	public void updateApplySut(ApplySut ApplySut) {
		// TODO Auto-generated method stub
		baseDAO.update(ApplySut);
	}

	@Override
	public ApplySut findApplySutById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(ApplySut.class, id);
	}

	@Override
	public void deleteApplySut(ApplySut ApplySut) {
		// TODO Auto-generated method stub
		baseDAO.delete(ApplySut);
	}

	@Override
	public List<ApplySut> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from ApplySut u");
	}

	@Override
	public ApplySut findApplySutByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from ApplySut u where u.name = ?",
				new Object[] { name });
	}

	@Override
	public ApplySut findApplySutByUser(Integer userId) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from ApplySut u where u.user_id = ? or u.approver_id = ?",
				new Object[] { userId });
	}

	@Override
	public List<ApplySut> findAllOrderByColumn(String column ,Integer page, Integer row) {
		// TODO Auto-generated method stub
		return baseDAO.find(" from ApplySut u order by ?", new Object[] {column}, page, row);
	}

	@Override
	public List<ApplySut> findAllOrderByMultiConditions(
			HashMap<String, Object> conditions, Integer page, Integer row) {
		// TODO Auto-generated method stub
		
		return baseDAO.findbyconditions(conditions, page, row);
	}

	@Override
	public Long findPages() {
		// TODO Auto-generated method stub
		return baseDAO.count(" from ApplySut u");
	}


}
