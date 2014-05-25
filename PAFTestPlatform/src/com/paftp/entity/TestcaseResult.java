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
public class TestcaseResult {

	private Integer id;
	private String casename;
	private String description;
	private String casetype;
	private Boolean ispass;
	private Testcase testcase;
	private TestsuiteResult testsuite_result;
	private List<TestcaseResultContent> testcaseresult_contents;
	
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
	
	@Column(name = "casename", length = 50)  
	public String getCasename() {
		return casename;
	}
	
	public void setCasename(String casename) {
		this.casename = casename;
	}
	
	@Column(name = "description", length = 150) 
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	@Column(name = "casetype", length = 20) 
	public String getCasetype() {
		return casetype;
	}
	
	public void setCasetype(String casetype) {
		this.casetype = casetype;
	}
	
	@Column(name = "ispass", columnDefinition = "TINYINT")
	public Boolean getIspass() {
		return ispass;
	}
	
	public void setIspass(Boolean ispass) {
		this.ispass = ispass;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testsuite_id")
	public TestsuiteResult getTestsuite_result() {
		return testsuite_result;
	}
	
	public void setTestsuite_result(TestsuiteResult testsuite_result) {
		this.testsuite_result = testsuite_result;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testcase_id")
	public Testcase getTestcase() {
		return testcase;
	}
	
	public void setTestcase(Testcase testcase) {
		this.testcase = testcase;
	}
	
	@OneToMany(mappedBy = "testcase_result")
	public List<TestcaseResultContent> getTestcaseresult_contents() {
		return testcaseresult_contents;
	}
	
	public void setTestcaseresult_contents(
			List<TestcaseResultContent> testcaseresult_contents) {
		this.testcaseresult_contents = testcaseresult_contents;
	}

	
}
