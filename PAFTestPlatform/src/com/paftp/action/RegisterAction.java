package com.paftp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class RegisterAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;
	private String status;
	private String displayname;
	private String departname;
	private String position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	private Util util = new Util();
	
	public String register() {

		HttpServletRequest request = ServletActionContext.getRequest();
		User user = userService.findUserByAlias(alias);
		if (user == null) {
			user = new User();
			user.setAlias(alias);
			/* set the user words*/
			this.password = util.md5Encryption(request.getAttribute("password").toString());
			user.setPassword(password);
			UserInfo userInfo = new UserInfo();
			user.setUserInfo(userInfo);
			userService.saveUser(user);
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
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}

	public String getDepartname() {
		return departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getOthermail() {
		return othermail;
	}

	public void setOthermail(String othermail) {
		this.othermail = othermail;
	}

	public String getOtherinfo() {
		return otherinfo;
	}

	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}


}
