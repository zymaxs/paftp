package com.paftp.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.TestpassDto;
import com.paftp.entity.Sut;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testpass;
import com.paftp.entity.TestsuiteResult;
import com.paftp.entity.User;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.Testpass.TestpassService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

@Controller
public class TestpassAction extends ActionSupport {

	/**
	 * 
	 */
	@Resource
	private TestpassService testpassService;
	@Resource
	private SutService sutService;
	@Resource
	private UserService userService;
	@Resource 
	private TestcaseResultService testcaseresultService;

	private String sut_id;
	private String sut_name;
	private Integer testpass_id;
	private String tag;
	
	private User user;
	private String pagenum;
	private Integer row;
	private Long pages;
	
	private String prompt;
	
	List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();

	private Util util = new Util();

	private static final long serialVersionUID = -1539739561518693848L;

	public String initialTestpasses() {

		HttpServletRequest request = ServletActionContext.getRequest();
		user = util.getSessionUser();

		if (this.getSut_id() != null) {
			Sut sut = sutService
					.findSutById(Integer.parseInt(this.getSut_id()));
			request.setAttribute("sut", sut);

			if (sut != null) {
				List<Testpass> testpasses = sut.getTestpasses();
				List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();
				
				if (this.getRow() == null)
					this.setRow(10);

				if (testpasses.size() > 0) {
					this.setPages((long) Math.ceil(testpasses.size() / (double) this.getRow()));
				} else {
					this.setPages((long) 1);
				}
				
				Integer start = (Integer.parseInt(this.getPagenum()) - 1) * 10;
				Integer end = Integer.parseInt(this.getPagenum()) * 10;
			
				for(int i = start ; i<end; i++){
					Integer testcaseresultpass_quantity = 0;
					HashMap<String, Integer> testcaseresult_passcounts = new HashMap<String, Integer>();
					Integer testcaseresultfail_quantity = 0;
					HashMap<String, Integer> testcaseresult_failcounts = new HashMap<String, Integer>();
				
					List<TestsuiteResult> testsuite_results = testpasses.get(i).getTestsuite_results();
					for (int j=0; j<testsuite_results.size(); j++){
						HashMap<String, Object> conditions = new HashMap<String, Object>();
						
						conditions.put("testsuiteresult_id", testsuite_results.get(j).getId());
						conditions.put("ispass", true);
						List<TestcaseResult> testcase_results = testcaseresultService.findAllCaseresultByMultiConditions(conditions);
						testcaseresult_passcounts.put(testsuite_results.get(j).getSuitename(), testcase_results.size());
						testcaseresultpass_quantity += testcase_results.size();
						
						conditions.remove("ispass");
						conditions.put("ispass", false);
						testcase_results = testcaseresultService.findAllCaseresultByMultiConditions(conditions);
						testcaseresult_failcounts.put(testsuite_results.get(j).getSuitename(), testcase_results.size());
						testcaseresultfail_quantity += testcase_results.size();
					}
					
					Float percentage = (float) (testcaseresultpass_quantity / (testcaseresultpass_quantity + testcaseresultfail_quantity));
					
					TestpassDto testpassDto = testpassService.getTestpassDto(testpasses.get(i), testcaseresultpass_quantity, testcaseresultfail_quantity, percentage);
					testpassdots.add(testpassDto);
				}
				
				this.setTestpassdots(testpassdots);
				
			} else {
				this.setPrompt("The sut is not exist!");
			}
		} else {
			this.setPrompt("Please let me konw which sut you want to query!");
		}

		return "success";
	}

	public String updateTestpass() {

		user = util.getSessionUser();

		if (user == null ) {
			this.setPrompt("Please log in firstly!");
			return "success";
		}
		if (util.isRoleOfSut(user, this.getSut_id(), this.getSut_name()) == false){
			this.setPrompt("You are not the role under this Sut!");
			return "success";
		}

		Testpass testpass = testpassService.findTestpassById(this
				.getTestpass_id());
		testpass.setTag(this.getTag());
		testpassService.updateTestpass(testpass);

		return "success";
	}

	public String getSut_name() {
		return sut_name;
	}

	public void setSut_name(String sut_name) {
		this.sut_name = sut_name;
	}

	public Integer getTestpass_id() {
		return testpass_id;
	}

	public void setTestpass_id(Integer testpass_id) {
		this.testpass_id = testpass_id;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}

	public String getSut_id() {
		return sut_id;
	}

	public void setSut_id(String sut_id) {
		this.sut_id = sut_id;
	}


	public List<TestpassDto> getTestpassdots() {
		return testpassdots;
	}

	public void setTestpassdots(List<TestpassDto> testpassdots) {
		this.testpassdots = testpassdots;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getPagenum() {
		return pagenum;
	}

	public void setPagenum(String pagenum) {
		this.pagenum = pagenum;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

	public Long getPages() {
		return pages;
	}

	public void setPages(Long pages) {
		this.pages = pages;
	}
}
