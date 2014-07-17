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
	private String url;
	private String description;
	private Boolean ispass;
	private Testcase testcase;
	private TestsuiteResult testsuite_result;
	private List<TestcaseResultContent> testcaseresult_contents;
	private List<AnalyseCommentHistory> analysecomment_histories;
	
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
	
	@Column(name = "ispass", columnDefinition = "TINYINT")
	public Boolean getIspass() {
		return ispass;
	}
	
	public void setIspass(Boolean ispass) {
		this.ispass = ispass;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testsuiteresult_id")
	public TestsuiteResult getTestsuite_result() {
		return testsuite_result;
	}
	
	public void setTestsuite_result(TestsuiteResult testsuite_result) {
		this.testsuite_result = testsuite_result;
	}
	
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
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

	@Column(name = "url", length = 200)  
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@OneToMany(mappedBy = "testcase_result")
	public List<AnalyseCommentHistory> getAnalysecomment_histories() {
		return analysecomment_histories;
	}

	public void setAnalysecomment_histories(List<AnalyseCommentHistory> analysecomment_histories) {
		this.analysecomment_histories = analysecomment_histories;
	}

	
}
