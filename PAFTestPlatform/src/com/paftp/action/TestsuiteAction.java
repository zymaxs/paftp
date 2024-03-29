package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
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

import com.paftp.dto.TestcaseCountDto;
import com.paftp.dto.TestcaseDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.CaseChangeHistory;
import com.paftp.entity.CaseChangeOperation;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.Testcase;
import com.paftp.entity.TestcaseProject;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.Version;
import com.paftp.service.CaseChangeHistory.CaseChangeHistoryService;
import com.paftp.service.CaseChangeOperation.CaseChangeOperationService;
import com.paftp.service.StaticColumn.TestcaseProjectService;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.user.UserService;
import com.paftp.service.version.VersionService;
import com.paftp.util.CompareObjects;
import com.paftp.util.CompareTestsuiteName;
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
	private String changetag;
	private Integer testcase_execount;

	private Testcase testcase;
	private Testsuite testsuite;
	private HashMap<String, Integer> testcase_count;
	private HashMap<String, List<TestcaseCountDto>> condtestcase_quantity;

	private Util util = new Util();

	@SuppressWarnings("static-access")
	public String createTestsuite() {

		user = getSessionUser();
		if (user == null) {
			this.setPrompt("请登录后进行操作");
			return "success";
		}
		if (this.isRoleOfSut(user) == false) {
			this.setPrompt("You has not authority to work under this group!");
			return "success";
		}

		Sut sut = sutService.findSutByName(this.getSut_name());
		if (sut != null) {

			Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
					this.getTestsuite_name(), sut.getId());
			if (testsuite != null) {
				this.setPrompt("The testsuite already exist!");
				return "success";
			}

			testsuite = new Testsuite();
			testsuite.setName(this.getTestsuite_name());
			Version currentversion = versionService
					.findVersionByVersionNum(this.getVersion());
			testsuite.setVersion(currentversion);
			testsuite.setSut(sut);
			testsuite.setStatus(this.getIsdiscard());
			this.setTestsuite_description(util.full2HalfChange(this.getTestsuite_description()));
			testsuite.setDescription(this.getTestsuite_description());
			testsuite.setChangetag(0);

			testsuiteService.saveTestsuite(testsuite);

			JSONArray jsonarray = this.getRootNode(this.getSut_name(), null);
			this.setJsonArray(jsonarray);
		} else {
			this.setPrompt("The sut" + this.getSut_name() + "is not exist!");
		}

		return "success";

	}

	public String queryTestsuite() {

		Sut sut = sutService.findSutByName(this.getSut_name());
		if (sut != null) {

			Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
					this.getTestsuite_name(), sut.getId());

			if (testsuite != null) {

				this.setChangetag(testsuite.getChangetag().toString());
				HashMap<String, Object> conditions = new HashMap<String, Object>();
				conditions.put("status", this.getStatus());
				conditions.put("priority", this.getPriority());
				conditions.put("casetype", this.getCasetype());
				conditions
						.put("testcase_approval", this.getTestcase_approval());
				conditions.put("testsuite.id", testsuite.getId());
				List<Testcase> testcases = testcaseService
						.findAllCaseByMultiConditions(conditions);
				Integer testcasenum = testcases.size();

				this.setTestcase_quantity(testcasenum);
				TestsuiteDto testsuitedto = testsuiteService
						.getTestsuiteDto(testsuite);
				this.setTestsuitedto(testsuitedto);
				this.queryQuantitys(testsuite);
			} else {
				this.setPrompt("The testsuite" + this.getTestsuite_name()
						+ "is not exist!");
			}
		} else {
			this.setPrompt("The sut" + this.getSut_name() + "is not exist!");
		}

		return "success";
	}

	@SuppressWarnings("static-access")
	public String updateTestsuite() {

		user = getSessionUser();
		if (user == null) {
			this.setPrompt("请登录后进行操作");
			return "success";
		}
		if (this.isRoleOfSut(user) == false) {
			this.setPrompt("You has not authority to work under this group!");
			return "success";
		}

		Testsuite testsuite = testsuiteService.findTestsuiteById(this
				.getTestsuite_id());
		Version version = versionService.findVersionByVersionNum(this
				.getVersion());
		String sourceName = testsuite.getName();
		String targetName = this.getTestsuite_name();
		Testsuite temp_testsuite = testsuiteService
				.findTestsuiteByNameAndSutid(targetName, testsuite.getSut()
						.getId());
		if (temp_testsuite != null
				&& testsuite.getId() != temp_testsuite.getId()) {
			this.setPrompt("The testsuite of " + temp_testsuite.getName()
					+ " has been exist!");
			return "success";
		}
		sourceName = sourceName.replaceAll("Ts", "Tc");
		targetName = targetName.replaceAll("Ts", "Tc");

		this.setTestsuite_description(util.full2HalfChange(this.getTestsuite_description()));
		testsuite.setDescription(this.getTestsuite_description());
		testsuite.setName(this.getTestsuite_name());
		testsuite.setStatus(this.getIsdiscard());
		testsuite.setVersion(version);
		if (testsuite.getChangetag().toString().equals(this.getChangetag()) == false) {
			this.setPrompt("This testsuite has been changed and please refreh before modifying it!");
			return "success";
		}
		Integer temp_changetag = testsuite.getChangetag() + 1;
		testsuite.setChangetag(temp_changetag);
		testsuiteService.updateTestsuite(testsuite);

		if (this.getIsdiscard().equals("discard")) {
			this.updateTestcaseSpecial(testsuite, "0", sourceName, targetName);
		}

		if (sourceName != null
				&& sourceName.equals(this.getTestsuite_name()) == false) {
			this.updateTestcaseSpecial(testsuite, "1", sourceName, targetName);
		}

		return "success";

	}

	@SuppressWarnings("static-access")
	public String createTestcase() {

		user = getSessionUser();

		if (user == null) {
			this.setPrompt("请登录后进行操作");
			return "success";
		}
		if (this.isRoleOfSut(user) == false) {
			this.setPrompt("You has not authority to work under this group!");
			return "success";
		}

		Sut sut = sutService.findSutByName(this.getSut_name());
		if (sut != null) {

			Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
					this.getTestsuite_name(), sut.getId());
			if (testsuite != null) {

				if (testsuite.getStatus().equals("discard")) {
					testsuite.setStatus("using");
					testsuiteService.updateTestsuite(testsuite);
				}

				Testcase testcase = new Testcase();
				testcase.setCaseName(this.getTestcase_name());
				this.setDescription(util.full2HalfChange(this.getDescription()));
				testcase.setDescription(this.getDescription());
				testcase.setPriority(this.getPriority());
				testcase.setStatus(this.getStatus());
				testcase.setTestcase_approval(this.getTestcase_approval());
				testcase.setApproval_comments(this.getApproval_comments());
				Version version = versionService.findVersionByVersionNum(this.getVersion());
				testcase.setVersion(version);
				testcase.setCasetype(this.getCasetype());
				this.setCasesteps(util.full2HalfChange(this.getCasesteps()));
				testcase.setCasesteps(this.getCasesteps());
				testcase.setChangetag(0);
				testcase.setCreator(user);
				this.createtime = new Date();
				java.sql.Timestamp createdatetime = new java.sql.Timestamp(
						createtime.getTime());
				testcase.setCreateTime(createdatetime);
				testcase.setTestsuite(testsuite);
				TestcaseProject testcaseproject = testcaseProjectService
						.findTestcaseProjectByName(this.getProject_name());
				testcase.setTestcaseproject(testcaseproject);

				Testcase judgetestcase = testcaseService
						.findTestcaseByNameAndTestsuiteid(
								this.getTestcase_name(), testsuite.getId());
				if (judgetestcase != null) {
					this.setPrompt("The testcase already exist!");
					return "success";
				}

				testcaseService.saveTestcase(testcase);

			} else {
				this.setPrompt("The testsuite" + this.getTestsuite_name()
						+ "is not exist!");
			}
		} else {
			this.setPrompt("The sut" + this.getSut_name() + "is not exist!");
		}

		return "success";
	}

	public String queryTestcase() {

		user = this.getSessionUser();

		Sut sut = sutService.findSutByName(this.getSut_name());
		if (sut != null) {

			Testsuite testsuite = testsuiteService.findTestsuiteByNameAndSutid(
					this.getTestsuite_name(), sut.getId());
			if (testsuite != null) {

				Testcase testcase = testcaseService
						.findTestcaseByNameAndTestsuiteid(
								this.getTestcase_name(), testsuite.getId());
				if (testcase != null) {

					this.setChangetag(testcase.getChangetag().toString());
					List<CaseChangeHistory> casechangehistories_source = casechangehistoryService.findAllListByTestcaseId(testcase.getId());
					this.setTestcasedto(testsuiteService
							.getTestcaseDto(testcase, casechangehistories_source));
					if (user != null
							&& user.getAlias().equals(
									testcase.getCreator().getAlias()) == true) {
						this.setIsSelf("true");
					} else {
						this.setIsSelf("false");
					}
					
					this.setTestcase_execount(testcase.getTestcase_results().size());
				} else {
					this.setPrompt("The testcase " + this.getTestcase_name()
							+ " is not exist!");
				}
			} else {
				this.setPrompt("The testsuite" + this.getTestsuite_name()
						+ "is not exist!");
			}
		} else {
			this.setPrompt("The sut" + this.getSut_name() + "is not exist!");
		}

		return "success";
	}

	public String updateTestcase() {

		user = getSessionUser();
		if (user == null) {
			this.setPrompt("请登录后进行操作");
			return "success";
		}
		if (this.isRoleOfSut(user) == false) {
			this.setPrompt("You has not authority to work under this group!");
			return "success";
		}

		Testcase testcase = testcaseService.findTestcaseById(this
				.getTestcase_id());
		if (testcase == null) {
			this.setPrompt("The testcase is not exist!");
			return "success";
		}
		Testcase temp_testcase = testcaseService
				.findTestcaseByNameAndTestsuiteid(this.getTestcase_name(),
						testcase.getTestsuite().getId());
		if (testcase.getCaseName().equals(this.getTestcase_name()) == false
				&& temp_testcase != null) {
			this.setPrompt("The new testcase name is already exist!");
			return "success";
		}
		Integer sourcechangetag = testcase.getChangetag();

		CaseChangeHistory casechangehistory = new CaseChangeHistory();
		casechangehistory.setUpdator(user);
		casechangehistory.setTestcase(testcase);
		this.updatetime = new Date();
		java.sql.Timestamp updatedatetime = new java.sql.Timestamp(
				updatetime.getTime());
		casechangehistory.setUpdate_time(updatedatetime);

		Boolean result = this.updateTestcaseHistorys(user, testcase,
				casechangehistory, sourcechangetag);
		if (result == false) {
			this.setPrompt("Someone has changed this case!");
		}

		return "success";
	}

	private void updateTestcaseSpecial(Testsuite testsuite, String tag,
			String sourceName, String targetName) {

		List<Testcase> testcases = testsuite.getTestcases();

		if (testcases != null) {
			if (tag.equals("0")) {
				for (int i = 0; i < testcases.size(); i++) {
					this.updateTestcaseHistory(testcases.get(i),
							testcases.get(i).getStatus(), "废弃", "状态");
					testcases.get(i).setStatus("废弃");
					testcases.get(i).setTestcase_approval("待评审");
					testcases.get(i).setChangetag(testcases.get(i).getChangetag()+1);
					testcaseService.updateTestcase(testcases.get(i));
				}
			} else {
				for (int i = 0; i < testcases.size(); i++) {
					String caseName = testcases.get(i).getCaseName()
							.replaceAll(sourceName, targetName);
					this.updateTestcaseHistory(testcases.get(i),
							testcases.get(i).getCaseName(), caseName, "用例名");
					testcases.get(i).setCaseName(caseName);
					if(testcases.get(i).getTestcase_approval().equals("待评审") == false){
						testcases.get(i).setTestcase_approval("待评审");
					}
					testcases.get(i).setChangetag(testcases.get(i).getChangetag()+1);
					testcaseService.updateTestcase(testcases.get(i));
				}
			}
		}
	}

	@SuppressWarnings("static-access")
	private Boolean updateTestcaseHistorys(User user, Testcase testcase,
			CaseChangeHistory casechangehistory, Integer changetag) {

//		casechangehistoryService.saveCaseChangeHistory(casechangehistory);
		int i = 0;
		List<CaseChangeOperation> casechangeoperations = new ArrayList<CaseChangeOperation>();
		if (testcase.getCaseName().equals(this.getTestcase_name()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCaseName());
			casechangeoperation.setNewValue(this.getTestcase_name());
			casechangeoperation.setField("用例名");
			casechangeoperations.add(casechangeoperation);
			testcase.setCaseName(this.getTestcase_name());
			i++;
		}

		if (testcase.getPriority().equals(this.getPriority()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getPriority());
			casechangeoperation.setNewValue(this.getPriority());
			casechangeoperation.setField("优先级");
			casechangeoperations.add(casechangeoperation);
			testcase.setPriority(this.getPriority());
			i++;
		}

		if (testcase.getStatus().equals(this.getStatus()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getStatus());
			casechangeoperation.setNewValue(this.getStatus());
			casechangeoperation.setField("状态");
			casechangeoperations.add(casechangeoperation);
			testcase.setStatus(this.getStatus());
			i++;
		}

	

		if (testcase.getCasetype().equals(this.getCasetype()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCasetype());
			casechangeoperation.setNewValue(this.getCasetype());
			casechangeoperation.setField("用例类型");
			casechangeoperations.add(casechangeoperation);
			testcase.setCasetype(this.getCasetype());
			i++;
		}

		if (testcase.getVersion() != null && testcase.getVersion().getVersionNum().equals(this.getVersion()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getVersion().getVersionNum());
			casechangeoperation.setNewValue(this.getVersion());
			casechangeoperation.setField("用例版本");
			casechangeoperations.add(casechangeoperation);
			Version version = versionService.findVersionByVersionNum(this.getVersion());
			testcase.setVersion(version);
			i++;
		}
		

		if (testcase.getTestcase_approval().equals(this.getTestcase_approval()) == false) {
			if (user.getAlias().equals(testcase.getCreator().getAlias()) == false) {
				CaseChangeOperation casechangeoperation = new CaseChangeOperation();
				casechangeoperation.setCaseChangeHistory(casechangehistory);
				casechangeoperation
						.setOldValue(testcase.getTestcase_approval());
				casechangeoperation.setNewValue(this.getTestcase_approval());
				casechangeoperation.setField("审批状态");
				casechangeoperations.add(casechangeoperation);
				testcase.setTestcase_approval(this.getTestcase_approval());
				i++;
				
				if(this.getTestcase_approval().equals("未通过")){
					CaseChangeOperation casechangeoperation_comment = new CaseChangeOperation();
					casechangeoperation_comment.setCaseChangeHistory(casechangehistory);
					casechangeoperation_comment
							.setOldValue("");
					casechangeoperation_comment.setNewValue(this.getApproval_comments());
					casechangeoperation_comment.setField("审批建议");
					casechangeoperations.add(casechangeoperation_comment);
					testcase.setApproval_comments(this.getApproval_comments());
					i++;
				}
			}
		} else if (testcase.getTestcase_approval().equals("未通过") == true && this.getApproval_comments() != null && this.getApproval_comments().equals(testcase.getApproval_comments()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getApproval_comments());
			casechangeoperation.setNewValue(this.getApproval_comments());
			casechangeoperation.setField("审批建议");
			casechangeoperations.add(casechangeoperation);
			testcase.setApproval_comments(this.getApproval_comments());
			i++;
		}

		if (testcase.getTestcaseproject().getName()
				.equals(this.getProject_name()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getTestcaseproject()
					.getName());
			casechangeoperation.setNewValue(this.getProject_name());
			casechangeoperation.setField("所属项目");
			casechangeoperations.add(casechangeoperation);
			TestcaseProject testcaseproject = testcaseProjectService
					.findTestcaseProjectByName(this.getProject_name());
			testcase.setTestcaseproject(testcaseproject);
			i++;
		}
		
		this.setDescription(util.full2HalfChange(this.getDescription()));
		if (testcase.getDescription().equals(this.getDescription()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getDescription());
			casechangeoperation.setNewValue(this.getDescription());
			casechangeoperation.setField("描述");
			casechangeoperations.add(casechangeoperation);
			testcase.setDescription(this.getDescription());
			testcase.setTestcase_approval("待评审");
			i++;

		}

		this.setCasesteps(util.full2HalfChange(this.getCasesteps()));
		if (testcase.getCasesteps().equals(this.getCasesteps()) == false) {
			CaseChangeOperation casechangeoperation = new CaseChangeOperation();
			casechangeoperation.setCaseChangeHistory(casechangehistory);
			casechangeoperation.setOldValue(testcase.getCasesteps());
			casechangeoperation.setNewValue(this.getCasesteps());
			casechangeoperation.setField("用例步骤");
			casechangeoperations.add(casechangeoperation);
			testcase.setCasesteps(this.getCasesteps());
			testcase.setTestcase_approval("待评审");
			i++;
		}
		
		Testcase checktestcase = testcaseService.findTestcaseById(testcase
				.getId());
		Integer targetchangetag = checktestcase.getChangetag();
		if (changetag != targetchangetag
				|| targetchangetag.toString().equals(this.getChangetag()) == false) {
			return false;
		} else {
			if (i > 0){
			Integer temp_changetag = testcase.getChangetag() + 1;
			testcase.setChangetag(temp_changetag);
			testcaseService.updateTestcase(testcase);
			casechangehistoryService.saveCaseChangeHistory(casechangehistory);
			for (int j = 0; j < i; j++) {
				casechangeoperationService
						.saveCaseChangeOperation(casechangeoperations.get(j));
			}
			}
			return true;
		}
	}

	public String queryCombineConditions() {

		List<Testsuite> testsuite_results = new ArrayList<Testsuite>();
		
		Sut sut = sutService.findSutByName(this.getSut_name());
		
		List<Testsuite> testsuites = null;
//		if (this.getVersion() != null){
//			testsuites = testsuiteService.findTestsuiteByVersionAndSutid(this.getVersion(), sut.getId());
//		} else {
			testsuites = sut.getTestsuites();
//		}
		
		Integer testcasenum = 0;

		for (int i = 0; i < testsuites.size(); i++) {

			Testsuite testsuite = testsuites.get(i);
			TestcaseProject testcaseproject = testcaseProjectService
					.findTestcaseProjectByName(this.getProject_name());
			Version version = versionService.findVersionByVersionNum(this.getVersion());

			HashMap<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("status", this.getStatus());
			conditions.put("priority", this.getPriority());
			conditions.put("casetype", this.getCasetype());
			conditions.put("testcase_approval", this.getTestcase_approval());
			if (testcaseproject != null) {
				conditions.put("testcaseproject.id", testcaseproject.getId());
			}
			conditions.put("testsuite.id", testsuite.getId());
			if (version != null){
				conditions.put("version.id", version.getId());
			}
			List<Testcase> testcases = testcaseService
					.findAllCaseByMultiConditions(conditions);
			
			if (testcases.size() > 0){
				Testsuite testsuite_result = new Testsuite();
				List<Testcase> testcase_results = new ArrayList<Testcase>();
				for (int j = 0; j< testcases.size(); j++){
					Testcase testcase_result = testcases.get(j);
					testcase_results.add(testcase_result);
				}
				testsuite_result.setTestcases(testcase_results);
				testsuite_result.setId(testsuite.getId());
				testsuite_result.setName(testsuite.getName());
				testsuite_results.add(testsuite_result);
			}

			testcasenum += testcases.size();
		}

		this.setTestcase_quantity(testcasenum);
		this.setJsonArray(this.getRootNode(this.getSut_name(), testsuite_results));

		return "success";
	}

	public String initialParameters() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();
		if (user != null) {
			request.setAttribute("isCurrentRole", this.isRoleOfSut(user));
		}
		
		//Sut sut = sutService.findSutByName(this.getSut_name());
		if (this.getSut_id() != null){
		Sut sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
		request.setAttribute("sut", sut);
		} else {
			request.setAttribute("error", "The sut is null!");
			return "error";
		}
		request.setAttribute("flag", false);

		return "success";

	}

	public String initialTestsuites() throws ServletException, IOException {

		this.setJsonArray(this.getRootNode(this.getSut_name(), null));

		return "success";

	}

	public String querySutQuantitys() {

		this.queryQuantitys(null);

		return "success";
	}

	private void queryQuantitys(Testsuite testsuite) {

		if (testsuite == null) {
			Sut sut = sutService.findSutByName(this.getSut_name());
			Version version = versionService.findVersionByVersionNum(this
					.getVersion());
			HashMap<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("status", this.getStatus());
			if (version != null) {
				conditions.put("version_id", version.getId());
			}
			conditions.put("sut.id", sut.getId());
			List<Testsuite> testsuites = testsuiteService
					.findAllSuiteByMultiConditions(conditions);

			Integer testcase_quantity = 0;
			if (testsuites != null) {
				testsuite_quantity = testsuites.size();
			}
			testcase_count = new HashMap<String, Integer>();
			for (int i = 0; i < testsuites.size(); i++) {
				List<Testcase> testcases = testsuites.get(i).getTestcases();
				if (testcases != null) {
					testcase_count.put(testsuites.get(i).getName(),
							testcases.size());
					testcase_quantity += testcases.size();
				}

			}

			this.setTestsuite_quantity(testsuites.size());
			this.setTestcase_quantity(testcase_quantity);
			this.setTestcase_count(testcase_count); // The quantity for every
													// case

			condtestcase_quantity = new HashMap<String, List<TestcaseCountDto>>();
			List<TestcaseCountDto> condstatus = new ArrayList<TestcaseCountDto>();
			List<TestcaseCountDto> condpriority = new ArrayList<TestcaseCountDto>();
			List<TestcaseCountDto> condcasetype = new ArrayList<TestcaseCountDto>();
			List<TestcaseCountDto> condtestcase_approval = new ArrayList<TestcaseCountDto>();
			if (testsuites.size() > 0) {
				condstatus = this.transferFromDBObject(testcaseService
						.queryCountByStatusAndTestsuiteid(testsuites.get(0)
								.getId()));
				condpriority = this.transferFromDBObject(testcaseService
						.queryCountByPriorityAndTestsuiteid(testsuites.get(0)
								.getId()));
				condcasetype = this.transferFromDBObject(testcaseService
						.queryCountByCasetypeAndTestsuiteid(testsuites.get(0)
								.getId()));
				condtestcase_approval = this
						.transferFromDBObject(testcaseService
								.queryCountByApprovalAndTestsuiteid(testsuites
										.get(0).getId()));
				for (int i = 1; i < testsuites.size(); i++) {
					List<TestcaseCountDto> tempStatus = this
							.transferFromDBObject(testcaseService
									.queryCountByStatusAndTestsuiteid(testsuites
											.get(i).getId()));
					List<TestcaseCountDto> tempPriority = this
							.transferFromDBObject(testcaseService
									.queryCountByPriorityAndTestsuiteid(testsuites
											.get(i).getId()));
					List<TestcaseCountDto> tempCasetype = this
							.transferFromDBObject(testcaseService
									.queryCountByCasetypeAndTestsuiteid(testsuites
											.get(i).getId()));
					List<TestcaseCountDto> tempTestcase_approval = this
							.transferFromDBObject(testcaseService
									.queryCountByApprovalAndTestsuiteid(testsuites
											.get(i).getId()));
					for (int j = 0; j < tempStatus.size(); j++) {
						int k;
						for (k = 0; k < condstatus.size(); k++) {
							if (tempStatus.get(j).getValue()
									.equals(condstatus.get(k).getValue())) {
								condstatus.get(k).setCount(
										condstatus.get(k).getCount()
												+ tempStatus.get(j).getCount());
								break;
							}
						}
						if (k == condstatus.size()) {
							condstatus.add(tempStatus.get(j));
						}
					}

					for (int j = 0; j < tempPriority.size(); j++) {
						int k;
						for (k = 0; k < condpriority.size(); k++) {
							if (tempPriority.get(j).getValue()
									.equals(condpriority.get(k).getValue())) {
								condpriority.get(k).setCount(
										condpriority.get(k).getCount()
												+ tempPriority.get(j)
														.getCount());
								break;
							}
						}
						if (k == condpriority.size()) {
							condpriority.add(tempPriority.get(j));
						}
					}

					for (int j = 0; j < tempCasetype.size(); j++) {
						int k;
						for (k = 0; k < condcasetype.size(); k++) {
							if (tempCasetype.get(j).getValue()
									.equals(condcasetype.get(k).getValue())) {
								condcasetype.get(k).setCount(
										condcasetype.get(k).getCount()
												+ tempCasetype.get(j)
														.getCount());
								break;
							}
						}
						if (k == condcasetype.size()) {
							condcasetype.add(tempCasetype.get(j));
						}
					}

					for (int j = 0; j < tempTestcase_approval.size(); j++) {
						int k;
						for (k = 0; k < condtestcase_approval.size(); k++) {
							if (tempTestcase_approval
									.get(j)
									.getValue()
									.equals(condtestcase_approval.get(k)
											.getValue())) {
								condtestcase_approval.get(k).setCount(
										condtestcase_approval.get(k).getCount()
												+ tempTestcase_approval.get(j)
														.getCount());
								break;
							}
						}
						if (k == condtestcase_approval.size()) {
							condtestcase_approval.add(tempTestcase_approval
									.get(j));
						}
					}
				}
				condtestcase_quantity.put("status", condstatus);
				condtestcase_quantity.put("priority", condpriority);
				condtestcase_quantity.put("casetype", condcasetype);
				condtestcase_quantity.put("testcase_approval",
						condtestcase_approval);
			}
		} else {

			Integer testcase_quantity = 0;
			if (testsuite != null && testsuite.getTestcases() != null) {
				testcase_quantity = testsuite.getTestcases().size();
			}
			condtestcase_quantity = new HashMap<String, List<TestcaseCountDto>>();
			List<TestcaseCountDto> condstatus = this
					.transferFromDBObject(testcaseService
							.queryCountByStatusAndTestsuiteid(testsuite.getId()));
			condtestcase_quantity.put("status", condstatus);
			List<TestcaseCountDto> condpriority = this
					.transferFromDBObject(testcaseService
							.queryCountByPriorityAndTestsuiteid(testsuite
									.getId()));
			condtestcase_quantity.put("priority", condpriority);
			List<TestcaseCountDto> condcasetype = this
					.transferFromDBObject(testcaseService
							.queryCountByCasetypeAndTestsuiteid(testsuite
									.getId()));
			condtestcase_quantity.put("casetype", condcasetype);
			List<TestcaseCountDto> condtestcase_approval = this
					.transferFromDBObject(testcaseService
							.queryCountByApprovalAndTestsuiteid(testsuite
									.getId()));
			condtestcase_quantity.put("testcase_approval",
					condtestcase_approval);

			// condtestcase_quantity.get("status");

			this.setTestcase_quantity(testcase_quantity);
		}

		this.setCondtestcase_quantity(condtestcase_quantity);

	}

	private List<TestcaseCountDto> transferFromDBObject(List list) {

		List<TestcaseCountDto> lists = new ArrayList<TestcaseCountDto>();

		if (list == null) {
			return lists;
		}

		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			TestcaseCountDto testcaseCountDto = new TestcaseCountDto();
			testcaseCountDto.setValue(obj[0].toString());
			testcaseCountDto.setCount(Integer.parseInt(obj[1] + ""));
			lists.add(testcaseCountDto);
		}

		return lists;
	}

	private Boolean isRoleOfSut(User user) {
		User currentuser = userService.findUserByAlias(user.getAlias());
		List<Role> roles = currentuser.getRoles();
		Sut sut = null;
		if (this.getSut_id() != null){
			sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
		} else {
			if (this.getSut_name() != null){
				sut = sutService.findSutByName(this.getSut_name());
			}
		}
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getSut() != null) {
				if (roles.get(i).getSut().getName().equals(sut.getName())) {
					return true;
				}
			}
		}
		return false;
	}

	private JSONArray getRootNode(String sut_name, List<Testsuite> testsuites) {

		List<Sut> suts = new ArrayList<Sut>();

		Sut sut = sutService.findSutByName(sut_name);
//		Sut sut = sutService.findSutById(Integer.parseInt(sut_id));
		if (sut != null){
			suts.add(sut);
		}
		if (suts.size() == 0){
			return null;
		}
		Boolean tag = false;
		if (testsuites == null){
			tag = true;
		}
		JSONArray parentNode0000 = new JSONArray();
		
		for (int i = 0; i < suts.size(); i++) {
			if (tag){
			testsuites = suts.get(i).getTestsuites();
			testsuites = this.sortTestsuite(testsuites);
			JSONArray parentNode000 = new JSONArray();
			JSONArray parentNode00 = new JSONArray();
			for (int j = 0; j < testsuites.size(); j++) {
				HashMap<String, Object> conditions = new HashMap<String, Object>();
				TestcaseProject testcaseproject = testcaseProjectService
						.findTestcaseProjectByName(this.getProject_name());
				conditions.put("status", this.getStatus());
				conditions.put("priority", this.getPriority());
				conditions.put("casetype", this.getCasetype());
				conditions
						.put("testcase_approval", this.getTestcase_approval());
				if (testcaseproject != null) {
					conditions.put("testcaseproject.id",
							testcaseproject.getId());
				}
				conditions.put("testsuite.id", testsuites.get(j).getId());
				List<Testcase> testcases = testcaseService
						.findAllCaseByMultiConditions(conditions);
				JSONArray parentNode0 = new JSONArray();
				if (testcases != null && testcases.size() > 0) {
					testcases = this.sort(testcases);
					for (int l = 0; l < testcases.size(); l++) {
						JSONObject childNode0 = util.childNode(testcases.get(l)
								.getId(), testcases.get(l).getCaseName(), util
								.nodeType("00"), null);
						parentNode0.add(childNode0);

					}
				}
				JSONObject childNode00 = util.childNode(testsuites.get(j)
						.getId(), testsuites.get(j).getName(), util
						.nodeType("0"), parentNode0);
				parentNode00.add(childNode00);

			}
			JSONObject childNode000 = util.childNode(1, "测试集",
					"interfacetestsuite", parentNode00);
			parentNode000.add(childNode000);
			JSONObject childNode0000 = util.childNode(suts.get(i).getId(), suts
					.get(i).getName(), "sut", parentNode000);
			parentNode0000.add(childNode0000);
		} else {
			testsuites = this.sortTestsuite(testsuites);
			JSONArray parentNode000 = new JSONArray();
			JSONArray parentNode00 = new JSONArray();
			for (int j = 0; j < testsuites.size(); j++) {
				List<Testcase> testcases = testsuites.get(j).getTestcases();
				
				JSONArray parentNode0 = new JSONArray();
				if (testcases != null && testcases.size() > 0) {
					testcases = this.sort(testcases);
					for (int l = 0; l < testcases.size(); l++) {
						JSONObject childNode0 = util.childNode(testcases.get(l)
								.getId(), testcases.get(l).getCaseName(), util
								.nodeType("00"), null);
						parentNode0.add(childNode0);

					}
				}
				JSONObject childNode00 = util.childNode(testsuites.get(j)
						.getId(), testsuites.get(j).getName(), util
						.nodeType("0"), parentNode0);
				parentNode00.add(childNode00);
			}
			JSONObject childNode000 = util.childNode(1, "测试集",
					"interfacetestsuite", parentNode00);
			parentNode000.add(childNode000);
			JSONObject childNode0000 = util.childNode(suts.get(i).getId(), suts
					.get(i).getName(), "sut", parentNode000);
			parentNode0000.add(childNode0000);
		}
	}

		return parentNode0000;
	}

	private List<Testcase> sort(List<Testcase> testcases) {

		CompareObjects compare = new CompareObjects();
		Collections.sort(testcases, compare);
		return testcases;
	}
	
	private List<Testsuite> sortTestsuite(List<Testsuite> testsuites) {

		CompareTestsuiteName compare = new CompareTestsuiteName();
		Collections.sort(testsuites, compare);
		return testsuites;
	}

	private void updateTestcaseHistory(Testcase testcase, String oldValue,
			String newValue, String field) {

		CaseChangeHistory casechangehistory = new CaseChangeHistory();
		casechangehistory.setUpdator(user);
		casechangehistory.setTestcase(testcase);
		this.updatetime = new Date();
		java.sql.Timestamp updatedatetime = new java.sql.Timestamp(
				updatetime.getTime());
		casechangehistory.setUpdate_time(updatedatetime);

		if(testcase.getTestcase_approval().equals("待评审") == false || (newValue != null && oldValue.equals(newValue) == false)){
		casechangehistoryService.saveCaseChangeHistory(casechangehistory);
		}
		
		CaseChangeOperation casechangeoperation = new CaseChangeOperation();

		if(testcase.getTestcase_approval().equals("待评审") == false){
		casechangeoperation.setCaseChangeHistory(casechangehistory);
		casechangeoperation.setOldValue(testcase.getTestcase_approval());
		casechangeoperation.setNewValue("待评审");
		casechangeoperation.setField("审批状态");
		casechangeoperationService.saveCaseChangeOperation(casechangeoperation);
		}
		
		if (newValue != null && oldValue.equals(newValue) == false){
		casechangeoperation = new CaseChangeOperation();
		casechangeoperation.setCaseChangeHistory(casechangehistory);
		casechangeoperation.setOldValue(oldValue);
		casechangeoperation.setNewValue(newValue);
		casechangeoperation.setField(field);
		casechangeoperationService.saveCaseChangeOperation(casechangeoperation);
		}
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

	public String getChangetag() {
		return changetag;
	}

	public void setChangetag(String changetag) {
		this.changetag = changetag;
	}

	public Integer getTestcase_execount() {
		return testcase_execount;
	}

	public void setTestcase_execount(Integer testcase_execount) {
		this.testcase_execount = testcase_execount;
	}

}
