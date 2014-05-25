package com.paftp.service.sut.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.Suts;
import com.paftp.service.sut.SutService;

@Service("sutService")
public class SutServiceImpl implements SutService {

	@Resource
	private BaseDAO<Suts> baseDAO;

	@Override
	public void saveSut(Suts sut) {
		baseDAO.save(sut);
	}

	@Override
	public void updateSut(Suts sut) {
		baseDAO.update(sut);
	}

	@Override
	public Suts findSutById(int id) {
		return baseDAO.get(Suts.class, id);
	}

	@Override
	public Suts findSutByCode(String code) {
		return baseDAO.get(" from Suts s where s.code = ?",
				new Object[] { code });
	}
	
	@Override
	public Suts findSutByName(String name) {
		return baseDAO.get(" from Suts s where s.name = ?",
				new Object[] { name });
	}

	@Override
	public void deleteSut(Suts sut) {
		baseDAO.delete(sut);
	}

	@Override
	public List<Suts> findAllList() {
		return baseDAO.find(" from Suts s order by s.id");
	}



}
