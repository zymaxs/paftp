package com.paftp.dto;

import java.util.Date;
import java.util.List;

import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.TestcaseProject;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseStep;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;

public class TestcaseDto {

	private Integer id;
	private String caseName;
	private String description;
	private String status;
	private String priority;
	private User creator;
	private Date createTime;
	private String casesteps;
	private String casetype;
	private String testcase_approval;
	private TestcaseProject testcaseproject;

	private Testsuite testsuite;

	private List<TestcaseStep> testcaseSteps;

	private List<CaseChangeHistory> caseChangeHistorys;
	
	private List<TestcaseResult> testcase_results;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCaseName() {
		return caseName;
	}

	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCasesteps() {
		return casesteps;
	}

	public void setCasesteps(String casesteps) {
		this.casesteps = casesteps;
	}

	public String getCasetype() {
		return casetype;
	}

	public void setCasetype(String casetype) {
		this.casetype = casetype;
	}

	public String getTestcase_approval() {
		return testcase_approval;
	}

	public void setTestcase_approval(String testcase_approval) {
		this.testcase_approval = testcase_approval;
	}

	public TestcaseProject getTestcaseproject() {
		return testcaseproject;
	}

	public void setTestcaseproject(TestcaseProject testcaseproject) {
		this.testcaseproject = testcaseproject;
	}

	public Testsuite getTestsuite() {
		return testsuite;
	}

	public void setTestsuite(Testsuite testsuite) {
		this.testsuite = testsuite;
	}

	public List<TestcaseStep> getTestcaseSteps() {
		return testcaseSteps;
	}

	public void setTestcaseSteps(List<TestcaseStep> testcaseSteps) {
		this.testcaseSteps = testcaseSteps;
	}

	public List<CaseChangeHistory> getCaseChangeHistorys() {
		return caseChangeHistorys;
	}

	public void setCaseChangeHistorys(List<CaseChangeHistory> caseChangeHistorys) {
		this.caseChangeHistorys = caseChangeHistorys;
	}

	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}

	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}

}
