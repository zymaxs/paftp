package com.paftp.dto;

import java.util.Date;

public class ApplySutDto {
	
	private Integer id;
	private String code;

	private String name;
	private String description;
	private Date applytime;
	private String applyer;
	private String groupname;
	private ApplySutStatusDto applysutstatusdto;

	private Date resolvetime;
	private String comment;
	
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
	public Date getApplytime() {
		return applytime;
	}
	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}
	public String getApplyer() {
		return applyer;
	}
	public void setApplyer(String applyer) {
		this.applyer = applyer;
	}
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	public Date getResolvetime() {
		return resolvetime;
	}
	public void setResolvetime(Date resolvetime) {
		this.resolvetime = resolvetime;
	}

	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	public ApplySutStatusDto getApplysutstatusdto() {
		return applysutstatusdto;
	}
	public void setApplysutstatusdto(ApplySutStatusDto applysutstatusdto) {
		this.applysutstatusdto = applysutstatusdto;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

}
