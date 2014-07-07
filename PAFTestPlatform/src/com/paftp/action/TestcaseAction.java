package com.paftp.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.TestcaseCountDto;
import com.paftp.dto.TestcaseDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.TestcaseProject;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.service.CaseChangeHistory.CaseChangeHistoryService;
import com.paftp.service.CaseChangeOperation.CaseChangeOperationService;
import com.paftp.service.StaticColumn.TestcaseProjectService;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;
import com.paftp.service.version.VersionService;
import com.paftp.util.Util;

@Controller
public class TestcaseAction extends ActionSupport {

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
	@Resource
	private CaseChangeHistoryService casechangehistoryService;
	@Resource
	private CaseChangeOperationService casechangeoperationService;
	@Resource
	private VersionService versionService;
	@Resource
	private TestcaseProjectService testcaseProjectService;

	private String sut_id;
	private String sut_name;
	private String testsuite_name;
	private String testcase_name;
	private String stresstestcase_name;
	private String testsuite_description;
	private Integer testsuite_id;
	private String version;
	private String isdiscard;
	private Integer testsuite_quantity;
	private Integer testcase_quantity;
	private TestsuiteDto testsuitedto;
	private TestcaseDto testcasedto;

	private String priority;
	private String status;
	private String description;
	private String casetype;
	private String casesteps;
	private Date createtime;
	private Date updatetime;
	private String project_name;
	private Integer testcase_id;
	private String testcase_approval;
	private String approval_comments;

	private JSONArray jsonArray;
	private User user;

	private String prompt;
	private String isSelf;

	private Testcase testcase;
	private Testsuite testsuite;
	private HashMap<String, Integer> testcase_count;
	private HashMap<String, List<TestcaseCountDto>> condtestcase_quantity;

	private Util util = new Util();
	
	@SuppressWarnings("unused")
	private List<CaseChangeHistory> queryTestcaseChangehistory(
			String testcasename) {

		Testcase testcase = testcaseService.findTestcaseByName(testcasename);

		List<CaseChangeHistory> casechangehistorys = testcase
				.getCaseChangeHistorys();

		return casechangehistorys;
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

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getCasetype() {
		return casetype;
	}

	public void setCasetype(String casetype) {
		this.casetype = casetype;
	}

	public String getCasesteps() {
		return casesteps;
	}

	public void setCasesteps(String casesteps) {
		this.casesteps = casesteps;
	}

	public String getTestsuite_description() {
		return testsuite_description;
	}

	public void setTestsuite_description(String testsuite_description) {
		this.testsuite_description = testsuite_description;
	}

	public Integer getTestsuite_id() {
		return testsuite_id;
	}

	public void setTestsuite_id(Integer testsuite_id) {
		this.testsuite_id = testsuite_id;
	}

	public Testcase getTestcase() {
		return testcase;
	}

	public void setTestcase(Testcase testcase) {
		this.testcase = testcase;
	}

	public Testsuite getTestsuite() {
		return testsuite;
	}

	public void setTestsuite(Testsuite testsuite) {
		this.testsuite = testsuite;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}

	public Integer getTestcase_id() {
		return testcase_id;
	}

	public void setTestcase_id(Integer testcase_id) {
		this.testcase_id = testcase_id;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getTestcase_approval() {
		return testcase_approval;
	}

	public void setTestcase_approval(String testcase_approval) {
		this.testcase_approval = testcase_approval;
	}

	public Integer getTestcase_quantity() {
		return testcase_quantity;
	}

	public void setTestcase_quantity(Integer testcase_quantity) {
		this.testcase_quantity = testcase_quantity;
	}

	public Integer getTestsuite_quantity() {
		return testsuite_quantity;
	}

	public void setTestsuite_quantity(Integer testsuite_quantity) {
		this.testsuite_quantity = testsuite_quantity;
	}

	public String getIsSelf() {
		return isSelf;
	}

	public void setIsSelf(String isSelf) {
		this.isSelf = isSelf;
	}

	public String getIsdiscard() {
		return isdiscard;
	}

	public void setIsdiscard(String isdiscard) {
		this.isdiscard = isdiscard;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public HashMap<String, Integer> getTestcase_count() {
		return testcase_count;
	}

	public void setTestcase_count(HashMap<String, Integer> testcase_count) {
		this.testcase_count = testcase_count;
	}

	public HashMap<String, List<TestcaseCountDto>> getCondtestcase_quantity() {
		return condtestcase_quantity;
	}

	public void setCondtestcase_quantity(
			HashMap<String, List<TestcaseCountDto>> condtestcase_quantity) {
		this.condtestcase_quantity = condtestcase_quantity;
	}

	public TestsuiteDto getTestsuitedto() {
		return testsuitedto;
	}

	public void setTestsuitedto(TestsuiteDto testsuitedto) {
		this.testsuitedto = testsuitedto;
	}

	public TestcaseDto getTestcasedto() {
		return testcasedto;
	}

	public void setTestcasedto(TestcaseDto testcasedto) {
		this.testcasedto = testcasedto;
	}

	public String getApproval_comments() {
		return approval_comments;
	}

	public void setApproval_comments(String approval_comments) {
		this.approval_comments = approval_comments;
	}

	public String getSut_id() {
		return sut_id;
	}

	public void setSut_id(String sut_id) {
		this.sut_id = sut_id;
	}
}
