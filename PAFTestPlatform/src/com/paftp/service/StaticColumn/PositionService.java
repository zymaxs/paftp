package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.Position;

public interface PositionService {

	public void savePosition(Position position);

	public void updatePosition(Position position);

	public Position findPositionById(int id);
	
	public List<Position> findAllList();
	
	public Position findPositionByName(String name);
}
