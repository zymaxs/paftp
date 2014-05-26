package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Position;
import com.paftp.service.StaticColumn.PositionService;

@Service("positionService")
public class PositionServiceImpl implements PositionService{

	@Resource
	private BaseDAO<Position> baseDAO;
	
	@Override
	public void savePosition(Position position) {
		// TODO Auto-generated method stub
		baseDAO.save(position);
	}

	@Override
	public void updatePosition(Position position) {
		// TODO Auto-generated method stub
		baseDAO.update(position);
	}

	@Override
	public Position findPositionById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(Position.class, id);
	}

	@Override
	public List<Position> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from Position up");
	}

	@Override
	public Position findPositionByName(String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Position p where p.name = ?",
				new Object[] { name });
	}
}
