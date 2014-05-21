package com.paftp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.user.UserService;
import com.paftp.service.userinfo.UserInfoService;
import com.paftp.util.Util;

@Controller
public class UpdateUserInfoAction extends ActionSupport{

	/**
	 * Lei Lei 
	 * For updating user information
	 */
	private static final long serialVersionUID = -3885840931640610465L;

	@Resource
	private UserInfoService userInfoService;
	private UserService userService;
	
	private String password;
	private String orignpassword;
	private String department;
	private String position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	
	private User user;
	private Util util = new Util();

	public String updateUserInfo(){
		
		user = getSessionUser();
		
		if (user == null)
			return "login";
		
		if (this.getDepartment() == null || this.getPosition() == null)
			return "error";
		
		UserInfo userInfo = new UserInfo();
		setUserInfo(userInfo, user.getUserInfo().getId());
		
		userInfoService.updateUserInfo(userInfo);
		
		return "success";
		
	}
	
	public String updatePassword(){
		
		user = getSessionUser();
		
		if (user == null)
			return "login";
		
		String orignpassword_md5 = util.md5Encryption(this.orignpassword);
		User dbUser = userService.findUserByAliasAndPassword(user.getAlias(), orignpassword_md5);
		
		if(dbUser == null)
			return "error";     //source password error
			
		if(user.getStatus().equals("initial"))
			user.setStatus("old");
		
		String password_md5 = util.md5Encryption(this.password);
		user.setPassword(password_md5);
				
		userService.updateUser(user);
		return "success";
	
	}
	
	private void setUserInfo(UserInfo userInfo, Integer id){
		
		userInfo.setId(id);
		userInfo.setDepartment(this.getDepartment());
		userInfo.setMobile(this.getMobile());
		userInfo.setTelephone(this.getPosition());
		userInfo.setPosition(this.getPosition());
		userInfo.setOthermail(this.getOtherinfo());
		userInfo.setOtherinfo(this.getOtherinfo());
		
	}
	
	public User getSessionUser(){
		
		HttpSession session = ServletActionContext.getRequest().getSession(false);  
		
        if(session==null || session.getAttribute("user")==null){  
            return null;  
        }  
        else{  
        	User user = (User) session.getAttribute("user");
            return user;  
        }  
	}
	
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
}
