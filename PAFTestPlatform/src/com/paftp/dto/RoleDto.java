package com.paftp.dto;

import com.paftp.entity.Sut;

public class RoleDto {

	private Integer id;
	private String name;
	private String description;
	private SutDto sutdto;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public SutDto getSutdto() {
		return sutdto;
	}

	public void setSutdto(SutDto sutdto) {
		this.sutdto = sutdto;
	}

}
