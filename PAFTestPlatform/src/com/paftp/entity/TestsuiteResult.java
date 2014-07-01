package com.paftp.entity;

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

import org.hibernate.annotations.GenericGenerator;

@Entity
public class TestsuiteResult {
	
	private Integer id;
	private String suitename;
	private Integer setupstatus;
	private String setupdescription;
	private Integer cleanupstatus;
	private String cleanupdescription;
	private Testpass testpass;
	private Testsuite testsuite;
	private List<TestcaseResult> testcase_results;
	
	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	@Column(name = "ID", length = 11)
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "suitename", length = 50)  
	public String getSuitename() {
		return suitename;
	}
	
	public void setSuitename(String suitename) {
		this.suitename = suitename;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testpass_id")
	public Testpass getTestpass() {
		return testpass;
	}
	
	public void setTestpass(Testpass testpass) {
		this.testpass = testpass;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testsuite_id")
	public Testsuite getTestsuite() {
		return testsuite;
	}
	
	public void setTestsuite(Testsuite testsuite) {
		this.testsuite = testsuite;
	}
	
	@OneToMany(mappedBy = "testsuite_result", cascade = CascadeType.REFRESH)
	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}
	
	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}

	@Column(name = "setupstatus", length = 11)
	public Integer getSetupstatus() {
		return setupstatus;
	}

	public void setSetupstatus(Integer setupstatus) {
		this.setupstatus = setupstatus;
	}

	@Column(name = "setupdescription", length = 200)  
	public String getSetupdescription() {
		return setupdescription;
	}

	public void setSetupdescription(String setupdescription) {
		this.setupdescription = setupdescription;
	}

	@Column(name = "cleanupstatus", length = 11)
	public Integer getCleanupstatus() {
		return cleanupstatus;
	}

	public void setCleanupstatus(Integer cleanupstatus) {
		this.cleanupstatus = cleanupstatus;
	}

	@Column(name = "cleanupdescription", length = 200)  
	public String getCleanupdescription() {
		return cleanupdescription;
	}

	public void setCleanupdescription(String cleanupdescription) {
		this.cleanupdescription = cleanupdescription;
	}


}
