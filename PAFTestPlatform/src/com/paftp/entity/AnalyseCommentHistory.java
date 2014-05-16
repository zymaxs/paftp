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
import javax.persistence.OneToOne;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class AnalyseCommentHistory {

	private Integer id;
	private TestcaseResult testcaseresult;
	private User updator;
	private List<AnalyseCommentContent> analyseCommentContent;
	
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
	
	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "testcaseresult_id")
	public TestcaseResult getTestcaseresult() {
		return testcaseresult;
	}
	
	public void setTestcaseresult(TestcaseResult testcaseresult) {
		this.testcaseresult = testcaseresult;
	}
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	public User getUpdator() {
		return updator;
	}
	
	public void setUpdator(User updator) {
		this.updator = updator;
	}
	
	@OneToMany(mappedBy = "analyseCommentContent")
	public List<AnalyseCommentContent> getAnalyseCommentContent() {
		return analyseCommentContent;
	}
	
	public void setAnalyseCommentContent(
			List<AnalyseCommentContent> analyseCommentContent) {
		this.analyseCommentContent = analyseCommentContent;
	}

}
