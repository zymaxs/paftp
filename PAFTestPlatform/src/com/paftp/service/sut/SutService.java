package com.paftp.service.sut;

import java.util.List;

import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.User;

public interface SutService {

	public void saveSut(Sut sut);

	public void updateSut(Sut sut);

	public Sut findSutById(int id);

	public Sut findSutByName(String name);

	public void deleteSut(Sut sut);

	public List<Sut> findAllList();

	//public User findUserByNameAndPassword(String username, String password);

}
