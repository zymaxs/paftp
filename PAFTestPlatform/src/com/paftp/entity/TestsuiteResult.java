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
	private String description;
	private Testpass testpass;
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
	
	@Column(name = "description", length = 150) 
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testpass_id")
	public Testpass getTestpass() {
		return testpass;
	}
	
	public void setTestpass(Testpass testpass) {
		this.testpass = testpass;
	}
	
	@OneToMany(mappedBy = "testsuite_result")
	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}
	
	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}


}
