package com.paftp.entity;

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

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Testsuite {

	private Integer id;
	private String name;
	private Sut sut;
	private List<Testcase> testcases;

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

	@OneToMany(mappedBy = "testsuite",cascade = CascadeType.ALL)
	public List<Testcase> getTestcases() {
		return testcases;
	}

	public void setTestcases(List<Testcase> testcases) {
		this.testcases = testcases;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "sut_id")
	public Sut getSut() {
		return sut;
	}

	public void setSut(Sut sut) {
		this.sut = sut;
	}

}
