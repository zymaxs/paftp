package com.paftp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.entity.UserinfoDepartment;
import com.paftp.entity.UserinfoPosition;
import com.paftp.service.StaticColumn.UserinfoDepartmentService;
import com.paftp.service.StaticColumn.UserinfoPositionService;
import com.paftp.service.user.UserService;
import com.paftp.service.userinfo.UserInfoService;
import com.paftp.util.Util;

@Controller
public class UserProfileAction extends ActionSupport{

	/**
	 * Lei Lei 
	 * For updating user information
	 */
	private static final long serialVersionUID = -3885840931640610465L;

	@Resource
	private UserInfoService userInfoService;
	@Resource
	private UserService userService;
	@Resource
	private UserinfoDepartmentService departmentService;
	@Resource
	private UserinfoPositionService positionService;
	private String password;
	private String orignpassword;
	private Integer departmentId;
	private Integer positionId;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	
	private User user;
	private User updatedUser; 
	private Util util = new Util();
	
	private HttpSession session;

	public String updateUserInfo(){
		
		user = getSessionUser();
		
		if (user == null)
			return "login";
		
		if (this.getDepartmentId() == null || this.getPositionId() == null)
			return "error";
		
		UserInfo userInfo = new UserInfo();
		updatedUser = setUserInfo(user, userInfo, user.getUserInfo().getId());
		
		userInfoService.updateUserInfo(userInfo);
		
		setSession("user", updatedUser);
		
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
			
		if(dbUser.getStatus().equals("initial"))
			dbUser.setStatus("old");
		
		String password_md5 = util.md5Encryption(this.password);
		dbUser.setPassword(password_md5);
				
		userService.updateUser(dbUser);
		
		return "success";
	
	}
	
	private User setUserInfo(User user, UserInfo userInfo, Integer id){
		
		userInfo.setId(id);
		UserinfoDepartment userinfoDepartment = departmentService.findUserInfoDepartmentById(this.getDepartmentId());
		userInfo.setStaticDepartment(userinfoDepartment);
		UserinfoPosition userinfoPosition = positionService.findUserinfoPositionById(this.getPositionId());
		userInfo.setStaticPosition(userinfoPosition);
		userInfo.setMobile(this.getMobile());
		userInfo.setTelephone(this.getTelephone());
		userInfo.setOthermail(this.getOtherinfo());
		userInfo.setOtherinfo(this.getOtherinfo());
		
		user.setUserInfo(userInfo);

		return user;
		
	}
	
	public User getSessionUser(){
		
		session = ServletActionContext.getRequest().getSession(false);  
		
        if(session==null || session.getAttribute("user")==null){  
            return null;  
        }  
        else{  
        	User user = (User) session.getAttribute("user");
            return user;  
        }  
	}
	
	
	private void setSession(String key, Object content){
		
		session = ServletActionContext.getRequest().getSession(false);
		
		session.removeAttribute(key);
		session.setAttribute(key, content);
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

	public String getOrignpassword() {
		return orignpassword;
	}

	public void setOrignpassword(String orignpassword) {
		this.orignpassword = orignpassword;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
}
