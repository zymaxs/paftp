package com.paftp.bean;

import java.util.List;

public class TestsuiteResult {

	private String suitename;
	private Integer testpass_id;
	private Integer testsuite_id;
	private String setupstatus;
	private String setupdescription;
	private List<TestcaseResult> testcase_results;

	public String getSuitename() {
		return suitename;
	}

	public void setSuitename(String suitename) {
		this.suitename = suitename;
	}

	public Integer getTestpass_id() {
		return testpass_id;
	}

	public void setTestpass_id(Integer testpass_id) {
		this.testpass_id = testpass_id;
	}

	public Integer getTestsuite_id() {
		return testsuite_id;
	}

	public void setTestsuite_id(Integer testsuite_id) {
		this.testsuite_id = testsuite_id;
	}

	public String getSetupstatus() {
		return setupstatus;
	}

	public void setSetupstatus(String setupstatus) {
		this.setupstatus = setupstatus;
	}

	public String getSetupdescription() {
		return setupdescription;
	}

	public void setSetupdescription(String setupdescription) {
		this.setupdescription = setupdescription;
	}

	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}

	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}

}
