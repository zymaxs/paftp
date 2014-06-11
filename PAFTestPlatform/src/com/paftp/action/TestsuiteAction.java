package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.stereotype.Controller;

import com.paftp.entity.Sut;
import com.paftp.entity.TestcaseStep;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class TestsuiteAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;
	@Resource
	private TestcaseService testcaseService;
	@Resource
	private TestsuiteService testsuiteService;
	@Resource
	private TestcaseStepService testcasestepService;
	@Resource
	private SutService sutService;

	private String sut_name;
	private String testsuite_name;
	private String testcase_name;
	private String stresstestcase_name;

	private JSONArray jsonArray;
	private JSONObject jsonObject;
	private User user;

	private Util util = new Util();

	public String createTestcase() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}

		Sut sut = sutService.findSutByName(this.getSut_name());

		Testsuite testsuite = testsuiteService.findTestsuiteByName(this
				.getTestsuite_name());
		List<Testcase> testcases = new ArrayList<Testcase>();
		Testcase testcase = new Testcase();
		testcase.setCaseName(this.getTestcase_name());
		testcases.add(testcase);
		testsuite.setTestcases(testcases);
		sut.getTestsuites().add(testsuite);

		sutService.saveSut(sut);

		return "success";

	}
	
	public String deleteTestcase() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}
	
		Testcase testcase = testcaseService.findTestcaseByName(this.getTestcase_name());
		
		testcaseService.deleteTestcase(testcase);
		
		return "success";
	}

	public String createTestsuite() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

//		if (user == null) {
//			request.setAttribute("error", "Please log in firstly!");
//			return "error";
//		}

		Sut sut = sutService.findSutByName(this.getSut_name());
		Testsuite testsuite = new Testsuite();
		testsuite.setName(this.getTestsuite_name());
		testsuite.setSut(sut);
		testsuiteService.saveTestsuite(testsuite);
//		List<Testsuite> testsuites = new ArrayList<Testsuite>();
//		testsuites.add(testsuite);
//		sut.setTestsuites(testsuites);
//
//		sutService.saveSut(sut);

		return "success";

	}
	
	public String deleteTestsuite() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}
	
		Testsuite testsuite = testsuiteService.findTestsuiteByName(this.getTestsuite_name());
		
		testsuiteService.deleteTestsuite(testsuite);
		
		return "success";
	}

	public String initialParameters(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("sut_name", this.getSut_name());
		
		return "success";
	}
	
	public String initialTestsuites() throws ServletException, IOException {
		
		this.setJsonArray(this.getRootNode(this.getSut_name()));
		
//		request.setAttribute("sut_name", this.getSut_name());
//		request.setAttribute("flag", true);

		return "success";

	}

	private JSONArray getRootNode(String sut_name) {

		List<Sut> suts = new ArrayList<Sut>();
		
		Sut sut = sutService.findSutByName(sut_name);
		suts.add(sut);
		
		JSONArray parentNode0000 = new JSONArray();

		for (int i = 0; i < suts.size(); i++) {
			List<Testsuite> testsuites = suts.get(i).getTestsuites();
			JSONArray parentNode000 = new JSONArray();
			JSONArray parentNode00 = new JSONArray();
			for (int j = 0; j < testsuites.size(); j++) {
				List<Testcase> testcases = testsuites.get(j).getTestcases();
				JSONArray parentNode0 = new JSONArray();
				for (int l = 0; l < testcases.size(); l++) {
					JSONObject childNode0 = util.childNode(testcases.get(l)
							.getCaseName(), util.nodeType("00"), null);
					parentNode0.add(childNode0);
				}
				JSONObject childNode00 = util.childNode(testsuites.get(j)
						.getName(), util.nodeType("0"), parentNode0);
				parentNode00.add(childNode00);
			}
			JSONObject childNode000 = util.childNode("接口案例",
					"interfacetestsuite", parentNode00);
			parentNode000.add(childNode000);
			JSONObject childNode0000 = util.childNode(suts.get(i).getName(),
					"sut", parentNode000);
			parentNode0000.add(childNode0000);
		}

		return parentNode0000;
	}

	private User getSessionUser() {

		HttpSession session = ServletActionContext.getRequest().getSession(
				false);

		if (session == null || session.getAttribute("user") == null) {
			return null;
		} else {
			User user = (User) session.getAttribute("user");
			return user;
		}
	}

	public JSONArray getJsonArray() {
		return jsonArray;
	}

	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}

	public JSONObject getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(JSONObject jsonObject) {
		this.jsonObject = jsonObject;
	}

	public String getSut_name() {
		return sut_name;
	}

	public void setSut_name(String sut_name) {
		this.sut_name = sut_name;
	}

	public String getTestsuite_name() {
		return testsuite_name;
	}

	public void setTestsuite_name(String testsuite_name) {
		this.testsuite_name = testsuite_name;
	}

	public String getTestcase_name() {
		return testcase_name;
	}

	public void setTestcase_name(String testcase_name) {
		this.testcase_name = testcase_name;
	}

	public String getStresstestcase_name() {
		return stresstestcase_name;
	}

	public void setStresstestcase_name(String stresstestcase_name) {
		this.stresstestcase_name = stresstestcase_name;
	}

}
