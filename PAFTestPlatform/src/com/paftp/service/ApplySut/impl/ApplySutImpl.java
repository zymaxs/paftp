package com.paftp.service.ApplySut.impl;

import java.util.ArrayList;
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
import com.paftp.dto.ApplySutDto;
import com.paftp.dto.ApplySutStatusDto;
import com.paftp.entity.ApplySut;
import com.paftp.service.ApplySut.ApplySutService;

@Service("applySutService")
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
	public List<ApplySut> findAllOrderByColumn(String column){
		return baseDAO.find(" from ApplySut u order by ? desc, u.status_id asc", new Object[] {column});
	}
	@Override
	public List<ApplySut> findAllOrderByColumnPagination(String column ,Integer page, Integer row) {
		// TODO Auto-generated method stub
		return baseDAO.find(" from ApplySut u order by ? desc", new Object[] {column}, page, row);
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
		return baseDAO.count("select count(*) from ApplySut");
	}

	@Override
	public Long findPagesByMultiConditions(HashMap<String, Object> conditions) {
		// TODO Auto-generated method stub
		return baseDAO.count(conditions);
	}
	
public List<ApplySutDto> getApplySutDto(List<ApplySut> applySuts){
		
		List<ApplySutDto> applySutDtos = new ArrayList<ApplySutDto>();
		
		for(int i=0; i<applySuts.size(); i++){
			
			ApplySutDto applySutDto = new ApplySutDto();
			
			ApplySutStatusDto applySutStatusDto = new ApplySutStatusDto();
			applySutStatusDto.setName(applySutDto.getApplysutstatusdto().getName());
			applySutStatusDto.setDescription(applySutDto.getDescription());
			
			applySutDto.setApplysutstatusdto(applySutStatusDto);
			applySutDto.setApplyer(applySuts.get(i).getName());
			applySutDto.setApplytime(applySuts.get(i).getApplytime());
			applySutDto.setCode(applySuts.get(i).getCode());
			applySutDto.setComment(applySuts.get(i).getComment());
			applySutDto.setDescription(applySuts.get(i).getDescription());
			applySutDto.setGroupname(applySuts.get(i).getGroup().getName());
			applySutDto.setResolvetime(applySuts.get(i).getResolvetime());
			applySutDto.setApplyer(applySuts.get(i).getUser().getAlias());
			applySutDtos.add(applySutDto);
		}
		
		return applySutDtos;
		
	}


}
