package com.paftp.bean;

import java.util.Date;
import java.util.List;

public class Testpass {

	private String testset;
	// private Date createtime;
	private String version;
	private String sut;
	private List<Testsuite> testsuites;

	public String getTestset() {
		return testset;
	}

	public void setTestset(String testset) {
		this.testset = testset;
	}

	// public Date getCreatetime() {
	// return createtime;
	// }
	// public void setCreatetime(Date createtime) {
	// this.createtime = createtime;
	// }

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getSut() {
		return sut;
	}

	public void setSut(String sut) {
		this.sut = sut;
	}

	public List<Testsuite> getTestsuites() {
		return testsuites;
	}

	public void setTestsuites(List<Testsuite> testsuites) {
		this.testsuites = testsuites;
	}

}
