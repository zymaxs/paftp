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
public class Testcase_Result {

	private Integer id;
	private String casename;
	private String description;
	private String casetype;
	private Boolean ispass;
	private Testsuite_Result testsuite_result;
	private List<Testcase_Result_Content> testcase_result_contents;
	
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
	public Testsuite_Result getTestsuite_result() {
		return testsuite_result;
	}
	
	public void setTestsuite_result(Testsuite_Result testsuite_result) {
		this.testsuite_result = testsuite_result;
	}
	
	@OneToMany(mappedBy = "testcase_result")
	public List<Testcase_Result_Content> getTestcase_result_contents() {
		return testcase_result_contents;
	}
	
	public void setTestcase_result_contents(
			List<Testcase_Result_Content> testcase_result_contents) {
		this.testcase_result_contents = testcase_result_contents;
	}

	
}
