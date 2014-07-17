package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.entity.TestsuiteResult;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;

@Controller
public class TestcaseresultAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7010705889254732007L;

	private Integer testcaseresult_id;
	
	private String prompt;

	@Resource
	private TestcaseResultService testcaseresultService;

	public String getTRHistoryStatus() {
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService
					.findTestcaseResultById(this.getTestcaseresult_id());

		} else {
			this.setPrompt("The testcaseresult id is null!");
		}

		return "success";
		
	}

	public Integer getTestcaseresult_id() {
		return testcaseresult_id;
	}

	public void setTestcaseresult_id(Integer testcaseresult_id) {
		this.testcaseresult_id = testcaseresult_id;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}
}
