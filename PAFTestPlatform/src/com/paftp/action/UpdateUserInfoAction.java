package com.paftp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.userinfo.UserInfoService;

@Controller
public class UpdateUserInfoAction extends ActionSupport{

	/**
	 * Lei Lei 
	 * For updating user information
	 */
	private static final long serialVersionUID = -3885840931640610465L;

	@Resource
	private UserInfoService userInfoService;
	
	private String department;
	private String position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	
	private Integer userinfoId;

	public String update(){
		
		userinfoId = getUserInfoId();
		
		if (userinfoId == null || this.getDepartment() == null || this.getPosition() == null)
			return "error";
		
		UserInfo userInfo = new UserInfo();
		setUserInfo(userInfo, userinfoId);
		
		userInfoService.updateUserInfo(userInfo);
		
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
	
	public Integer getUserInfoId(){
		
		HttpSession session = ServletActionContext.getRequest().getSession(false);  
		Integer id = null;
		
        if(session==null || session.getAttribute("user")==null){  
            return id;  
        }  
        else{  
        	User user = (User) session.getAttribute("user");
        	id = user.getUserInfo().getId();
            return id;  
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

	
}
