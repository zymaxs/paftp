package com.paftp.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

public class ApplySut {
	
	private Integer id;
	private Date applytime;
	private Date resolvetime;
	private String action;
	private String comment;
	private User user;
	private Sut sut;
	

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
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "applytime")
	public Date getApplytime() {
		return applytime;
	}
	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "resolvetime")
	public Date getResolvetime() {
		return resolvetime;
	}
	
	public void setResolvetime(Date resolvetime) {
		this.resolvetime = resolvetime;
	}
	
	@Column(name = "action", length = 20)
	public String getAction() {
		return action;
	}
	
	public void setAction(String action) {
		this.action = action;
	}
	
	@Column(name = "comment", length = 200)
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "approver_id")
	public User getApprover() {
		return user;
	}
	
	public void setApprover(User user) {
		this.user = user;
	}
	
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "sut_id")
	public Sut getSut() {
		return sut;
	}
	
	public void setSut(Sut sut) {
		this.sut = sut;
	}
	

	
	

}
