package com.paftp.service.Testpass;

import java.util.List;

import com.paftp.entity.Testpass;

public interface TestpassService {

	public void saveTestpass(Testpass testpass);

	public void updateTestpass(Testpass testpass);

	public Testpass findTestpassById(int id);

	public Testpass findTestpassByName(String name);

	public void deleteTestpass(Testpass testpass);

	public List<Testpass> findAllList();
}
