package com.paftp.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Testcase {

	private Integer id;
	private String caseName;
	private String description;
	private String status;
	private String priority;
	private User creator;
	private Date createTime;

	private Testsuite testsuite;

	private List<TestcaseStep> testcaseSteps;

	private List<CaseChangeHistory> caseChangeHistorys;
	
	private List<TestcaseResult> testcase_results;

	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	@Column(name = "id", length = 11)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 100)
	public String getCaseName() {
		return caseName;
	}

	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}

	@Column(name = "priority", length = 8)
	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	@Column(name = "status", length = 20)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "description", length = 200)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "creator_id")
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	@OneToMany(mappedBy = "testcase",cascade = CascadeType.ALL)
	public List<TestcaseStep> getTestcaseSteps() {
		return testcaseSteps;
	};

	public void setTestcaseSteps(List<TestcaseStep> testcaseSteps) {
		this.testcaseSteps = testcaseSteps;
	}

	@OneToMany(mappedBy = "testcase",cascade = CascadeType.ALL)
	public List<CaseChangeHistory> getCaseChangeHistorys() {
		return caseChangeHistorys;
	};

	public void setCaseChangeHistorys(List<CaseChangeHistory> caseChangeHistorys) {
		this.caseChangeHistorys = caseChangeHistorys;
	}

	@ManyToOne(cascade = CascadeType.REFRESH)
	@JoinColumn(name = "testsuite_id")
	public Testsuite getTestsuite() {
		return testsuite;
	};

	public void setTestsuite(Testsuite testsuite) {
		this.testsuite = testsuite;
	}
	
	@OneToMany(mappedBy = "testcase")
	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}
	
	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}

}
