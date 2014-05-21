package com.paftp.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.User;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

@Controller
public class LoginAction extends BaseAction  {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;
	private Util util = new Util();
	private Map<String, Object> session;

	public String login() {

		HttpServletRequest request = ServletActionContext.getRequest();
		
		if (this.getAlias() == null || this.getPassword() == null)
			return "error";
		
		String password_md5 = util.md5Encryption(this.password);
		
		User user = userService.findUserByAliasAndPassword(alias, password_md5);
		
		if (user != null) {
			
			request.setAttribute("displayname", user.getDisplayName());
			
			session = new HashMap<String, Object>();
			session.put("user", user);
			this.setSession(session);			
			
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
