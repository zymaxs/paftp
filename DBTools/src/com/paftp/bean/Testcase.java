package com.paftp.bean;

import java.util.List;

public class Testcase {
	
	private String casename;
	//private String description;
	//private String casetype;
	//private int testcaseid;
	private String result;

	private List<Testcasecontent> Testcasecontents;

	public String getCasename() {
		return casename;
	}
	public void setCasename(String casename) {
		this.casename = casename;
	}
//	public String getCasetype() {
//		return casetype;
//	}
//	public void setCasetype(String casetype) {
//		this.casetype = casetype;
//	}
//	public int getTestcaseid() {
//		return testcaseid;
//	}
//	public void setTestcaseid(int testcaseid) {
//		this.testcaseid = testcaseid;
//	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public List<Testcasecontent> getTestcasecontents() {
		return Testcasecontents;
	}
	public void setTestcasecontents(List<Testcasecontent> testcasecontents) {
		Testcasecontents = testcasecontents;
	}
}
