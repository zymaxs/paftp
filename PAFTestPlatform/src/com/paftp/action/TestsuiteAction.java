package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.Version;
import com.paftp.service.CaseChangeHistory.CaseChangeHistoryService;
import com.paftp.service.CaseChangeOperation.CaseChangeOperationService;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.user.UserService;
import com.paftp.service.version.VersionService;
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
	@Resource
	private CaseChangeHistoryService casechangehistoryService;
	@Resource
	private CaseChangeOperationService casechangeoperationService;
	@Resource
	private VersionService versionService;
	
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

	private String priority;
	private String status;
	private String description;
	private String casetype;
	private String casesteps;
	private Date createtime;
	private Date updatetime;
	private Integer testcase_id;
	private String testcase_approval;

	private JSONArray jsonArray;
	private User user;

	private String prompt;
	private String isSelf;

	private Testcase testcase;

	private Testsuite testsuite;

	private Util util = new Util();

	public String createTestcase() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			this.setPrompt("Please log in firstly!");
			return "success";
		}

		Sut sut = sutService.findSutByName(this.getSut_name());

		Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
				this.getTestsuite_name(), sut.getId());
		if (testsuite.getStatus().equals("discard")) {
			testsuite.setStatus("alive");
		}
		Testcase testcase = testcaseService.findTestcaseByNameAndTestsuiteid(
				this.getTestcase_name(), testsuite.getId());
		if (testcase != null) {
			this.setPrompt("The testcase already exist!");
			return "success";
		}
		testcase = new Testcase();
		testcase.setCaseName(this.getTestcase_name());
		testcase.setDescription(this.getDescription());
		testcase.setPriority(this.getPriority());
		testcase.setStatus(this.getStatus());
		testcase.setTestcase_approval(this.getTestcase_approval());
		testcase.setCasetype(this.getCasetype());
		testcase.setCasesteps(this.getCasesteps());
		testcase.setCreator(user);
		this.createtime = new Date();
		java.sql.Timestamp createdatetime = new java.sql.Timestamp(
				createtime.getTime());
		testcase.setCreateTime(createdatetime);
		testcase.setTestsuite(testsuite);

		testcaseService.saveTestcase(testcase);

		return "success";

	}

	private Boolean existTestcase(Testsuite testsuite, Integer testcase_id) {

		if (testsuite == null)
			return false;
		List<Testcase> testcases = testsuite.getTestcases();
		for (int i = 0; i < testcases.size(); i++) {
			if (testcases.get(i).getId() == testcase_id)
				return true;
		}

		return false;
	}

	public String updateTestcase() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}

		Testcase testcase = testcaseService.findTestcaseById(this
				.getTestcase_id());

		if (testcase == null) {
			testcase = new Testcase();
		}
		CaseChangeHistory casechangehistory = new CaseChangeHistory();
		casechangehistory.setUpdator(user);
		casechangehistory.setTestcase(testcase);
		this.updatetime = new Date();
		java.sql.Timestamp updatedatetime = new java.sql.Timestamp(
				updatetime.getTime());
		casechangehistory.setUpdate_time(updatedatetime);
		casechangehistoryService.saveCaseChangeHistory(casechangehistory);

		this.updateTestcaseHistory(user, testcase, casechangehistory);

		return "success";
	}

	public String queryTestcase() {
		
		user = this.getSessionUser();

		Testcase testcase = testcaseService.findTestcaseByName(this
				.getTestcase_name());

		if(user.getAlias().equals(testcase.getCreator().getAlias()) == true){
			this.setIsSelf("true");
		}else{
			this.setIsSelf("false");
		}
		
		this.setTestcase(testcase);

		return "success";
	}

	public String queryTestcaseChangehistory() {
		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}

		Testcase testcase = testcaseService.findTestcaseByName(this
				.getTestcase_name());

		List<CaseChangeHistory> casechangehistorys = testcase
				.getCaseChangeHistorys();

		request.setAttribute("casechangehistorys", casechangehistorys);

		return "true";
	}

	// public String deleteTestcase() {
	//
	// HttpServletRequest request = ServletActionContext.getRequest();
	//
	// user = getSessionUser();
	//
	// if (user == null) {
	// request.setAttribute("error", "Please log in firstly!");
	// return "error";
	// }
	//
	// Testcase testcase =
	// testcaseService.findTestcaseByName(this.getTestcase_name());
	//
	// testcaseService.deleteTestcase(testcase);
	//
	// return "success";
	// }

	public String createTestsuite() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		// if (user == null) {
		// request.setAttribute("error", "Please log in firstly!");
		// return "error";
		// }

		Sut sut = sutService.findSutByName(this.getSut_name());

		Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
				this.getTestsuite_name(), sut.getId());
		if (testsuite != null) {
			request.setAttribute("error", "The testsuite already exist!");
			return "error";
		}

		testsuite = new Testsuite();
		testsuite.setName(this.getTestsuite_name());
		Version currentversion = versionService.findVersionByVersionNum(this
				.getVersion());
		testsuite.setVersion(currentversion);
		testsuite.setSut(sut);
		testsuite.setStatus(this.getIsdiscard());
		testsuite.setDescription(this.getTestsuite_description());
		testsuiteService.saveTestsuite(testsuite);
		JSONArray jsonarray = this.getRootNode(this.getSut_name());
		this.setJsonArray(jsonarray);

		return "success";

	}

	public String queryTestsuite() {

		// user = getSessionUser();
		//
		// if (user == null) {
		// request.setAttribute("error", "Please log in firstly!");
		// return "error";
		// }

		Sut sut = sutService.findSutByName(this.getSut_name());

		Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
				this.getTestsuite_name(), sut.getId());

		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("status", this.getStatus());
		conditions.put("priority", this.getPriority());
		conditions.put("casetype", this.getCasetype());
		conditions.put("approval", this.getTestcase_approval());
		conditions.put("testsuite.id", testsuite.getId());
		List<Testcase> testcases = testcaseService
				.findAllCaseByMultiConditions(conditions);

		Integer testcasenum = testcases.size();
		
		this.setTestcase_quantity(testcasenum);
		this.setTestsuite(testsuite);

		return "success";

	}

	public String updateTestsuite() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}

		Testsuite testsuite = testsuiteService.findTestsuiteById(this
				.getTestsuite_id());

		testsuite.setDescription(this.getTestsuite_description());
		testsuite.setName(this.getTestsuite_name());
		testsuite.setStatus(this.getIsdiscard());
		
		Version version = versionService.findVersionByVersionNum(this.getVersion());
		testsuite.setVersion(version);

		if (this.getIsdiscard().equals("discard")) {

			List<Testcase> testcases = testsuite.getTestcases();

			for (int i = 0; i < testcases.size(); i++) {
				testcases.get(i).setStatus("discard");
			}
		}

		testsuiteService.updateTestsuite(testsuite);

		request.setAttribute("testsuite", testsuite);

		return "success";
	}

	// public String deleteTestsuite() {
	//
	// HttpServletRequest request = ServletActionContext.getRequest();
	//
	// user = getSessionUser();
	//
	// if (user == null) {
	// request.setAttribute("error", "Please log in firstly!");
	// return "error";
	// }
	//
	// Testsuite testsuite =
	// testsuiteService.findTestsuiteByName(this.getTestsuite_name());
	//
	// testsuiteService.deleteTestsuite(testsuite);
	//
	// return "success";
	// }

	public String queryTestsuiteQuantity() {

		Sut sut = sutService.findSutByName(this.getSut_name());

		Version version = versionService.findVersionByVersionNum(this
				.getVersion());

		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("status", this.getStatus());
		conditions.put("version_id", version.getId());
		conditions.put("sut_id", sut.getId());
		List<Testsuite> testsuites = testsuiteService
				.findAllSuiteByMultiConditions(conditions);

		this.setTestsuite_quantity(testsuites.size());

		return "success";

	}
	
	public String queryCombineConditions(){
		
		Sut sut = sutService.findSutByName(this.getSut_name());

//		Version version = versionService.findVersionByVersionNum(this
//				.getVersion());
//		HashMap<String, Object> conditions = new HashMap<String, Object>();
//		conditions.put("status", this.getStatus());
//		conditions.put("version_id", version.getId());
//		conditions.put("sut_id", sut.getId());
//		List<Testsuite> testsuites = testsuiteService
//				.findAllSuiteByMultiConditions(conditions);
		
		List<Testsuite> testsuites = sut.getTestsuites();
		Integer testcasenum = 0;
		
		for(int i=0; i<testsuites.size(); i++){
			
		Testsuite testsuite = testsuites.get(i);
		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("status", this.getStatus());
		conditions.put("priority", this.getPriority());
		conditions.put("casetype", this.getCasetype());
		conditions.put("approval", this.getTestcase_approval());
		conditions.put("testsuite.id", testsuite.getId());
		List<Testcase> testcases = testcaseService
				.findAllCaseByMultiConditions(conditions);

		testcasenum += testcases.size();
		
		}
		
		this.setTestcase_quantity(testcasenum);
		
		return "success";
	}

	public String initialParameters() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		request.setAttribute("isCurrentRole",
				this.isRoleOfSut(user, this.getSut_name()));
		request.setAttribute("sut_name", this.getSut_name());
		request.setAttribute("flag", false);

		return "success";

	}

	public String initialTestsuites() throws ServletException, IOException {

		this.setJsonArray(this.getRootNode(this.getSut_name()));

		return "success";

	}

	private Boolean isRoleOfSut(User user, String sut_name) {
		User currentuser = userService.findUserByAlias(user.getAlias());
		List<Role> roles = currentuser.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getSut() != null) {
				if (roles.get(i).getSut().getName().equals(this.getSut_name())) {
					return true;
				}
			}
		}
		return false;
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
				HashMap<String, Object> conditions = new HashMap<String, Object>();
				conditions.put("status", this.getStatus());
				conditions.put("priority", this.getPriority());
				conditions.put("casetype", this.getCasetype());
				conditions.put("approval", this.getTestcase_approval());
				conditions.put("testsuite.id", testsuites.get(j).getId());
				List<Testcase> testcases = testcaseService
						.findAllCaseByMultiConditions(conditions);
				JSONArray parentNode0 = new JSONArray();
				if (testcases != null && testcases.size() > 0) {
					for (int l = 0; l < testcases.size(); l++) {
						JSONObject childNode0 = util.childNode(testcases.get(l)
								.getCaseName(), util.nodeType("00"), null);
						parentNode0.add(childNode0);

					}
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

	private void updateTestcaseHistory(User user, Testcase testcase,
			CaseChangeHistory casechangehistory) {
		int i = 0;
		List<CaseChangeOperation> casechangeoperations = new ArrayList<CaseChangeOperation>();
		if (testcase.getCaseName().equals(this.getTestcase_name()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCaseName());
			casechangeoperation.setNewValue(this.getTestcase_name());
			casechangeoperation.setField("name");
			casechangeoperations.add(casechangeoperation);
			testcase.setCaseName(this.getTestcase_name());
			i++;
		}

		if (testcase.getPriority().equals(this.getPriority()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getPriority());
			casechangeoperation.setNewValue(this.getPriority());
			casechangeoperation.setField("priority");
			casechangeoperations.add(casechangeoperation);
			testcase.setPriority(this.getPriority());
			i++;
		}

		if (testcase.getStatus().equals(this.getStatus()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getStatus());
			casechangeoperation.setNewValue(this.getStatus());
			casechangeoperation.setField("status");
			casechangeoperations.add(casechangeoperation);
			testcase.setStatus(this.getStatus());
			i++;
		}

		if (testcase.getDescription().equals(this.getDescription()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getDescription());
			casechangeoperation.setNewValue(this.getDescription());
			casechangeoperation.setField("description");
			casechangeoperations.add(casechangeoperation);
			testcase.setDescription(this.getDescription());
			i++;
		}

		if (testcase.getCasetype().equals(this.getCasetype()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCasetype());
			casechangeoperation.setNewValue(this.getCasetype());
			casechangeoperation.setField("casetype");
			casechangeoperations.add(casechangeoperation);
			testcase.setCasetype(this.getCasetype());
			i++;
		}

		if (testcase.getCasesteps().equals(this.getCasesteps()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCasesteps());
			casechangeoperation.setNewValue(this.getCasesteps());
			casechangeoperation.setField("casesteps");
			casechangeoperations.add(casechangeoperation);
			testcase.setCasesteps(this.getCasesteps());
			i++;
		}

		if (testcase.getTestcase_approval().equals(this.getTestcase_approval()) == false) {
			if (user.getAlias().equals(testcase.getCreator().getAlias()) == false) {
				CaseChangeOperation casechangeoperation = new CaseChangeOperation();
				casechangeoperation.setCaseChangeHistory(casechangehistory);
				casechangeoperation.setOldValue(testcase.getTestcase_approval());
				casechangeoperation.setNewValue(this.getTestcase_approval());
				casechangeoperation.setField("approval");
				casechangeoperations.add(casechangeoperation);
				testcase.setTestcase_approval(this.getTestcase_approval());
				i++;
			}
		}

		for (int j = 0; j < i; j++) {
			casechangeoperationService
					.saveCaseChangeOperation(casechangeoperations.get(j));
		}
		testcaseService.saveTestcase(testcase);
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


}
