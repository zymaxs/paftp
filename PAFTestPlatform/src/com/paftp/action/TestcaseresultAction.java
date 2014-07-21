package com.paftp.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.AnalyseCommentHistoryDto;
import com.paftp.entity.AnalyseCommentHistory;
import com.paftp.entity.TestcaseResult;
import com.paftp.entity.TestcaseResultContent;
import com.paftp.entity.TestsuiteResult;
import com.paftp.entity.User;
import com.paftp.service.AnalyseCommentHistory.AnalyseCommentHistoryService;
import com.paftp.service.TestcassResult.TestcaseResultService;
import com.paftp.service.TestsuiteResult.TestsuiteResultService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

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
	private User user;
	
	private Util util = new Util();
	private List<AnalyseCommentHistoryDto> analysecommenthistoryDtoes = new ArrayList<AnalyseCommentHistoryDto>();

	@Resource
	private TestcaseResultService testcaseresultService;
	@Resource
	private AnalyseCommentHistoryService analysecommenthistoryService;
	@Resource
	private UserService userService;

	public String getTRHistoryStatus() {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<AnalyseCommentHistory> analysecomment_histories = analysecommenthistoryService.findAllListByTime(testcaseresult.getId());
			
			if (analysecomment_histories != null && analysecomment_histories.size() > 0) {
				this.setStatus(analysecomment_histories.get(0).getNewstatus());
				this.setComment(analysecomment_histories.get(0).getNewcomment());
			} else {
				this.setStatus("未处理");
				this.setComment("");
			}
			
		} else {
			request.setAttribute("error", "The testcaseresult id is null!");
			return "error";
		}

		request.setAttribute("status", this.getStatus());
		request.setAttribute("comment", this.getComment());
		request.setAttribute("commentflag", true);
		
		return "success";
		
	}
	
	public String addTRHistory(){
		
		user = util.getSessionUser();
		if (user == null){
			this.setPrompt("Please log in firstly!");
			return "success";
		} else {
			user = userService.findUserByAlias(user.getAlias());
		}
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<AnalyseCommentHistory> history_models = analysecommenthistoryService.findAllListByTime(testcaseresult.getId());
			
			AnalyseCommentHistory history_model = new AnalyseCommentHistory();
			if (history_models != null && history_models.size() > 0) {
				history_model.setOldstatus(history_models.get(0).getNewstatus());
				history_model.setOldcomment(history_models.get(0).getNewcomment());
			} else {
				history_model.setOldstatus("未处理");
				history_model.setOldcomment("");
			}
			history_model.setNewstatus(this.getStatus());
			history_model.setNewcomment(this.getComment());
			Date createtime = new Date();
			java.sql.Timestamp createdatetime = new java.sql.Timestamp(
					createtime.getTime());
			history_model.setCreatetime(createdatetime);
			history_model.setTestcase_result(testcaseresult);
			history_model.setUpdator(user);
			analysecommenthistoryService.saveAnalyseCommentHistory(history_model);
			
		} else {
			this.setPrompt("The testcaseresult id is null!");
		}

		return "success";
	}

	public String listTRHistories(){
		
		if (this.getTestcaseresult_id() != null) {

			TestcaseResult testcaseresult = testcaseresultService.findTestcaseResultById(this.getTestcaseresult_id());
			List<AnalyseCommentHistory> analysecomment_histories = testcaseresult.getAnalysecomment_histories();
			
			this.setAnalysecommenthistoryDtoes(analysecommenthistoryService.getAnalyseCommentHistoriesDto(analysecomment_histories));
			
		} else {
			this.setPrompt("The testcaseresult id is null!");
		}
		
		return "success";
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

	public List<AnalyseCommentHistoryDto> getAnalysecommenthistoryDtoes() {
		return analysecommenthistoryDtoes;
	}

	public void setAnalysecommenthistoryDtoes(
			List<AnalyseCommentHistoryDto> analysecommenthistoryDtoes) {
		this.analysecommenthistoryDtoes = analysecommenthistoryDtoes;
	}

	
}
