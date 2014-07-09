package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Sut;
import com.paftp.entity.Testpass;
import com.paftp.entity.User;
import com.paftp.service.Testpass.TestpassService;
import com.paftp.service.sut.SutService;

@Controller
public class TestpassAction extends ActionSupport{

	/**
	 * 
	 */
	@Resource
	private TestpassService testpassService;
	@Resource
	private SutService sutService;
	
	private String sut_name;
	private Integer testpass_id;

	private User user;
	
	private String prompt;
	
	private static final long serialVersionUID = -1539739561518693848L;

	public String initialTestpasses(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = getSessionUser();
		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}
		
		Sut sut = sutService.findSutByName(this.getSut_name());
		if (sut != null) {
	
		List<Testpass> testpasses = sut.getTestpasses();
		request.setAttribute("testpasses", testpasses);
		
		} else {
			request.setAttribute("error", "The sut is not exist!");
			return "error";
		}
		
		return "success";
	}
	
	public String updateTestpass(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = getSessionUser();

		if (user == null) {
			request.setAttribute("error", "Please log in firstly!");
			return "error";
		}
		
		Testpass testpass = testpassService.findTestpassById(this.getTestpass_id());
		
		request.setAttribute("testpass", testpass);
		
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
	
}
