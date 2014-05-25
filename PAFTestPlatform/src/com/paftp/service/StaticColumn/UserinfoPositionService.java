package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.UserinfoPosition;

public interface UserinfoPositionService {

	public void saveUserinfoPosition(UserinfoPosition userinfoPosition);

	public void updateUserinfoPosition(UserinfoPosition userinfoPosition);

	public UserinfoPosition findUserinfoPositionById(int id);
	
	public List<UserinfoPosition> findAllList();
}
