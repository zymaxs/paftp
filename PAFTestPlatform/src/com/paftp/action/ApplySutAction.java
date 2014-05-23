package com.paftp.action;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.ApplySut;
import com.paftp.entity.Permission;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.User;
import com.paftp.service.ApplySut.ApplySutService;
import com.paftp.service.permission.PermissionService;
import com.paftp.service.role.RoleService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;

@Controller
public class ApplySutAction extends ActionSupport {

	/**
	 * Lei Lei For applying the new system
	 */
	private static final long serialVersionUID = -4929348834511346646L;

	@Resource
	private ApplySutService applySutService;
	@Resource
	private SutService sutService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private RoleService roleService;
	@Resource
	private UserService userService;
	private String code;
	private String name;
	private String description;
	private Date applytime;
	private String applyer;

	private Date resolvetime;
	private String action;
	private String comment;

	private String starttime;
	private String endtime;

	private Integer page;
	private Integer row;

	private User user;

	public String applySut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		if (this.getCode() == null || this.getName() == null) {
			request.setAttribute("error",
					"The SUT name or Code can't be empty!");
			return "error";
		}
		
		applySutService.findAllList();

		System.out.print("Test");
		
		ApplySut existSuts = applySutService.findApplySutByName(this.getName());
		if (existSuts != null) {
			if (existSuts.getUser().getAlias().equals(user.getAlias())) {
				request.setAttribute("error",
						"The system has been applied by yourself!");
			} else {
				request.setAttribute("error",
						"The system has been applied by others!");
			}
			return "exist";
		}

		ApplySut applySut = new ApplySut();
		applySut.setUser(user);
		setApplySut(applySut);

		applySutService.saveApplySut(applySut);

		return "success";
	}

	public String approveSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		if (this.getAction() == null) {
			request.setAttribute("error",
					"Please choose the action for this request!");
			return "error";
		}

		ApplySut applySut = new ApplySut();
		applySut.setUser(user);
		setApplySut(applySut);

		applySutService.updateApplySut(applySut);

		initialRolePermissions();

		return "success";
	}

	public String initialSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		List<ApplySut> applySuts = applySutService.findAllOrderByColumn(
				"applytime", this.getPage(), this.getRow());

		request.setAttribute("applySutList", applySuts);

		return "success";

	}

	public String querySut() throws ParseException {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		if (this.getApplyer() == null && this.getName() == null
				&& this.getStarttime() == null && this.getEndtime() == null) {
			request.setAttribute("error",
					"You must support one query condition!");
			return "error";
		}

		User applyerUser = userService.findUserByAlias(this.getApplyer());

		Integer applyerid = null;
		if (applyerUser != null) {
			applyerid = applyerUser.getId();
		}

		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("name", this.getName());
		conditions.put("user_id", applyerid);
		conditions.put("starttime", getSQLDate(this.getStarttime()));
		conditions.put("endtime", getSQLDate(this.getEndtime()));

		List<ApplySut> applySuts = applySutService
				.findAllOrderByMultiConditions(conditions, this.getPage(),
						this.getRow());

		request.setAttribute("applySutList", applySuts);

		return "success";
	}

	public java.sql.Date getSQLDate(String sourcedate) throws ParseException {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = format.parse(sourcedate);
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());
		return sqlDate;
	}

	public void setApplySut(ApplySut applySut) {

		this.applytime = new Date();
		this.resolvetime = new Date();
		
		applySut.setResolvetime(resolvetime);
		applySut.setAction(this.getAction());
		applySut.setComment(this.getComment());

		applySut.setApplytime(applytime);
		applySut.setCode(this.getCode());
		applySut.setName(this.getName());
		applySut.setDescription(this.getDescription());
	}

	public User getSessionUser() {

		HttpSession session = ServletActionContext.getRequest().getSession(
				false);

		if (session == null || session.getAttribute("user") == null) {
			return null;
		} else {
			User user = (User) session.getAttribute("user");
			return user;
		}
	}

	private void initialRolePermissions() {

		Sut sut = new Sut();
		sut.setCode(this.getCode());
		sut.setName(this.getName());
		sut.setDescription(this.getDescription());

		Role role = null;
		List<Role> roles = new ArrayList<Role>();
		Permission permission = null;
		List<Permission> permissions = null;

		role = new Role();
		role.setName("Tmanager");
		role.setDescription("The role for the system of Manager!");
		permissions = new ArrayList<Permission>();
		permission = new Permission();
		permission.setScope("work");
		permission.setOperation("all");
		permissions.add(permission);
		permission = new Permission();
		permission.setScope("manage");
		permission.setOperation("all");
		permissions.add(permission);
		role.setPermissions(permissions);
		roles.add(role);

		sut.setRole_results(roles);
		sutService.saveSut(sut); // Save the new system manager

		sut = sutService.findSutByName(this.getName());

		Role role2 = null;
		Permission permission2 = null;
		List<Permission> permissions2 = null;
		role2 = new Role();
		role2.setName("worker");
		role2.setDescription("The role for the system of Worker!");
		role2.setSut(sut);
		permissions2 = new ArrayList<Permission>();
		permission2 = permissionService.findPermissionByScope("work");
		permissions.add(permission2);
		role2.setPermissions(permissions2);
		roleService.saveRole(role2); // Save the new system worker

		// Role adminRole = null;
		// adminRole = new Role();
		// adminRole.setName("administrator");
		// adminRole.setDescription("The admin role for the new system!");
		// adminRole.setSut(sut);
		// List<Permission> adminPermissions = permissionService.findAllList();
		// adminRole.setPermissions(adminPermissions);
		// roleService.saveRole(adminRole); // Save the new system administrator

		Role adminRole = null;
		adminRole = roleService.findRoleByName("administartor");
		if (adminRole == null) {
			adminRole = new Role();
			adminRole.setName("administrator");
			adminRole.setDescription("The admin role for the new system!");
			roleService.saveRole(adminRole);
		}

	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getApplytime() {
		return applytime;
	}

	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}

	public Date getResolvetime() {
		return resolvetime;
	}

	public void setResolvetime(Date resolvetime) {
		this.resolvetime = resolvetime;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getApplyer() {
		return applyer;
	}

	public void setApplyer(String applyer) {
		this.applyer = applyer;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

}
