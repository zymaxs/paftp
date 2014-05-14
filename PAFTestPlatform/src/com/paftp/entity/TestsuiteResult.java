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
	private Integer passcount;
	private Integer failcount;
	private Integer total;
	private String passratio;
	private String failratio;
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
	
	@Column(name = "passcount", length = 11)
	public Integer getPasscount() {
		return passcount;
	}
	
	public void setPasscount(Integer passcount) {
		this.passcount = passcount;
	}
	
	@Column(name = "failcount", length = 11)
	public Integer getFailcount() {
		return failcount;
	}
	
	public void setFailcount(Integer failcount) {
		this.failcount = failcount;
	}
	
	@Column(name = "total", length = 11)
	public Integer getTotal() {
		return total;
	}
	
	public void setTotal(Integer total) {
		this.total = total;
	}
	
	@Column(name = "passratio", length = 20) 
	public String getPassratio() {
		return passratio;
	}
	
	public void setPassratio(String passratio) {
		this.passratio = passratio;
	}
	
	@Column(name = "failratio", length = 20) 
	public String getFailratio() {
		return failratio;
	}
	
	public void setFailratio(String failratio) {
		this.failratio = failratio;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testpass_id")
	public Testpass getTestpass() {
		return testpass;
	}
	
	public void setTestpass(Testpass testpass) {
		this.testpass = testpass;
	}
	
	@OneToMany(mappedBy = "testsuiteresult")
	public List<TestcaseResult> getTestcase_results() {
		return testcase_results;
	}
	
	public void setTestcase_results(List<TestcaseResult> testcase_results) {
		this.testcase_results = testcase_results;
	}


}
