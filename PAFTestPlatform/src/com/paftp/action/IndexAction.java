package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.TestcaseStep;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.user.UserService;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class IndexAction extends ActionSupport {

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

	private String username;
	private String password;

	public String index() throws ServletException, IOException {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		User user = new User();
		user.setAlias("duanjuding");
		Date date = new Date();
		user.setCreateTime(date);
		user.setPassword("123");
		UserInfo userInfo = new UserInfo();
		userInfo.setPosition("测试");
		userInfo.setDepartment("科技中心");
		user.setUserInfo(userInfo);
		user.setStatus("intial");
		user.setDisplayName("段居鼎");

		if (user != null) {
			userService.saveUser(user);

			// create sut: MTP
			Sut sut = sutService.findSutByCode("MTP");
			if (sut == null) {
				sut = new Sut();
				sut.setCode("MTP");
				sut.setName("移动接入平台");
				sut.setDescription("手机接入前置，用于隔离外网与内网");
				sutService.saveSut(sut);
			}

			// create testsuite: Ts_login
			Testsuite testsuite = new Testsuite();
			testsuite.setName("Ts_login");
			testsuite.setSut(sut);

		
			// create testcases
			List<Testcase> testcases = new ArrayList<Testcase>();

			for (int i = 0; i < 10; i++) {
				
				// create testcase
				Testcase testcase = new Testcase();
				
				String testcaseName = "Tc_login_" + i;
				testcase.setCaseName(testcaseName);
				testcase.setDescription("Demo testcase");
				date = new Date();
				testcase.setCreateTime(date);
				testcase.setPriority("P1");
				testcase.setCreator(user);

				// create casecontents
				List<TestcaseStep> testcasesteps = new ArrayList<TestcaseStep>();
				for (int j = 0; j < 3; j++) {

					// create casecontent
					TestcaseStep testcasestep = new TestcaseStep();
					
					String content = "操作" + j + ":xxxxx";
					testcasestep.setContent(content);
					testcasestep.setType("step");
					testcasestep.setTestcase(testcase);
					testcasestepService.saveTestcaseStep(testcasestep);
					testcasesteps.add(testcasestep);
				}
				
				testcase.setTestcaseSteps(testcasesteps);
				testcase.setTestsuite(testsuite);
				
				testcaseService.saveTestcase(testcase);
				testcases.add(testcase);
			}
			
			testsuiteService.saveTestsuite(testsuite);



			
			
			request.setAttribute("testsuites", testsuiteService.findAllList());

			return "success";
		} else {
			return ERROR;
		}

	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
