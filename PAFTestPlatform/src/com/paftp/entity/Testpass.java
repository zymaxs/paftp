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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Testpass {

	private Integer id;
	private String name;
	private String testset;
	private Date createtime;
	private Integer passcount;
	private Integer failcount;
	private Integer total;
	private String passratio;
	private String failratio;
	private Suts sut;
	private List<TestsuiteResult> testsuite_results;
	private Version version;

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
	

	@Column(name = "testset", length = 20)
	public String getTestset() {
		return testset;
	}

	public void setTestset(String testset) {
		this.testset = testset;
	}

	@Column(name = "name", length = 50)            
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "createtime")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Column(name = "passcount", length = 11)
	public Integer getPasscount() {
		return passcount;
	}

	public void setPasscount(Integer passcount) {
		this.passcount = passcount;
	}

	@Column(name = "failcount", length = 11)
	public Integer getFailcount() {
		return failcount;
	}

	public void setFailcount(Integer failcount) {
		this.failcount = failcount;
	}

	@Column(name = "total", length = 11)
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Column(name = "passratio", length = 20) 
	public String getPassratio() {
		return passratio;
	}

	public void setPassratio(String passratio) {
		this.passratio = passratio;
	}

	@Column(name = "failratio", length = 20) 
	public String getFailratio() {
		return failratio;
	}

	public void setFailratio(String failratio) {
		this.failratio = failratio;
	}

	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "sut_id")
	public Suts getSut() {
		return sut;
	}

	public void setSut(Suts sut) {
		this.sut = sut;
	}

	@OneToMany(mappedBy = "testpass")
	public List<TestsuiteResult> getTestsuite_results() {
		return testsuite_results;
	}

	public void setTestsuite_results(List<TestsuiteResult> testsuite_results) {
		this.testsuite_results = testsuite_results;
	}

	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "version_id")
	public Version getVersion() {
		return version;
	}

	public void setVersion(Version version) {
		this.version = version;
	}


	
}
