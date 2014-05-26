package com.paftp.service.StaticColumn.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.SutGroup;
import com.paftp.service.StaticColumn.SutGroupService;

@Service("sutgroupService")
public class SutGroupServiceImpl implements SutGroupService{

	@Resource
	private BaseDAO<SutGroup> baseDAO;
	
	@Override
	public void saveSutGroup(SutGroup sutGroup) {
		// TODO Auto-generated method stub
		baseDAO.save(sutGroup);
	}

	@Override
	public void updateSutGroup(SutGroup sutGroup) {
		// TODO Auto-generated method stub
		baseDAO.update(sutGroup);
	}

	@Override
	public SutGroup findSutGroupById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(SutGroup.class, id);
	}

	@Override
	public void deleteSutGroup(SutGroup sutGroup) {
		// TODO Auto-generated method stub
		baseDAO.delete(sutGroup);
	}

	@Override
	public List<SutGroup> findAllList() {
		// TODO Auto-generated method stub
		return baseDAO.find(" from SutGroup sg order by sg.id");
	}

	@Override
	public SutGroup findSutGroupByName(String groupname) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from SutGroup sg where sg.name = ?",
				new Object[] { groupname });
	}

}
