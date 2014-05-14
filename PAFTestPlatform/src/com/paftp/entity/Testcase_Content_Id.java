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
public class Testcase_Content_Id {

	private Integer id;
	private Integer startposition;
	private Testcase_Result testcase_result;
	
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
	
	@Column(name = "startposition", length = 11)
	public Integer getStartposition() {
		return startposition;
	}
	
	public void setStartposition(Integer startposition) {
		this.startposition = startposition;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "testcase_id")
	public Testcase_Result getTestcase_result() {
		return testcase_result;
	}
	
	public void setTestcase_result(Testcase_Result testcase_result) {
		this.testcase_result = testcase_result;
	}

	
	
}
