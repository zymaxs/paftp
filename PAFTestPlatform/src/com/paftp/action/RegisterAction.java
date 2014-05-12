package com.paftp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.User;
import com.paftp.service.user.UserService;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class RegisterAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;

	public String register() {

		HttpServletRequest request = ServletActionContext.getRequest();
		User user = userService.findUserByAlias(alias);
		if (user == null) {
			request.setAttribute("username", alias);
			user = new User();
			user.setAlias(alias);
			user.setPassword(password);
			userService.saveUser(user);
			request.setAttribute("username", alias);
			return "success";
		} else {
			return ERROR;
		}

	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
