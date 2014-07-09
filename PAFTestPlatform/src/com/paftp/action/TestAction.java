package com.paftp.action;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Testsuite;
import com.paftp.entity.Testcase;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;

@Controller
public class TestAction extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2467240814567830530L;
	@Resource
	private TestcaseService testcaseService;
	@Resource
	private TestsuiteService testsuiteService;
	
	public String testDelete(){
		
//		HttpServletRequest request = ServletActionContext.getRequest();
		
//		List<Testcase> testcases = new ArrayList<Testcase>();
//		Testcase testcase = new Testcase();
//		testcase.setCaseName("mtp001");
//		testcase.setPriority("1");
//		testcase.setStatus("1");
//		testcases.add(testcase);
//		
//		Testsuite testsuite = new Testsuite();
//		testsuite.setName("mtp");
//		testsuite.setTestcases(testcases);
//		
//		testsuiteService.saveTestsuite(testsuite);
		
		Testsuite testsuite = testsuiteService.findTestsuiteById(1);
		
		Testcase testcase = new Testcase();
		testcase.setCaseName("mtp001");
		testcase.setPriority("1");
		testcase.setStatus("1");
		testcase.setTestsuite(testsuite);
		
		testcaseService.saveTestcase(testcase);
		
//		Testsuite testsuite = testsuiteService.findTestsuiteById(3);
//		
//		testsuiteService.deleteTestsuite(testsuite);
//		
//		request.setAttribute("flag", "false");
		
//		Testcase testcase = testcaseService.findTestcaseById(1);
//		testcaseService.deleteTestcase(testcase);
		
//		Testcase testcase = testcaseService.findTestcaseById(1);
//		testcase.getTestsuite().setName("lalala");
//		testcaseService.deleteTestcase(testcase);
		
		return "success";
	}

}
