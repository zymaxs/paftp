package com.paftp.bean;

import java.util.List;

public class TestcaseResult {

	private String casename;
	private Boolean ispass;
	private String description;
	private Integer testsuite_id;
	private Integer testcase_id;
	private List<TestcaseResultContent> testcaseresult_contents;

	public String getCasename() {
		return casename;
	}

	public void setCasename(String casename) {
		this.casename = casename;
	}

	public Boolean getIspass() {
		return ispass;
	}

	public void setIspass(Boolean ispass) {
		this.ispass = ispass;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getTestsuite_id() {
		return testsuite_id;
	}

	public void setTestsuite_id(Integer testsuite_id) {
		this.testsuite_id = testsuite_id;
	}

	public Integer getTestcase_id() {
		return testcase_id;
	}

	public void setTestcase_id(Integer testcase_id) {
		this.testcase_id = testcase_id;
	}

	public List<TestcaseResultContent> getTestcaseresult_contents() {
		return testcaseresult_contents;
	}

	public void setTestcaseresult_contents(List<TestcaseResultContent> testcaseresult_contents) {
		this.testcaseresult_contents = testcaseresult_contents;
	}


}
