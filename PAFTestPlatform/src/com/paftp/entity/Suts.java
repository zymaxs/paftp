package com.paftp.entity;

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

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Suts {
	
	private Integer id;
	private String code;
	private String name;
	private String description;
	private SutGroup group;
	private List<Role> role_results;
	private List<Testpass> testpass_results;
	private List<StressResult> stress_results;
	
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
	
	@Column(name = "code", length = 20)
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	@Column(name = "name", unique = true, length = 100)
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
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "group_id")
	public SutGroup getGroup() {
		return group;
	}
	public void setGroup(SutGroup group) {
		this.group = group;
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
	public List<StressResult> getStress_results() {
		return stress_results;
	}

	public void setStress_results(List<StressResult> stress_results) {
		this.stress_results = stress_results;
	}

}
