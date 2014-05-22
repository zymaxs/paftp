package com.paftp.action;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.User;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

@Controller
public class LoginAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;
	private Util util = new Util();
	private SessionMap<String, Object> sessionMap;

	public String login() {

		User user = null;

		if (this.getAlias() == null || this.getPassword() == null)
			return "error";

		String password_md5 = util.md5Encryption(this.password);
		user = userService.findUserByAliasAndPassword(alias, password_md5);

		if (user != null) {

			sessionMap.put("user", user);

			if (user.getStatus().equals("initial"))
				return "update";

			return "success";
		} else {
			return "error";
		}

	}

	public String logout() {
		if (sessionMap != null) {
			sessionMap.invalidate();
		}
		return "success";
	}

	public String getbakpwd() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getAlias() == null) {
			request.setAttribute("error", "Your account can't be empty!");
			return "error";
		}

		User user = null;

		user = userService.findUserByAlias(alias);

		if (user == null) {
			request.setAttribute("error", "The account is not exist!");
			return "error";
		}

		String newpwd = RandomString(12);
		request.setAttribute("newpassword", newpwd);
		String password_md5 = util.md5Encryption(newpwd);
		
		user.setStatus("initial");
		user.setPassword(password_md5);
		
		userService.saveUser(user);

		return "success";
	}

	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.sessionMap = (SessionMap) session;
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

	public static String RandomString(int length) {
		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random random = new Random();
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int num = random.nextInt(62);
			buf.append(str.charAt(num));
		}
		return buf.toString();
	}

}
