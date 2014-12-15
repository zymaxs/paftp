package com.paftp.service.Count.impl;

import javax.annotation.Resource;



import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Count;
import com.paftp.service.Count.CountService;

@Service("countService")
public class CountImpl implements CountService{

	@Resource
	private BaseDAO<Count> baseDAO;
	
	@Override
	public void addCount(int id) {
		// TODO Auto-generated method stub
		Count c = baseDAO.get(" from Count c where c.id = ?",
				new Object[] { id });
		Long n = c.getCount();
		c.setCount(n+1);
		baseDAO.update(c);
	}

	
}
