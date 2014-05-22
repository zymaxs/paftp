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
import com.paftp.entity.ApplySut;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.User;
import com.paftp.service.ApplySut.ApplySutService;
import com.paftp.service.sut.SutService;

@Controller
public class ApplySutAction extends ActionSupport {

	/**
	 * Lei Lei For applying the new system
	 */
	private static final long serialVersionUID = -4929348834511346646L;

	@Resource
	private ApplySutService applySutService;
	@Resource
	private SutService sutService;
	private String code;
	private String name;
	private String description;
	private Date applytime;

	private Date resolvetime;
	private String action;
	private String comment;

	private User user;

	public String applySut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		if (this.getCode() == null || this.getName() == null)
			return "error";

		ApplySut existSuts = applySutService.findApplySutByName(this.getName());
		if (existSuts != null) {
			if (existSuts.getUser().getAlias().equals(user.getAlias()))
				request.setAttribute("exist", "self");
			else
				request.setAttribute("exist", "all");

			return "exist";
		}

		ApplySut applySut = new ApplySut();
		applySut.setUser(user);
		setApplySut(applySut);

		applySutService.saveApplySut(applySut);

		return "success";
	}

	public String approveSut() {

		user = getSessionUser();

		if (user == null)
			return "login";

		if (this.getAction() == null)
			return "error";

		ApplySut applySut = new ApplySut();
		applySut.setUser(user);
		setApplySut(applySut);

		applySutService.saveApplySut(applySut);
		
		Sut sut = new Sut();
		sut.setCode(this.getCode());
		sut.setName(this.getName());
		sut.setDescription(this.getDescription());
		Role role = new Role();
		role.setName(this.getName());
		role.setDescription("The admin role for the system of" + this.getName());
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		sut.setRole_results(roles);
		
		return "success";
	}

	public String getSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		request.setAttribute("applySutList",
				applySutService.findApplySutByUser(user.getId()));
		
		return "success";

	}

	public void setApplySut(ApplySut applySut) {

		this.applytime = new Date();
		this.resolvetime = new Date();

		applySut.setResolvetime(resolvetime);
		applySut.setAction(this.getAction());
		applySut.setComment(this.getComment());

		applySut.setApplytime(applytime);
		applySut.setCode(this.getCode());
		applySut.setName(this.getName());
		applySut.setDescription(this.getDescription());
	}

	public User getSessionUser() {

		HttpSession session = ServletActionContext.getRequest().getSession(
				false);

		if (session == null || session.getAttribute("user") == null) {
			return null;
		} else {
			User user = (User) session.getAttribute("user");
			return user;
		}
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public Date getApplytime() {
		return applytime;
	}

	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}

	public Date getResolvetime() {
		return resolvetime;
	}

	public void setResolvetime(Date resolvetime) {
		this.resolvetime = resolvetime;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}
