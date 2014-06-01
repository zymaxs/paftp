package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Role;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.entity.Department;
import com.paftp.entity.Position;
import com.paftp.service.StaticColumn.DepartmentService;
import com.paftp.service.StaticColumn.PositionService;
import com.paftp.service.role.RoleService;
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
	private DepartmentService departmentService;
	@Resource
	private PositionService positionService;
	@Resource
	private RoleService roleService;
	private String password;
	private String orignpassword;
	private String department;
	private String position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	private Integer userid;
	
	private String alias;

	private Integer row;
	private Integer pagenum;
	private Long pages;

	private User user;
	private User updatedUser; 
	private Util util = new Util();
	private List<Role> currentPageRoles = new ArrayList<Role>();
	
	private HttpSession session;
	
	public String getUserInfo(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = userService.findUserById(this.getUserid());
		
		if (user == null){
			request.setAttribute("error", "The user account is not exist!");
		}
		
		request.setAttribute("user", user);
		
		return "success";
		
	}
	
	public String queryRoles(){

		row = 10;

		List<Role> roles = user.getRoles();
		
		pages = (long) Math.ceil(roles.size() / (double) row);
		
		for (int i = (pagenum-1)*10; i<((pagenum-1)*10 + row); i++){
			Role role = new Role();
			role = roles.get(i);
			currentPageRoles.add(role);
		}

		this.setPages(pages);
		this.setCurrentPageRoles(currentPageRoles);
		
		return "success";
	}
	
	public String updateUserInfo(){
		
		user = getSessionUser();
		
		if (user == null)
			return "login";
		
		if (this.getDepartment() == null || this.getPosition() == null)
			return "error";

		updatedUser = setUserInfo(user);
		
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
	
	private User setUserInfo(User user){
		
		UserInfo userInfo = new UserInfo();
		
		userInfo.setId(user.getUserInfo().getId());
		Department department = departmentService.findDepartmentByName(this.getDepartment());
		userInfo.setDepartment(department);
		Position position = positionService.findPositionByName(this.getPosition());
		userInfo.setPosition(position);
		userInfo.setMobile(this.getMobile());
		userInfo.setTelephone(this.getTelephone());
		userInfo.setOthermail(this.getOtherinfo());
		userInfo.setOtherinfo(this.getOtherinfo());
		userInfoService.updateUserInfo(userInfo);
		user.setUserInfo(userInfo);

		return user;
		
	}
	
	private User getSessionUser(){
		
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
	
	
	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

	public Integer getPagenum() {
		return pagenum;
	}

	public void setPagenum(Integer pagenum) {
		this.pagenum = pagenum;
	}

	public Long getPages() {
		return pages;
	}

	public void setPages(Long pages) {
		this.pages = pages;
	}
	
	public List<Role> getCurrentPageRoles() {
		return currentPageRoles;
	}

	public void setCurrentPageRoles(List<Role> currentPageRoles) {
		this.currentPageRoles = currentPageRoles;
	}

}
