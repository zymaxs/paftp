package com.paftp.dto;

import java.util.Date;

import com.paftp.entity.Version;

public class TestpassDto {

	private Integer id;
	private String testset;
	private Date createtime;
	private Version version;
	private Integer passcount;
	private Integer failcount;
	private Float percentage;
	private String tag;
	private String env;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTestset() {
		return testset;
	}
	public void setTestset(String testset) {
		this.testset = testset;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Version getVersion() {
		return version;
	}
	public void setVersion(Version version) {
		this.version = version;
	}
	public Integer getPasscount() {
		return passcount;
	}
	public void setPasscount(Integer passcount) {
		this.passcount = passcount;
	}
	public Integer getFailcount() {
		return failcount;
	}
	public void setFailcount(Integer failcount) {
		this.failcount = failcount;
	}
	public Float getPercentage() {
		return percentage;
	}
	public void setPercentage(Float percentage) {
		this.percentage = percentage;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getEnv() {
		return env;
	}
	public void setEnv(String env) {
		this.env = env;
	}
}
