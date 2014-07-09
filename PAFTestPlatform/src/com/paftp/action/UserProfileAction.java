package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.RoleDto;
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
public class UserProfileAction extends ActionSupport {

	/**
	 * Lei Lei For updating user information
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
	private String departmentDesc;
	private String positionDesc;

	private String alias;
	private String displayname;
	private String originpassword;
	
	private Integer row;
	private Integer pagenum;
	private Long pages;

	private User user;

	private User updatedUser;
	private Util util = new Util();
	private List<Role> currentPageRoles = new ArrayList<Role>();
	private List<RoleDto> currentPageRoleDtoes = new ArrayList<RoleDto>();

	private HttpSession session;

	public String getUserInfo() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = userService.findUserById(this.getUserid());

		row = 10;

		List<Role> roles = user.getRoles();

		pages = (long) Math.ceil(roles.size() / (double) row);

		Role role = null;
		for (int i = 0; i < row; i++) {
			if (i < roles.size()) {
				role = roleService.findRoleById(roles.get(i).getId());
				if (role.getName().equals("seniormanager") == false) {
					if (this.existSubString(role.getName(), "Manager")){
						role.setName("管理员");
					}else{
						role.setName("成员");
					}
					currentPageRoles.add(role);
				}
			} else {
				break;
			}
		}

		request.setAttribute("pages", pages);
		request.setAttribute("currentpageroles", currentPageRoles);

		request.setAttribute("user", user);

		return "success";

	}

	public String getRoles() {
		
		row = 10;
		
		User temp_user = userService.findUserById(this.getUserid());
		
		List<Role> roles = temp_user.getRoles();
		List<Role> temp_currentPageRoles = new ArrayList<Role>();
		
		Long temp_pages = (long) Math.ceil(roles.size() / (double) row);

		if (pagenum == null || pagenum == 0) {
			pagenum = 1;
		}

		for (int i = (pagenum - 1) * 10; i < ((pagenum - 1) * 10 + row); i++) {
			if (i < roles.size()) {
				Role role = new Role();
				role = roles.get(i);
				if (role.getName().equals("seniormanager") == false) {
				if (this.existSubString(role.getName(), "Manager")){
					role.setName("管理员");
				}else{
					role.setName("成员");
				}
				temp_currentPageRoles.add(role);
				}
			} else {
				break;
			}
		}
		
		List<RoleDto> roleDtoes = roleService.getRoleDto(temp_currentPageRoles);

		this.setPages(temp_pages);
		this.setCurrentPageRoleDtoes(roleDtoes);

		return "success";
	}

	public String updateUserInfo() {

		user = getSessionUser();

		if (this.getDepartment() == null || this.getPosition() == null)
			return "error";

		updatedUser = setUserInfo(user);
		
		setSession("user", updatedUser);

		return "success";

	}

	public String updatePassword() {

		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = getSessionUser();
		
		if(this.getOriginpassword() == null || this.getPassword() == null || this.getOriginpassword().equals(this.getPassword())){
			request.setAttribute("error",
					"Your new password is same with the old one or your input is null!");
			return "error";
		}

		String orignpassword_md5 = util.md5Encryption(this.orignpassword);
		User dbUser = userService.findUserByAliasAndPassword(user.getAlias(),
				orignpassword_md5);

		if (dbUser == null){
			request.setAttribute("error",
					"Your password is wrong!");
			return "error";
		}

		if (dbUser.getStatus().equals("initial"))
			dbUser.setStatus("old");

		String password_md5 = util.md5Encryption(this.password);
		dbUser.setPassword(password_md5);

		userService.updateUser(dbUser);

		return "success";

	}
	
	public String createDepartment(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = this.getSessionUser();
		
		if (user.getAlias().equals("admin") == false){
			request.setAttribute("error", "You has not the authority to do this!");
			return "error";
		}
		
		Department department = departmentService.findDepartmentByName(this.getDepartment());
		if (department != null){
			request.setAttribute("error", "The department has been exist!");
			return "error";
		}
		
		department = new Department();
		department.setName(this.getDepartment());
		department.setDescription(this.getDepartmentDesc());
		
		departmentService.saveDepartment(department);

		return "success";
	}
	
	public String createPosition(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = this.getSessionUser();
		
		if (user.getAlias().equals("admin") == false){
			request.setAttribute("error", "You has not the authority to do this!");
			return "error";
		}
		
		Position position = positionService.findPositionByName(this.getPosition());
		if (position != null){
			request.setAttribute("error", "The position has been exist!");
			return "error";
		}
		
		position = new Position();
		position.setName(this.getPosition());
		position.setDescription(this.getPositionDesc());
		
		positionService.savePosition(position);

		return "success";
	}


	private User setUserInfo(User user) {

		UserInfo userInfo = new UserInfo();

		userInfo.setId(user.getUserInfo().getId());
		Department department = departmentService.findDepartmentByName(this
				.getDepartment());
		userInfo.setDepartment(department);
		Position position = positionService.findPositionByName(this
				.getPosition());
		userInfo.setPosition(position);
		userInfo.setMobile(this.getMobile());
		userInfo.setTelephone(this.getTelephone());
		userInfo.setOthermail(this.getOthermail());
		userInfo.setOtherinfo(this.getOtherinfo());
		user.setUserInfo(userInfo);
		user.setDisplayName(this.getDisplayname());
		userService.updateUser(user);

		return user;

	}

	private User getSessionUser() {

		session = ServletActionContext.getRequest().getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			return null;
		} else {
			User user = (User) session.getAttribute("user");
			return user;
		}
	}

	private void setSession(String key, Object content) {

		session = ServletActionContext.getRequest().getSession(false);

		session.removeAttribute(key);
		session.setAttribute(key, content);
	}
	
	private Boolean existSubString(String source, String substring){

		  int a=source.indexOf(substring);

		  if(a>=0){
			  return true;
		  }else{
			  return false;
		  }

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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getDepartmentDesc() {
		return departmentDesc;
	}

	public void setDepartmentDesc(String departmentDesc) {
		this.departmentDesc = departmentDesc;
	}

	public String getPositionDesc() {
		return positionDesc;
	}

	public void setPositionDesc(String positionDesc) {
		this.positionDesc = positionDesc;
	}

	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}

	public List<RoleDto> getCurrentPageRoleDtoes() {
		return currentPageRoleDtoes;
	}

	public void setCurrentPageRoleDtoes(List<RoleDto> currentPageRoleDtoes) {
		this.currentPageRoleDtoes = currentPageRoleDtoes;
	}

	public String getOriginpassword() {
		return originpassword;
	}

	public void setOriginpassword(String originpassword) {
		this.originpassword = originpassword;
	}

}
