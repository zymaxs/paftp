package com.paftp.bean;

import java.util.Date;
import java.util.List;

public class Testpass {
	
	private String name;
	private String testset;
	private Date createtime;
	private String version_name;
	private String sut_name;
	private List<TestsuiteResult> testsuite_results;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTestset() {
		return testset;
	}
	public void setTestset(String testset) {
		this.testset = testset;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public List<TestsuiteResult> getTestsuite_results() {
		return testsuite_results;
	}
	public void setTestsuite_results(List<TestsuiteResult> testsuite_results) {
		this.testsuite_results = testsuite_results;
	}
	public String getVersion_name() {
		return version_name;
	}
	public void setVersion_name(String version_name) {
		this.version_name = version_name;
	}
	public String getSut_name() {
		return sut_name;
	}
	public void setSut_name(String sut_name) {
		this.sut_name = sut_name;
	}

}
