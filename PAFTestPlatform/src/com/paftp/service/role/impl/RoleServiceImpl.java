package com.paftp.service.role.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.dto.ApplySutDto;
import com.paftp.dto.RoleDto;
import com.paftp.dto.SutDto;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.service.role.RoleService;


@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
	private BaseDAO<Role> baseDAO;

	@Override
	public void saveRole(Role role) {
		baseDAO.save(role);
	}

	@Override
	public void updateRole(Role role) {
		baseDAO.update(role);
	}

	@Override
	public void saveorupdateRole(Role role) {
		// TODO Auto-generated method stub
		baseDAO.saveOrUpdate(role);
	}
	
	@Override
	public Role findRoleById(int id) {
		return baseDAO.get(Role.class, id);
	}

	
	@Override
	public Role findRoleByName(String name) {
		return baseDAO.get(" from Role r where r.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteRole(Role role) {
		baseDAO.delete(role);
	}

	@Override
	public List<Role> findAllList() {
		return baseDAO.find(" from Role r order by r.id");
	}

	@Override
	public List<Role> findRoleBySutId(Integer id) {
		// TODO Auto-generated method stub
		return baseDAO.find(" from Role r where r.sut_id = ?", new Object[] {id});
	}

	@Override
	public Role findRoleBySutIdAndName(Integer id, String name) {
		// TODO Auto-generated method stub
		return baseDAO.get(" from Role r where r.sut_id = ? and r.name = ?", new Object[] {id, name});
	}

	public List<RoleDto> getRoleDto(List<Role> roles) {
		// TODO Auto-generated method stub
		List<RoleDto> roleDtoes = new ArrayList<RoleDto>();
		
		for (int i=0; i<roles.size(); i++){
			if (roles.get(i).getName().equals("seniormanager") == false){
			RoleDto roleDto = new RoleDto();
			roleDto.setId(roles.get(i).getId());
			roleDto.setName(roles.get(i).getName());
			roleDto.setDescription(roles.get(i).getDescription());
			SutDto sutDto = new SutDto();
			sutDto.setCode(roles.get(i).getSut().getCode());
			sutDto.setName(roles.get(i).getSut().getName());
			roleDto.setSutdto(sutDto);
			roleDtoes.add(roleDto);
			}
		}
		
		return roleDtoes;
	}



}
