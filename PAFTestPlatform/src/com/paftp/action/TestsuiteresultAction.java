package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.Testpass;
import com.paftp.entity.TestsuiteResult;
import com.paftp.service.Testpass.TestpassService;

@Controller
public class TestsuiteresultAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4429221797296262905L;
	@Resource
	private TestpassService testpassService;

	private Integer testpass_id;

	private String suitename;

	private Integer[] total;
	private Integer[] success_count;
	private Integer[] fail_count;
	private Integer totals;
	private Integer success_counts;
	private Integer fail_counts;

	public String initialTestsuiteresults(){
		
		Testpass testpass = testpassService.findTestpassById(this.getTestpass_id());
		List<TestsuiteResult> testsuiteresults =testpass.getTestsuite_results();
		Integer testsuitecount = testsuiteresults.size();
		
		total = new Integer[testsuitecount];;
		success_count= new Integer[testsuitecount];
		fail_count= new Integer[testsuitecount];
		totals = 0;
		success_counts = 0;
		fail_counts = 0;
		
		for (int i=0; i< testsuitecount; i++){
			
			TestsuiteResult testsuiteresult = testsuiteresults.get(i);
			
			total[i] = 0;
			success_count[i] = 0; 
			fail_count[i] = 0;
			
			List<TestcaseResult> testcaseresults = testsuiteresult.getTestcase_results();
			Integer testcasecount = testcaseresults.size();
			for(int j=0; j < testcasecount; j++){
				if(testcaseresults.get(j).getIspass()) {
					success_count[i] ++;
				}else{
					fail_count[i] ++;
				}
				total[i]++;
			}
			
			totals += total[i];
			success_counts += success_count[i];
			fail_counts += fail_count[i];
		}
		
		return "success";
	}

	public String getSuitename() {
		return suitename;
	}

	public void setSuitename(String suitename) {
		this.suitename = suitename;
	}


	public Integer getTestpass_id() {
		return testpass_id;
	}

	public void setTestpass_id(Integer testpass_id) {
		this.testpass_id = testpass_id;
	}

}
