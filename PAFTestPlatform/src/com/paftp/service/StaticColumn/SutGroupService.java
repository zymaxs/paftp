package com.paftp.service.StaticColumn;

import java.util.List;

import com.paftp.entity.SutGroup;

public interface SutGroupService {

	public void saveSutGroup(SutGroup sutGroup);

	public void updateSutGroup(SutGroup sutGroup);

	public SutGroup findSutGroupById(int id);

	public void deleteSutGroup(SutGroup sutGroup);

	public List<SutGroup> findAllList();

	public SutGroup findSutGroupByName(String groupname);
}
