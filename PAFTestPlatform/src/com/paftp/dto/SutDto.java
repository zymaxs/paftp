package com.paftp.dto;

import com.paftp.entity.SutGroup;

public class SutDto {

	private Integer id;
	private Integer changetag;
	private String code;
	private String name;
	private String description;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getChangetag() {
		return changetag;
	}
	public void setChangetag(Integer changetag) {
		this.changetag = changetag;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
}
