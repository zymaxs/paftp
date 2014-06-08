package com.paftp.action;

import java.io.IOException;
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
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.dto.ApplySutDto;
import com.paftp.entity.ApplySut;
import com.paftp.entity.ApplySutStatus;
import com.paftp.entity.Permission;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.SutGroup;
import com.paftp.entity.User;
import com.paftp.service.ApplySut.ApplySutService;
import com.paftp.service.StaticColumn.ApplySutStatusService;
import com.paftp.service.StaticColumn.SutGroupService;
import com.paftp.service.permission.PermissionService;
import com.paftp.service.role.RoleService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

@Controller
public class ApplySutAction extends ActionSupport {

	/**
	 * Lei Lei For applying the new system
	 */
	private static final long serialVersionUID = -4929348834511346646L;

	@Resource
	private ApplySutService applySutService;
	@Resource
	private ApplySutStatusService applySutStatusService;
	@Resource
	private SutService sutService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private RoleService roleService;
	@Resource
	private UserService userService;
	@Resource
	private SutGroupService sutgroupService;
	private Integer id;

	private String code;
	private String sutname;
	private String description;
	private Date applytime;
	private String applyer;
	private String groupname;

	private Date resolvetime;
	private String status;
	private String comment;

	private String starttime;
	private String endtime;

	private String pagenum;
	private Integer row;
	private Long pages;

	private Boolean isAdmin;

	private User user;
	private HashMap<String, Object> result;
	private List<ApplySutDto> applySutDtos;

	private Util util = new Util();

	public String applySut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		if (isSeniorManager(user.getAlias()) == false) {
			request.setAttribute("error",
					"The user hasn't authority to do this!");
			return "error";
		}

		if (this.getCode() == null || this.getSutname() == null) {
			request.setAttribute("error",
					"The SUT name or Code can't be empty!");
			return "error";
		}

		ApplySut existSuts = applySutService.findApplySutByName(this
				.getSutname());
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
		applySut = setApplySut(applySut, this.getStatus());

		applySutService.saveApplySut(applySut);

