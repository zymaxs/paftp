package com.paftp.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class ApplySut {
	
	private Integer id;
	private Date applytime;
	private Date resolvetime;
	private String comment;
	private User user;
	private String code;
	private String name;
	private String description;
	private SutGroup group;
	private ApplySutStatus applysutstatus;

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
	
	@Column(name = "comment", length = 200)
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	@Column(name = "code",  unique = true, length = 20)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "name", length = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", length = 200)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	@JoinColumn(name = "group_id")
	public SutGroup getGroup() {
		return group;
	}
	public void setGroup(SutGroup group) {
		this.group = group;
	}

	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "status_id")
	public ApplySutStatus getApplysutstatus() {
		return applysutstatus;
	}

	public void setApplysutstatus(ApplySutStatus applysutstatus) {
		this.applysutstatus = applysutstatus;
	}


	

}
