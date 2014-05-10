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

	private String username;
	private String password;

	public String register() {

		HttpServletRequest request = ServletActionContext.getRequest();
		User user = userService.findUserByName(username);
		if (user == null) {
			request.setAttribute("username", username);
			user = new User();
			user.setUserName(username);
			user.setPassword(password);
			userService.saveUser(user);
			request.setAttribute("username", username);
			return "success";
		} else {
			return ERROR;
		}

	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
