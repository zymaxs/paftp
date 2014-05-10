package com.paftp.entity;

import java.util.Date;
import java.util.List;
import java.util.Set;

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
public class Testpass {

	private Integer id;
	private String name;
	private Sut sut;
	private Date createtime;
	//private List<Testsuite> testsuites;

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

	@Column(name = "name", length = 200)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

//	@OneToMany(mappedBy = "testpass",cascade = CascadeType.ALL)
//	public List<Testsuite> getTestsuite() {
//		return testsuites;
//	}
//
//	public void setTestsuite(List<Testsuite> testsuites) {
//		this.testsuites = testsuites;
//	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "sut_id")
	public Sut getSut() {
		return sut;
	}

	public void setSut(Sut sut) {
		this.sut = sut;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "createtime")
	public Date getCreateTime() {
		return createtime;
	}

	public void setCreateTime(Date createtime) {
		this.createtime = createtime;
	}

}
