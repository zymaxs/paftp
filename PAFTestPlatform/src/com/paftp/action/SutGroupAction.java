package com.paftp.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Sut;
import com.paftp.entity.SutGroup;
import com.paftp.entity.User;
import com.paftp.entity.Version;
import com.paftp.service.StaticColumn.SutGroupService;

@Controller
public class SutGroupAction extends ActionSupport{

	private String name;
	private String description;
	
	@Resource
	private SutGroupService sutgroupService;
	
	private User user;
	
	public String createSutGroup(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = this.getSessionUser();
		
		if (user.getAlias().equals("admin") == false){
			request.setAttribute("error", "You has not the authority to do this!");
			return "error";
		}
		
		SutGroup sutgroup = sutgroupService.findSutGroupByName(this.getName());
		if (sutgroup != null){
			request.setAttribute("error", "The version has been exist!");
			return "error";
		}
		
		sutgroup = new SutGroup();
		sutgroup.setName(this.getName());
		sutgroup.setDescription(this.getDescription());

		sutgroupService.saveSutGroup(sutgroup);
		
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
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
}
