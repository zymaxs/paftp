package com.paftp.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Version {

	private Integer id;
	private Integer versionNum;
	private Date createTime;
	private String creatorId;
	private List<Testpass> testpass_results;
	private List<Testsuite> testsuites;

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

	@Column(name = "version_num", length = 11)
	public Integer getVersionNum() {
		return versionNum;
	}

	public void setVersionNum(Integer versionNum) {
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
	
	@Column(name = "creator_id", length = 100)
	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
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
	
}
