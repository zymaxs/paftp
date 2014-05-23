package com.paftp.entity;

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

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Role {

	private Integer id;
	private String name;
	private String description;
	private List<Permission> permissions;
	private List<User> users;
	private Sut sut;
	private Integer sut_id;

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

	@Column(name = "name", unique = true, length = 20)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
	@Column(name = "description", length = 30)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
	@JoinTable(name = "role_permission", joinColumns = { @JoinColumn(name = "role_id") }, inverseJoinColumns = { @JoinColumn(name = "permission_id") })
	public List<Permission> getPermissions() {
		return permissions;
	};

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}
	
	@ManyToMany(mappedBy = "roles")
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
	
	@ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
	@JoinColumn(name = "sut_id")
	public Sut getSut() {
		return sut;
	}

	public void setSut(Sut sut) {
		this.sut = sut;
	}

	@Column(name = "sut_id", length = 11)
	public Integer getSut_id() {
		return sut_id;
	}

	public void setSut_id(Integer sut_id) {
		this.sut_id = sut_id;
	}
}
