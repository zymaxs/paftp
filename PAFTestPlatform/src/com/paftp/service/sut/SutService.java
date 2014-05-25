package com.paftp.service.sut;

import java.util.List;

import com.paftp.entity.Suts;

public interface SutService {

	public void saveSut(Suts sut);

	public void updateSut(Suts sut);

	public Suts findSutById(int id);
	
	public Suts findSutByCode(String code);
	
	public Suts findSutByName(String name);

	public void deleteSut(Suts sut);

	public List<Suts> findAllList();


}
