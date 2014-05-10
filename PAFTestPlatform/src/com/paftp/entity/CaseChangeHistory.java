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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class CaseChangeHistory {

	private Integer id;
	private Testcase testcase;
	private User updator;
	private List<CaseChangeOperation> caseChangeOperations;

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

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "testcase_id")
	public Testcase getTestcase() {
		return testcase;
	}

	public void setTestcase(Testcase testcase) {
		this.testcase = testcase;
	}
	
	@OneToMany(mappedBy = "caseChangeHistory")
	public List<CaseChangeOperation> getCaseChangeOperations() {
		return caseChangeOperations;
	}

	public void setCaseChangeOperations(List<CaseChangeOperation> caseChangeOperations) {
		this.caseChangeOperations = caseChangeOperations;
	}
	
}
