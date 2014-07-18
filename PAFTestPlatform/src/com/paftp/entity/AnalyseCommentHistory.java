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
public class AnalyseCommentHistory {

	private Integer id;
	private TestcaseResult testcase_result;
	private String oldstatus;
	private String newstatus;
	private String oldcomment;
	private String newcomment;
	private User updator;
	private Date createtime;
	
	
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
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	public User getUpdator() {
		return updator;
	}
	
	public void setUpdator(User updator) {
		this.updator = updator;
	}

	@Column(name = "oldstatus", length = 20)  
	public String getOldstatus() {
		return oldstatus;
	}

	public void setOldstatus(String oldstatus) {
		this.oldstatus = oldstatus;
	}

	@Column(name = "newstatus", length = 20)  
	public String getNewstatus() {
		return newstatus;
	}

	public void setNewstatus(String newstatus) {
		this.newstatus = newstatus;
	}

	@Column(name = "oldcomment", length = 1024)  
	public String getOldcomment() {
		return oldcomment;
	}

	public void setOldcomment(String oldcomment) {
		this.oldcomment = oldcomment;
	}

	@Column(name = "newcomment", length = 1024)  
	public String getNewcomment() {
		return newcomment;
	}

	public void setNewcomment(String newcomment) {
		this.newcomment = newcomment;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "createtime")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testcaseresult_id")
	public TestcaseResult getTestcase_result() {
		return testcase_result;
	}

	public void setTestcase_result(TestcaseResult testcase_result) {
		this.testcase_result = testcase_result;
	}
}
