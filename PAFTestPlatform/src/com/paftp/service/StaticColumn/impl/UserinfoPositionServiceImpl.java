package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.UserinfoPosition;
import com.paftp.service.StaticColumn.UserinfoPositionService;

@Service("userinfoPositionService")
public class UserinfoPositionServiceImpl implements UserinfoPositionService{

	@Resource
	private BaseDAO<UserinfoPosition> baseDAO;
	
	@Override
	public void saveUserinfoPosition(UserinfoPosition userinfoPosition) {
		// TODO Auto-generated method stub
		baseDAO.save(userinfoPosition);
	}

	@Override
	public void updateUserinfoPosition(UserinfoPosition userinfoPosition) {
		// TODO Auto-generated method stub
		baseDAO.update(userinfoPosition);
	}

	@Override
	public UserinfoPosition findUserinfoPositionById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(UserinfoPosition.class, id);
	}

	@Override
	public List<UserinfoPosition> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from UserinfoPosition up");
	}
}
