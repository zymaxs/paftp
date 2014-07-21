package com.paftp.dto;

import java.util.Date;

import com.paftp.entity.TestcaseResult;
import com.paftp.entity.User;

public class AnalyseCommentHistoryDto {
	
	private Integer id;
	private TestcaseResult testcase_result;
	private String oldstatus;
	private String newstatus;
	private String oldcomment;
	private String newcomment;
	private User updator;
	private Date createtime;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public TestcaseResult getTestcase_result() {
		return testcase_result;
	}
	public void setTestcase_result(TestcaseResult testcase_result) {
		this.testcase_result = testcase_result;
	}
	public String getOldstatus() {
		return oldstatus;
	}
	public void setOldstatus(String oldstatus) {
		this.oldstatus = oldstatus;
	}
	public String getNewstatus() {
		return newstatus;
	}
	public void setNewstatus(String newstatus) {
		this.newstatus = newstatus;
	}
	public String getOldcomment() {
		return oldcomment;
	}
	public void setOldcomment(String oldcomment) {
		this.oldcomment = oldcomment;
	}
	public String getNewcomment() {
		return newcomment;
	}
	public void setNewcomment(String newcomment) {
		this.newcomment = newcomment;
	}
	public User getUpdator() {
		return updator;
	}
	public void setUpdator(User updator) {
		this.updator = updator;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
}
