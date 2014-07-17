package com.paftp.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.entity.TestsuiteResult;
import com.paftp.service.AnalyseCommentHistory.AnalyseCommentHistoryService;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;

@Controller
public class TestcaseresultAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7010705889254732007L;

	private Integer testcaseresult_id;
	
	private String prompt;
	
	private String status;
	private String comment;
	private Date createtime;
	private List<AnalyseCommentHistory> analysecommenthistories = new ArrayList<AnalyseCommentHistory>();

	@Resource
	private TestcaseResultService testcaseresultService;
	@Resource
	private AnalyseCommentHistoryService analysecommenthistoryService;

	public String getTRHistoryStatus() {
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<String> statuses = analysecommenthistoryService.findAllStatues(testcaseresult.getId());
			
			if (statuses != null && statuses.size() > 0) {
				this.setStatus(statuses.get(0));
			} else {
				this.setStatus("未处理");
			}
			
		} else {
			this.setPrompt("The testcaseresult id is null!");
		}

		return "success";
		
	}
	
	public String addTRHistory(){
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<String> statuses = analysecommenthistoryService.findAllStatues(testcaseresult.getId());
			
			AnalyseCommentHistory analysecomment_history = new AnalyseCommentHistory();
			if (statuses != null && statuses.size() > 0) {
				analysecomment_history.setOldstatus(statuses.get(0));
			} else {
				analysecomment_history.setOldstatus("未处理");
			}
			analysecomment_history.setNewstatus(this.getStatus());
			analysecomment_history.setNewcomment(this.getComment());
			this.createtime = new Date();
			java.sql.Timestamp createdatetime = new java.sql.Timestamp(
					createtime.getTime());
			analysecomment_history.setCreatetime(createdatetime);
			analysecomment_history.setTestcase_result(testcaseresult);
			analysecommenthistoryService.saveAnalyseCommentHistory(analysecomment_history);
			
		} else {
			this.setPrompt("The testcaseresult id is null!");
		}

		return "success";
	}

	public String getTRHistories(){
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<AnalyseCommentHistory> analysecomment_histories = testcaseresult.getAnalysecomment_histories();
			
			this.setAnalysecommenthistories(analysecomment_histories);
			
		} else {
			this.setPrompt("The testcaseresult id is null!");
		}
		
		return "success";
	}
	
	public Integer getTestcaseresult_id() {
		return testcaseresult_id;
	}

	public void setTestcaseresult_id(Integer testcaseresult_id) {
		this.testcaseresult_id = testcaseresult_id;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}
	

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	public List<AnalyseCommentHistory> getAnalysecommenthistories() {
		return analysecommenthistories;
	}

	public void setAnalysecommenthistories(
			List<AnalyseCommentHistory> analysecommenthistories) {
		this.analysecommenthistories = analysecommenthistories;
	}
}
