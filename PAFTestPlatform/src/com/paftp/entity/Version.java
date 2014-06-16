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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Version {

	private Integer id;
	private String versionNum;
	private Date createTime;
	private User user;
	private List<Testpass> testpass_results;
	private List<Testsuite> testsuites;
	private List<Sut> suts;

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

	@Column(name = "version_num", length = 50)
	public String getVersionNum() {
		return versionNum;
	}

	public void setVersionNum(String versionNum) {
		this.versionNum = versionNum;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "creator_id")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	@OneToMany(mappedBy = "version")
	public List<Testpass> getTestpass_results() {
		return testpass_results;
	}

	public void setTestpass_results(List<Testpass> testpass_results) {
		this.testpass_results = testpass_results;
	}

	@OneToMany(mappedBy = "version")
	public List<Testsuite> getTestsuites() {
		return testsuites;
	}

	public void setTestsuites(List<Testsuite> testsuites) {
		this.testsuites = testsuites;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "sut_version", joinColumns = { @JoinColumn(name = "version_id") }, inverseJoinColumns = { @JoinColumn(name = "sut_id") })
	public List<Sut> getSuts() {
		return suts;
	}

	public void setSuts(List<Sut> suts) {
		this.suts = suts;
	}
	
}
