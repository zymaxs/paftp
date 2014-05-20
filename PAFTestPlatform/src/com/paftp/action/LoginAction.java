package com.paftp.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.paftp.entity.User;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;
	private Util util = new Util();

	public String login() {

		if (this.getAlias() == null || this.getPassword() == null)
			return "error";
		
		String password_md5 = util.md5Encryption(this.password);
		
		User user = userService.findUserByAliasAndPassword(alias, password_md5);
		
		if (user != null) {
			return "success";
		} else {
			return "error";
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
