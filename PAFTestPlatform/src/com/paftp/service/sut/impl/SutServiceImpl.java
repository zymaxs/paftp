package com.paftp.service.sut.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Sut;
import com.paftp.service.sut.SutService;

@Service("sutService")
public class SutServiceImpl implements SutService {

	@Resource
	private BaseDAO<Sut> baseDAO;

	@Override
	public void saveSut(Sut sut) {
		baseDAO.save(sut);
	}

	@Override
	public void updateSut(Sut sut) {
		baseDAO.update(sut);
	}

	@Override
	public Sut findSutById(int id) {
		return baseDAO.get(Sut.class, id);
	}

	@Override
	public Sut findSutByCode(String code) {
		return baseDAO.get(" from Suts s where s.code = ?",
				new Object[] { code });
	}
	
	@Override
	public Sut findSutByName(String name) {
		return baseDAO.get(" from Suts s where s.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteSut(Sut sut) {
		baseDAO.delete(sut);
	}

	@Override
	public List<Sut> findAllList() {
		return baseDAO.find(" from Suts s order by s.id");
	}



}