		return "success";
	}

	public String approveSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();

		if (user == null)
			return "login";

		this.isAdmin = this.isAdmin(user.getAlias());

		if (this.getStatus() == null) {
			request.setAttribute("error",
					"Please choose the action for this request!");
			return "error";
		}

		if (!this.isAdmin) {
			request.setAttribute("error", "You are not the admin to do this!");
			return "error";
		}
		ApplySut applySut = applySutService.findApplySutByName(this
				.getSutname());

		applySut = setApplySut(applySut, this.getStatus());
		applySutService.updateApplySut(applySut);

		return "success";

	}

	public String initialSuts() throws IOException {

		HttpServletRequest request = ServletActionContext.getRequest();

		result = new HashMap<String, Object>();

		row = 10;

		pages = (long) Math.ceil(applySutService.findPages() / (double) row);

		List<ApplySut> applySuts = applySutService
				.findAllOrderByColumnPagination(1, this.getRow());

		request.setAttribute("pages", pages);
		request.setAttribute("suts", applySuts);
		request.setAttribute("flag", "true");

		// generateAdminAndManager();

		user = getSessionUser();
		if (user != null && this.isSeniorManager(user.getAlias()) == true)
			request.setAttribute("isSeniormanager", true);

		return "success";

	}

	public String initialSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = getSessionUser();
		if (user != null) {
			this.isAdmin = this.isAdmin(user.getAlias());
			if (isAdmin) {
				request.setAttribute("isAdmin", "true");
			}
		}

		ApplySut applySut = applySutService.findApplySutById(this.getId());

		request.setAttribute("applySut", applySut);

		return "success";

	}

	public String querySut() throws ParseException {

		User applyer = userService.findUserByAlias(this.getApplyer());
		
		Integer applyer_id = null;
		if (this.getApplyer() != null && applyer == null){
			applyer_id = -1;
		}else if(applyer != null){
			applyer_id = applyer.getId();
		}
		

		result = new HashMap<String, Object>();

		String newStartTime = this.getStarttime().replace("/", "-");
		String newEndTime = this.getEndtime().replace("/", "-");

		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("name", this.getSutname());
		conditions.put("user.id", applyer_id);
		conditions.put("starttime", util.stringToSqlDate(newStartTime));
		conditions.put("endtime", util.stringToSqlDate(newEndTime));

		Long pagecount = applySutService.findPagesByMultiConditions(conditions);

		if (this.getRow() == null)
			this.setRow(10);
		
		if (pagecount > 0){
		pages = (long) Math.ceil(pagecount / (double) this.getRow());
		}else {
			pages = (long) 1;
		}

		List<ApplySut> applySuts = applySutService
				.findAllOrderByMultiConditions(conditions,
						Integer.parseInt(this.getPagenum()), this.getRow());

		List<ApplySutDto> applySutDtos = applySutService
				.getApplySutDto(applySuts);

		this.setApplySutDtos(applySutDtos);
		this.setPages(pages);

		return "success";
	}

	public String updateSut() {

		ApplySut applySut = applySutService.findApplySutById(this.getId());

		User user = userService.findUserByAlias(applySut.getUser().getAlias());
		applySut.setUser(user);
		SutGroup sutgroup = sutgroupService.findSutGroupByName(this
				.getGroupname());
		applySut.setGroup(sutgroup);
		ApplySutStatus applySutStatus = applySutStatusService
				.findApplySutStatusByName(applySut.getApplysutstatus()
						.getName());
		applySut.setApplysutstatus(applySutStatus);

		applySut.setCode(this.getCode());
		applySut.setName(this.getSutname());
		applySut.setComment(this.getComment());
		applySut.setDescription(this.getDescription());

		this.resolvetime = new Date();
		applySut.setResolvetime(this.getResolvetime());

		applySutService.saveApplySut(applySut);

		return "success";
	}

	public String queryGroups() {

		HttpServletRequest request = ServletActionContext.getRequest();

		List<SutGroup> sutgroups = sutgroupService.findAllList();

		request.setAttribute("sutgroups", sutgroups);
		request.setAttribute("flag", "true");

		return "success";
	}

	private ApplySut setApplySut(ApplySut applySut, String status) {

		if (status == null) {
			status = "Pending";
		}

		ApplySutStatus applySutStatus = applySutStatusService
				.findApplySutStatusByName(status);

		// SimpleDateFormat format = new
		// SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		// Date now = new Date();

		if (applySutStatus.getId() == 1) { // status: �����
			this.applytime = new Date();
			java.sql.Timestamp applydatetime = new java.sql.Timestamp(applytime.getTime());
			applySut.setApplytime(applydatetime);

			applySut.setApplysutstatus(applySutStatus);

			applySut.setCode(this.getCode());
			applySut.setName(this.getSutname());
			applySut.setDescription(this.getDescription());
			SutGroup group = sutgroupService.findSutGroupByName(this
					.getGroupname());
			applySut.setGroup(group);
		} else { // status: ͨ����߾ܾ�
			this.resolvetime = new Date();
			java.sql.Timestamp resolvedatetime = new java.sql.Timestamp(resolvetime.getTime());
			applySut.setApplysutstatus(applySutStatus);
			SutGroup sutGroup = sutgroupService.findSutGroupByName(this
					.getGroupname());
			applySut.setResolvetime(resolvedatetime);
			applySut.setComment(this.getComment());
			applySut.setGroup(sutGroup);

			if (applySutStatus.getId() == 3) { // if pass then create the
												// corresponding permissions

				initialRolePermissions(applySut.getUser());

			}
		}

		return applySut;

	}

	private User getSessionUser() {

		HttpSession session = ServletActionContext.getRequest().getSession(
				false);

		if (session == null || session.getAttribute("user") == null) {
			return null;
		} else {
			User user = (User) session.getAttribute("user");
			return user;
		}
	}

	private void initialRolePermissions(User user) {

		Sut sut = new Sut();
		if (sutService.findSutByName(this.getSutname()) == null) {
			sut.setCode(this.getCode());
			sut.setName(this.getSutname());
			sut.setDescription(this.getDescription());
			SutGroup group = sutgroupService.findSutGroupByName(this
					.getGroupname());
			sut.setGroup(group);
			sutService.saveSut(sut);
		}

		sut = sutService.findSutByName(this.getSutname());

		Role role = null;
		Permission firstpermission = null;
		Permission secondpermission = null;
		List<Permission> permissions = null;

		role = new Role();
		role.setName(sut.getName() + "Manager");
		role.setDescription(sut.getName() + "Manager");
		permissions = new ArrayList<Permission>();
		if (permissionService.findPermissionByScope("work") == null) {
			firstpermission = new Permission();
			firstpermission.setScope("work");
			firstpermission.setOperation("all");
			permissionService.savePermission(firstpermission);
		} else {
			firstpermission = permissionService.findPermissionByScope("work");
		}

		if (permissionService.findPermissionByScope("manage") == null) {
			secondpermission = new Permission();
			secondpermission.setScope("manage");
			secondpermission.setOperation("all");
			permissionService.savePermission(secondpermission);
		} else {
			secondpermission = permissionService
					.findPermissionByScope("manage");
		}

		permissions.add(firstpermission);
		permissions.add(secondpermission);
		role.setPermissions(permissions);
		role.setSut(sut);

		Role role2 = null;
		Permission permission2 = null;
		List<Permission> permissions2 = null;
		role2 = new Role();
		role2.setName(sut.getName() + "Sdet");
		role2.setDescription("The role is:" + sut.getName());
		role2.setSut(sut);
		permissions2 = new ArrayList<Permission>();
		permission2 = permissionService.findPermissionByScope("work");
		permissions2.add(permission2);
		role2.setPermissions(permissions2);
		role2.setSut(sut);

		if (roleService.findRoleByName(sut.getName() + "Manager") == null) {
			roleService.saveRole(role);
			User applyer = userService.findUserByAlias(user.getAlias());
			applyer.getRoles().add(role);
			userService.saveUser(applyer);
		}
		if (roleService.findRoleByName(sut.getName() + "Sdet") == null) {
			roleService.saveRole(role2); // Save the new system worker
		}

	}

	private void generateAdminAndManager() {
		if (roleService.findRoleByName("administrator") == null) {
			User user = userService.findUserByAlias("admin");
			List<Role> roles = new ArrayList<Role>();

			Role adminRole = new Role();
			adminRole.setName("administrator");
			adminRole.setDescription("The admin role!");
			List<Permission> adminPermissions = permissionService.findAllList();
			adminRole.setPermissions(adminPermissions);

			Role managerRole = new Role();
			managerRole.setName("seniormanager");
			managerRole.setDescription("The up manager role!");
			managerRole.setPermissions(adminPermissions);

			roleService.saveRole(adminRole); // Save the new system
												// administrator
			roleService.saveRole(managerRole);

			roles.add(adminRole);
			user.setRoles(roles);
			userService.updateUser(user);
		}
	}

	private Boolean isAdmin(String alias) {
		user = userService.findUserByAlias(alias);
		List<Role> roles = user.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName().equals("administrator")) {
				return true;
			}
		}
		return false;
	}

	private Boolean isSeniorManager(String alias) {
		user = userService.findUserByAlias(alias);
		List<Role> roles = user.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName().equals("seniormanager")) {
				return true;
			}
		}
		return false;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getPagenum() {
		return pagenum;
	}

	public void setPagenum(String pagenum) {
		this.pagenum = pagenum;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public HashMap<String, Object> getResult() {
		return result;
	}

	public void setResult(HashMap<String, Object> result) {
		this.result = result;
	}

	public long getPages() {
		return pages;
	}

	public void setPages(Long pages) {
		this.pages = pages;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<ApplySutDto> getApplySutDtos() {
		return applySutDtos;
	}

	public void setApplySutDtos(List<ApplySutDto> applySutDtos) {
		this.applySutDtos = applySutDtos;
	}

	public String getSutname() {
		return sutname;
	}

	public void setSutname(String sutname) {
		this.sutname = sutname;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
