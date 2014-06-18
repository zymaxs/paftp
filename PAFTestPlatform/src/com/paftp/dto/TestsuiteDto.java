package com.paftp.dto;

import java.util.List;

import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.TestsuiteResult;
import com.paftp.entity.Version;

public class TestsuiteDto {

	private Integer id;
	private String name;
	private String status;
	private Sut sut;
	private String description;
	private Version version;
	private List<Testcase> testcases;
	private List<TestsuiteResult> testsuite_results;
	

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Sut getSut() {
		return sut;
	}
	public void setSut(Sut sut) {
		this.sut = sut;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Version getVersion() {
		return version;
	}
	public void setVersion(Version version) {
		this.version = version;
	}
	public List<Testcase> getTestcases() {
		return testcases;
	}
	public void setTestcases(List<Testcase> testcases) {
		this.testcases = testcases;
	}
	public List<TestsuiteResult> getTestsuite_results() {
		return testsuite_results;
	}
	public void setTestsuite_results(List<TestsuiteResult> testsuite_results) {
		this.testsuite_results = testsuite_results;
	}
	
}
