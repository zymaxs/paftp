package com.paftp.bean;

import java.util.List;

public class Testsuite {
	private String suitename;
	// private String description;
//	private int testsuiteid;
//	private int testpassid;

	private List<Testcase> testcases;

	public String getSuitename() {
		return suitename;
	}

	public void setSuitename(String suitename) {
		this.suitename = suitename;
	}

	// public String getDescription() {
	// return description;
	// }
	// public void setDescription(String description) {
	// this.description = description;
	// }
	// public int getTestpassid() {
	// return testpassid;
	// }
	//
	// public void setTestpassid(int testpassid) {
	// this.testpassid = testpassid;
	// }
	//
	// public int getTestsuiteid() {
	// return testsuiteid;
	// }
	//
	// public void setTestsuiteid(int testsuiteid) {
	// this.testsuiteid = testsuiteid;
	// }

	public List<Testcase> getTestcases() {
		return testcases;
	}

	public void setTestcases(List<Testcase> testcases) {
		this.testcases = testcases;
	}
}
