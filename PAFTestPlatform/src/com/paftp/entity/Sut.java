package com.paftp.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Sut {

	private Integer id;
	private String code;
	private String name;
	private String description;
	private Integer group_id;
	private List<Role> role_results;
	private List<Testpass> testpass_results;
	private List<Version> version_results;

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

	@Column(name = "name", unique = true, length = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "code", length = 20)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Column(name = "description", length = 20)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@OneToMany(mappedBy = "sut")
	public List<Role> getRole_results() {
		return role_results;
	}

	public void setRole_results(List<Role> role_results) {
		this.role_results = role_results;
	}
	
	@OneToMany(mappedBy = "sut")
	public List<Testpass> getTestpass_results() {
		return testpass_results;
	}

	public void setTestpass_results(List<Testpass> testpass_results) {
		this.testpass_results = testpass_results;
	}
	
	@OneToMany(mappedBy = "sut")
	public List<Version> getVersion_results() {
		return version_results;
	}

	public void setVersion_results(List<Version> version_results) {
		this.version_results = version_results;
	}

	@Column(name = "group_id", length = 11)
	public Integer getGroup_id() {
		return group_id;
	}

	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
}
