package com.paftp.action;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.TestcaseResultDto;
import com.paftp.dto.TestpassDto;
import com.paftp.dto.TestsuiteDto;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.Sut;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.entity.Testpass;
import com.paftp.entity.Testsuite;
import com.paftp.entity.TestsuiteResult;
import com.paftp.entity.User;
import com.paftp.entity.Version;
import com.paftp.service.AnalyseCommentHistory.AnalyseCommentHistoryService;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.Testpass.TestpassService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;
import com.paftp.service.version.VersionService;
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
	@Resource
	private VersionService versionService;
	@Resource
	private TestsuiteService testsuiteService;
	@Resource
	private TestsuiteResultService testsuiteresultService;
	@Resource
	private AnalyseCommentHistoryService analysecommenthistoryService;

	private String sut_id;
	private String sut_name;
	private Integer testpass_id;
	private String tag;
	private String show_tag;
	private String env;
	private String testset;
	private Integer testsuite_id;
	private Integer testcase_id;
	private Integer testcaseresult_id;

	private String version;
	private User user;
	private String pagenum;
	private Integer row;
	private Long pages;

	private String starttime;
	private String endtime;

	private String prompt;
	private String flag;

	private List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();
	private List<TestcaseResultDto> testcaseresultdtoes = new ArrayList<TestcaseResultDto>();

	private Util util = new Util();

	private static final long serialVersionUID = -1539739561518693848L;

	public String initialTestpasses() throws ParseException {

		HttpServletRequest request = ServletActionContext.getRequest();
		user = util.getSessionUser();
		if (user == null) {
			request.setAttribute("isManager", false);
		} else {
			User currentuser = userService.findUserByAlias(user.getAlias());
			Sut sut = sutService
					.findSutById(Integer.parseInt(this.getSut_id()));
			if (util.isManagerOfSut(currentuser, sut)) {
				request.setAttribute("isManager", true);
			} else {
				request.setAttribute("isManager", false);
			}
		}

		List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();

		if (this.getSut_id() != null) {
			Sut sut = sutService
					.findSutById(Integer.parseInt(this.getSut_id()));
			request.setAttribute("sut", sut);

			if (sut != null) {
				testpassdots = this.getTestpasses(sut);
			} else {
				request.setAttribute("error", "The sut is not exist!");
				request.setAttribute("flag", true);
				return "error";
			}
		} else {
			request.setAttribute("error",
					"Please let me konw which sut you want to query!");
			request.setAttribute("flag", false);
			return "error";
		}

		request.setAttribute("testpassdots", testpassdots);
		request.setAttribute("flag", true);
		request.setAttribute("pages", this.getPages());
		return "success";

	}

	public String queryTestpasses() throws ParseException {

		List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();

		if (this.getSut_id() != null) {
			Sut sut = sutService
					.findSutById(Integer.parseInt(this.getSut_id()));

			if (sut != null) {
				testpassdots = this.getTestpasses(sut);
			} else {
				this.setPrompt("The sut is not exist!");
				return "success";
			}
		} else {
			this.setPrompt("Please let me konw which sut you want to query!");
			return "success";
		}

		this.setTestpassdots(testpassdots);
		return "success";
	}

	public String updateTestpass() throws ParseException {

		user = util.getSessionUser();

		// if (user == null ) {
		// this.setPrompt("Please log in firstly!");
		// return "success";
		// }
		// if (util.isRoleOfSut(user, this.getSut_id(), this.getSut_name()) ==
		// false){
		// this.setPrompt("You are not the role under this Sut!");
		// return "success";
		// }

		Testpass testpass = testpassService.findTestpassById(this
				.getTestpass_id());
		if (this.getShow_tag() == null || this.getShow_tag().equals("")) {
			testpass.setTag(null);
		} else {
			HashMap<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("sut.id", testpass.getSut().getId());
			conditions.put("version.id", testpass.getVersion().getId());
			conditions.put("tag", this.getShow_tag());
			List<Testpass> testpass_temps = testpassService
					.findAllTestpassByMultiConditions(conditions);
			if (testpass_temps.size() == 0) {
				testpass.setTag(this.getShow_tag());
			} else {
				this.setPrompt("次版本已存在该状态 " + this.getShow_tag()
						+ " 的测试用例集，请先移除后再设置!");
				return "success";
			}
		}
		testpassService.updateTestpass(testpass);

		this.queryTestpasses();

		return "success";
	}

	public String querySpecialTestpassContent() {

		HttpServletRequest request = ServletActionContext.getRequest();

		Testpass testpass = testpassService.findTestpassById(this
				.getTestpass_id());

		Integer testcaseresultpass_quantity = 0;
		HashMap<String, Integer> testcaseresult_passcounts = new HashMap<String, Integer>();
		Integer testcaseresultfail_quantity = 0;
		HashMap<String, Integer> testcaseresult_failcounts = new HashMap<String, Integer>();
		Integer testcaseresulttotal_quantity = 0;
		List<TestsuiteDto> testsuitedtoes = new ArrayList<TestsuiteDto>();

		List<TestsuiteResult> testsuite_results = testpass
				.getTestsuite_results();
		for (int j = 0; j < testsuite_results.size(); j++) {
			TestsuiteDto testsuitedto = new TestsuiteDto();
			testsuitedto.setId(testsuite_results.get(j).getTestsuite().getId());
			testsuitedto.setName(testsuite_results.get(j).getSuitename());

			HashMap<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("testsuite_result.id", testsuite_results.get(j)
					.getId());
			conditions.put("ispass", true);
			Integer caseresults_count = testcaseresultService
					.findCountOfCaseresults(conditions);
			testcaseresult_passcounts.put(testsuite_results.get(j)
					.getSuitename(), caseresults_count);
			testsuitedto.setPasscount(caseresults_count);
			testcaseresultpass_quantity += caseresults_count;
			testcaseresulttotal_quantity = caseresults_count;

			conditions.remove("ispass");
			conditions.put("ispass", false);
			caseresults_count = testcaseresultService
					.findCountOfCaseresults(conditions);
			testcaseresult_failcounts.put(testsuite_results.get(j)
					.getSuitename(), caseresults_count);
			testsuitedto.setFailcount(caseresults_count);
			testcaseresultfail_quantity += caseresults_count;
			testcaseresulttotal_quantity += caseresults_count;

			testsuitedto.setTotal(testcaseresulttotal_quantity);
			testsuitedtoes.add(testsuitedto);
		}

		Integer total = testcaseresultpass_quantity
				+ testcaseresultfail_quantity;
		Float percentage = (float) testcaseresultpass_quantity / (float) total;
		Float percentage_foursets = (float) (Math.round(percentage * 10000)) / 10000;

		TestpassDto testpassDto = testpassService.getTestpassDto(testpass,
				testcaseresultpass_quantity, testcaseresultfail_quantity,
				total, percentage_foursets);

		request.setAttribute("testpassdto", testpassDto);
		request.setAttribute("testsuitedtoes", testsuitedtoes);
		request.setAttribute("flag", true);

		return "success";
	}

	public String querySpecialTestsuiteResultContent() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getTestsuite_id() != null
				&& this.getTestsuite_id().equals("") == false) {
			if (this.getTestpass_id() != null
					&& this.getTestpass_id().equals("") == false) {

				HashMap<String, Object> conditions = new HashMap<String, Object>();
				conditions.put("testpass.id", this.getTestpass_id());
				conditions.put("testsuite.id", this.getTestsuite_id());
				List<TestsuiteResult> testsuite_results = testsuiteresultService
						.findSuiteResultByMultiConditions(conditions);

				Testsuite testsuite = testsuite_results.get(0).getTestsuite();
				List<TestcaseResult> testcase_results = testsuite_results
						.get(0).getTestcase_results();

				request.setAttribute("testsuite", testsuite);
				request.setAttribute("testcaseresults", testcase_results);
				request.setAttribute("flag", true);

				return "success";

			} else {
				request.setAttribute("error", "The testpass id is null!");
				request.setAttribute("flag", false);
				return "error";
			}
		} else {
			request.setAttribute("error", "The testuiste id is null!");
			request.setAttribute("flag", false);
			return "error";
		}

	}
	
	public String queryFailedTestcases() {

		HttpServletRequest request = ServletActionContext.getRequest();

			if (this.getTestpass_id() != null && this.getTestpass_id().equals("") == false) {
				
				Testpass testpass = testpassService.findTestpassById(this.getTestpass_id());

				List<TestcaseResult> testcase_results = this.getSpecialTestcaseResults(testpass);

				this.setRow(10);
				Integer size = testcase_results.size();
				if (size % this.getRow() == 0){
					this.pages = (long) (size/ this.getRow());
				} else {
					this.pages = (long) (size/ this.getRow() + 1);
				}
					
				request.setAttribute("pages", this.pages);
				request.setAttribute("testpassname", testpass.getName());
				request.setAttribute("flag", true);

				return "success";

			} else {
				request.setAttribute("error", "The testpass id is null!");
				request.setAttribute("flag", false);
				return "error";
			}
		} 

	public String queryFailedTestcasesByPage() {

		HttpServletRequest request = ServletActionContext.getRequest();

			if (this.getTestpass_id() != null && this.getTestpass_id().equals("") == false) {

				Testpass testpass = testpassService.findTestpassById(this.getTestpass_id());
				
				List<TestcaseResult> testcase_results = this.getSpecialTestcaseResults(testpass);

				this.setRow(10);
				Integer size = testcase_results.size();
				if (size % this.getRow() == 0){
					this.pages = (long) (size/ this.getRow());
				} else {
					this.pages = (long) (size/ this.getRow() + 1);
				}
				
				Integer start = (Integer.parseInt(this.getPagenum()) - 1) * this.getRow();
				Integer end = (Integer.parseInt(this.getPagenum())) * this.getRow();
				if ((Integer.parseInt(this.getPagenum()) == this.pages) && ((size % this.getRow()) > 0) ){
					end = size;
				}
				
				List<TestcaseResultDto> testcaserange_dtoes = this.getSpecilRangeTestcaseResults(testcase_results, start, end);
				
				this.setTestcaseresultdtoes(testcaserange_dtoes);

				return "success";

			} else {
				request.setAttribute("error", "The testpass id is null!");
				request.setAttribute("flag", false);
				return "error";
			}
		} 

	public String querySpecialTestcaseResultContent() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService
					.findTestcaseResultById(this.getTestcaseresult_id());

			List<TestcaseResultContent> testcaseresult_contents = testcaseresult
					.getTestcaseresult_contents();

			request.setAttribute("testcase", testcaseresult.getTestcase());
			request.setAttribute("testcaseresultcontents",
					testcaseresult_contents);
			request.setAttribute("flag", true);

			return "success";

		} else {
			this.setPrompt("The testcaseresult id is null!");
			return "error";
		}

	}
	
	private List<TestcaseResult> getSpecialTestcaseResults(Testpass testpass){

		List<TestcaseResult> testcaseresults_summary = new ArrayList<TestcaseResult>();
			
		List<TestsuiteResult> testsuite_results = testpass.getTestsuite_results();
		for (int i=0; i<testsuite_results.size(); i++){
			
			HashMap<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("ispass", false);
			conditions.put("testsuite_result.id", testsuite_results.get(i).getId());
			List<TestcaseResult> testcase_results = testcaseresultService.findAllCaseresultByMultiConditions(conditions);

			for (int j=0; j< testcase_results.size(); j++){
				testcaseresults_summary.add(testcase_results.get(j));
			}
	
		}
		
		return testcaseresults_summary;
	}
	
	private List<TestcaseResultDto> getSpecilRangeTestcaseResults(List<TestcaseResult> testcaseResults, Integer start, Integer end){
		
		List<TestcaseResultDto> testcaseresult_dtoes = new ArrayList<TestcaseResultDto>();
		
		while(start<end){
			AnalyseCommentHistory analyseCommentHistory = analysecommenthistoryService.findRecentOne(testcaseResults.get(start).getId());
			TestcaseResultDto testcaseresultDto = testcaseresultService.getTestcaseResultDto(testcaseResults.get(start), analyseCommentHistory);
			testcaseresult_dtoes.add(testcaseresultDto);
			start++;
		}
		
		return testcaseresult_dtoes;
		
	}

	private List<TestpassDto> getTestpasses(Sut sut) throws ParseException {

//		Long now = System.currentTimeMillis();
//		System.out.println("1 The time is:" + now);
//		Long old = now;
		
		HashMap<String, Object> testpass_conditions = new HashMap<String, Object>();
		if (this.getStarttime() != null
				&& this.getStarttime().equals("") == false) {
			String newStartTime = this.getStarttime().replace("/", "-");
			testpass_conditions.put("starttime",
					util.stringToSqlDate(newStartTime));
		}
		if (this.getEndtime() != null && this.getEndtime().equals("") == false) {
			String newEndTime = this.getEndtime().replace("/", "-");
			testpass_conditions
					.put("endtime", util.stringToSqlDate(newEndTime));
		}
		if (this.getVersion() != null && this.getVersion().equals("") == false) {
			Version version = versionService.findVersionByVersionNum(this
					.getVersion());
			if (version != null) {
				Integer version_id = version.getId();
				testpass_conditions.put("version.id", version_id);
			}
		}
		testpass_conditions.put("sut.id", sut.getId());
		if (this.getTag() != null && this.getTag().equals("") == false) {
			testpass_conditions.put("tag", this.getTag());
		}
		if (this.getEnv() != null && this.getEnv().equals("") == false) {
			testpass_conditions.put("env", this.getEnv());
		}
		if (this.getTestset() != null && this.getTestset().equals("") == false) {
			testpass_conditions.put("testset", this.getTestset());
		}
		List<Testpass> testpasses = testpassService
				.findAllTestpassByMultiConditions(testpass_conditions);

		List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();

		if (this.getRow() == null)
			this.setRow(10);
		if (this.getPagenum() == null)
			this.setPagenum("1");

		if (testpasses.size() > 0) {
			this.setPages((long) Math.ceil(testpasses.size()
					/ (double) this.getRow()));
		} else {
			this.setPages((long) 1);
		}

		Integer start = (Integer.parseInt(this.getPagenum()) - 1) * 10;
		Integer end = Integer.parseInt(this.getPagenum()) * 10;
		if (testpasses.size() < end) {
			end = testpasses.size();
		}

		for (int i = start; i < end; i++) {
			Integer testcaseresultpass_quantity = 0;
			HashMap<String, Integer> testcaseresult_passcounts = new HashMap<String, Integer>();
			Integer testcaseresultfail_quantity = 0;
			HashMap<String, Integer> testcaseresult_failcounts = new HashMap<String, Integer>();

			List<TestsuiteResult> testsuite_results = testpasses.get(i)
					.getTestsuite_results();
			for (int j = 0; j < testsuite_results.size(); j++) {
				HashMap<String, Object> conditions = new HashMap<String, Object>();

				conditions.put("testsuite_result.id", testsuite_results.get(j)
						.getId());
				conditions.put("ispass", true);
				
//				now = System.currentTimeMillis();
//				System.out.println("2 The time is:" + i + j + " : time : " + (now-old));
//				old = System.currentTimeMillis();
				
				List<Integer> counts = testcaseresultService.findCountsOfCaseresults(testsuite_results.get(j).getId());
				
//				Integer caseresults_count = testcaseresultService
//						.findCountOfCaseresults(conditions);
				Integer caseresults_count = Integer.parseInt(counts.get(0)+"");
				testcaseresult_passcounts.put(testsuite_results.get(j)
						.getSuitename(), caseresults_count);
				testcaseresultpass_quantity += caseresults_count;

//				conditions.remove("ispass");
//				conditions.put("ispass", false);
//				caseresults_count = testcaseresultService
//						.findCountOfCaseresults(conditions);
				caseresults_count = Integer.parseInt(counts.get(1)+"");
				testcaseresult_failcounts.put(testsuite_results.get(j)
						.getSuitename(), caseresults_count);
				testcaseresultfail_quantity += caseresults_count;
			}

			Integer total = testcaseresultpass_quantity
					+ testcaseresultfail_quantity;
			Float percentage = (float) testcaseresultpass_quantity
					/ (float) total;
			Float percentage_foursets = (float) ((Math.round(percentage * 10000)) / 10000.0);

//			now = System.currentTimeMillis();
//			System.out.println("3 The time is:" + (now-old));
//			old = System.currentTimeMillis();
			
			TestpassDto testpassDto = testpassService.getTestpassDto(
					testpasses.get(i), testcaseresultpass_quantity,
					testcaseresultfail_quantity, total, percentage_foursets);
			testpassdots.add(testpassDto);
		}

		return testpassdots;

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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getEnv() {
		return env;
	}

	public void setEnv(String env) {
		this.env = env;
	}

	public String getTestset() {
		return testset;
	}

	public void setTestset(String testset) {
		this.testset = testset;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getShow_tag() {
		return show_tag;
	}

	public void setShow_tag(String show_tag) {
		this.show_tag = show_tag;
	}

	public Integer getTestsuite_id() {
		return testsuite_id;
	}

	public void setTestsuite_id(Integer testsuite_id) {
		this.testsuite_id = testsuite_id;
	}

	public Integer getTestcase_id() {
		return testcase_id;
	}

	public void setTestcase_id(Integer testcase_id) {
		this.testcase_id = testcase_id;
	}

	public Integer getTestcaseresult_id() {
		return testcaseresult_id;
	}

	public void setTestcaseresult_id(Integer testcaseresult_id) {
		this.testcaseresult_id = testcaseresult_id;
	}

	public List<TestcaseResultDto> getTestcaseresultdtoes() {
		return testcaseresultdtoes;
	}

	public void setTestcaseresultdtoes(List<TestcaseResultDto> testcaseresultdtoes) {
		this.testcaseresultdtoes = testcaseresultdtoes;
	}
}
