package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestsuiteResult;
import com.paftp.service.Testpass.TestpassService;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;

@Controller
public class TestcaseresultAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7010705889254732007L;

	private Integer testsuite_id;

	@Resource
	private TestsuiteResultService testsuiteresultService;
	
	public String initialTestcaseresults(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		TestsuiteResult testsuiteresult = testsuiteresultService.findTestsuiteResultById(this.getTestsuite_id());
		
		List<TestcaseResult> testcaseresults = testsuiteresult.getTestcase_results();
		
		request.setAttribute("testsuiteresult", testsuiteresult);
		request.setAttribute("testcaseresults", testcaseresults);
		
		return "success";
	}
	
	public Integer getTestsuite_id() {
		return testsuite_id;
	}

	public void setTestsuite_id(Integer testsuite_id) {
		this.testsuite_id = testsuite_id;
	}
	
}
