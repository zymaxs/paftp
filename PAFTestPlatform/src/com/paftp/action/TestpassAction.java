package com.paftp.action;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.TestpassDto;
import com.paftp.entity.Sut;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testpass;
import com.paftp.entity.TestsuiteResult;
import com.paftp.entity.User;
import com.paftp.entity.Version;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.Testpass.TestpassService;
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

	private String sut_id;
	private String sut_name;
	private Integer testpass_id;
	private String tag;
	private String env;
	private String testset;

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

	private Util util = new Util();

	private static final long serialVersionUID = -1539739561518693848L;

	public String initialTestpasses() throws ParseException {

		HttpServletRequest request = ServletActionContext.getRequest();
		user = util.getSessionUser();

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
			request.setAttribute("error", "Please let me konw which sut you want to query!");
			request.setAttribute("flag", false);
			return "error";
		}

		request.setAttribute("testpassdots", testpassdots);
		request.setAttribute("flag", true);
		request.setAttribute("pages", this.getPages());
		return "success";
		
	}
	
	public String queryTestpasses() throws ParseException{
		
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

	private List<TestpassDto> getTestpasses(Sut sut) throws ParseException{

		HashMap<String, Object> testpass_conditions = new HashMap<String, Object>();
		if (this.getStarttime() != null && this.getStarttime().equals("") == false){
			String newStartTime = this.getStarttime().replace("/", "-");
			testpass_conditions.put("starttime", util.stringToSqlDate(newStartTime));
		}
		if (this.getEndtime() != null && this.getEndtime().equals("") == false){
			String newEndTime = this.getEndtime().replace("/", "-");
			testpass_conditions.put("endtime", util.stringToSqlDate(newEndTime));
		}
		if (this.getVersion() != null && this.getVersion().equals("") == false){
			Version version = versionService.findVersionByVersionNum(this.getVersion());
			if (version != null){
				Integer version_id = version.getId();
				testpass_conditions.put("version.id", version_id);
			}
		}
		testpass_conditions.put("sut.id", sut.getId());
		if (this.getTag() != null && this.getTag().equals("") == false){
			testpass_conditions.put("tag", this.getTag());
		}
		if (this.getEnv() != null && this.getEnv().equals("") == false){
			testpass_conditions.put("env", this.getEnv());
		}
		if (this.getTestset() != null && this.getTestset().equals("") == false){
			testpass_conditions.put("testset", this.getTestset());
		}
		List<Testpass> testpasses = testpassService.findAllTestpassByMultiConditions(testpass_conditions);
		
		List<TestpassDto> testpassdots = new ArrayList<TestpassDto>();
		
		if (this.getRow() == null)
			this.setRow(10);
		if (this.getPagenum() == null)
			this.setPagenum("1");
		
		if (testpasses.size() > 0) {
			this.setPages((long) Math.ceil(testpasses.size() / (double) this.getRow()));
		} else {
			this.setPages((long) 1);
		}
		
		Integer start = (Integer.parseInt(this.getPagenum()) - 1) * 10;
		Integer end = Integer.parseInt(this.getPagenum()) * 10;
		if (testpasses.size() < end){
			end = testpasses.size();
		}
	
		for(int i = start ; i<end; i++){
			Integer testcaseresultpass_quantity = 0;
			HashMap<String, Integer> testcaseresult_passcounts = new HashMap<String, Integer>();
			Integer testcaseresultfail_quantity = 0;
			HashMap<String, Integer> testcaseresult_failcounts = new HashMap<String, Integer>();
		
			List<TestsuiteResult> testsuite_results = testpasses.get(i).getTestsuite_results();
			for (int j=0; j<testsuite_results.size(); j++){
				HashMap<String, Object> conditions = new HashMap<String, Object>();
				
				conditions.put("testsuite_result.id", testsuite_results.get(j).getId());
				conditions.put("ispass", true);
				Integer caseresults_count = testcaseresultService.findCountOfCaseresults(conditions);
				testcaseresult_passcounts.put(testsuite_results.get(j).getSuitename(), caseresults_count);
				testcaseresultpass_quantity += caseresults_count;
				
				conditions.remove("ispass");
				conditions.put("ispass", false);
				caseresults_count = testcaseresultService.findCountOfCaseresults(conditions);
				testcaseresult_failcounts.put(testsuite_results.get(j).getSuitename(), caseresults_count);
				testcaseresultfail_quantity += caseresults_count;
			}
			
			Integer total = testcaseresultpass_quantity + testcaseresultfail_quantity;
			Float percentage = (float)testcaseresultpass_quantity / (float)total;
			Float percentage_foursets=   (float)(Math.round(percentage*10000))/10000;
			
			TestpassDto testpassDto = testpassService.getTestpassDto(testpasses.get(i), testcaseresultpass_quantity, testcaseresultfail_quantity, total, percentage_foursets);
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
}
