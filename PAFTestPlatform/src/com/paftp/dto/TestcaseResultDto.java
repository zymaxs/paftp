package com.paftp.dto;

public class TestcaseResultDto {

	private Integer id;
	private Boolean ispass;
	private String description;
	private String casename;
	private String status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getIspass() {
		return ispass;
	}

	public void setIspass(Boolean ispass) {
		this.ispass = ispass;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCasename() {
		return casename;
	}

	public void setCasename(String casename) {
		this.casename = casename;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
