package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.service.TestcassResult.TestcaseResultService;

@Controller
public class TestcaseresultcontentAction extends ActionSupport{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2266050879983337077L;
	@Resource
	private TestcaseResultService testcaseresultService;
	
	private Integer testcaseresult_id;
	
	public String initialTestcaseresultcontent(){
		
HttpServletRequest request = ServletActionContext.getRequest();

		TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
		
		List<TestcaseResultContent> testcaseresultcontents = testcaseresult.getTestcaseresult_contents();
		
		request.setAttribute("testcaseresult", testcaseresult);
		request.setAttribute("testcaseresultcontents", testcaseresultcontents);
		
		return "success";
	}
	
	public Integer getTestcaseresult_id() {
		return testcaseresult_id;
	}

	public void setTestcaseresult_id(Integer testcaseresult_id) {
		this.testcaseresult_id = testcaseresult_id;
	}
	
}
