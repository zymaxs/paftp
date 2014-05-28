package com.paftp.entity;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

public class ApplySutStatus {

	private Integer id;
	private String name;
	private String descrition;
	
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
	
	@Column(name = "name", unique = true, length = 50)
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", unique = true, length = 200)
	public String getDescrition() {
		return descrition;
	}

	public void setDescrition(String descrition) {
		this.descrition = descrition;
	}
	
	
}
