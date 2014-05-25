package com.paftp.service.sut;

import java.util.List;

import com.paftp.entity.Sut;

public interface SutService {

	public void saveSut(Sut sut);

	public void updateSut(Sut sut);

	public Sut findSutById(int id);
	
	public Sut findSutByCode(String code);
	
	public Sut findSutByName(String name);

	public void deleteSut(Sut sut);

	public List<Sut> findAllList();


}
