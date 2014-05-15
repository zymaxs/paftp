package com.paftp.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class AnalyseCommentContent {

	private Integer id;
	private AnalyseCommentHistory analyseCommentHistory;
	private String status;
	private String comment;
	
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
	@JoinColumn(name = "analysecommenthistory_id")
	public AnalyseCommentHistory getAnalyseCommentHistory() {
		return analyseCommentHistory;
	}
	
	public void setAnalyseCommentHistory(AnalyseCommentHistory analyseCommentHistory) {
		this.analyseCommentHistory = analyseCommentHistory;
	}
	
	@Column(name = "status", length = 10)
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Column(name = "comment", length = 100)
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}

	
	
}
