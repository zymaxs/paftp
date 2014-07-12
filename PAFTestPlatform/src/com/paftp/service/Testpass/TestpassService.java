package com.paftp.service.Testpass;

import java.util.List;

import com.paftp.dto.TestpassDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.Testpass;
import com.paftp.entity.Testsuite;

public interface TestpassService {

	public void saveTestpass(Testpass testpass);

	public void updateTestpass(Testpass testpass);

	public Testpass findTestpassById(int id);

	public Testpass findTestpassByName(String name);

	public void deleteTestpass(Testpass testpass);

	public List<Testpass> findAllList();
	
	public TestpassDto getTestpassDto(Testpass testpass, Integer passcount, Integer failcount, Float percentage);
}
