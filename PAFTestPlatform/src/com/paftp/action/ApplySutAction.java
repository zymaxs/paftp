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
		setApplySut(applySut, true);

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

		User applyerUser = userService.findUserByAlias(this.getApplyer());

		ApplySut applySut = new ApplySut();
		applySut.setUser(applyerUser);
		setApplySut(applySut, false);

		applySutService.updateApplySut(applySut);

		initialRolePermissions();

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

		return "success";

	}

	public String initialSut() {

		HttpServletRequest request = ServletActionContext.getRequest();

		this.isAdmin = this.isAdmin(user.getAlias());
		if (isAdmin) {
			request.setAttribute("isAdmin", "true");
		} else {
			request.setAttribute("isAdmin", "false");
		}

		ApplySut applySut = applySutService.findApplySutByName(this
				.getSutname());

		request.setAttribute("applySut", applySut);

		return "success";

	}

	public String querySut() throws ParseException {

		HttpServletRequest request = ServletActionContext.getRequest();
		
		User applyerUser = userService.findUserByAlias(this.getApplyer());
		ApplySutStatus applySutStatus = applySutStatusService.findApplySutStatusByName(this.getStatus());
		
		Integer applyerid = null;
		Integer status_id = null;
		if (applyerUser != null) {
			applyerid = applyerUser.getId();
		}
		if(applySutStatus != null){
			status_id = applySutStatus.getId();
		}

		result = new HashMap<String, Object>();
		
		String newStartTime = this.getStarttime().replace("/", "-");
		String newEndTime = this.getEndtime().replace("/", "-");
		
		HashMap<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("name", this.getSutname());
		conditions.put("user.id", applyerid);
		conditions.put("starttime", util.stringToSqlDate(newStartTime));
		conditions.put("endtime", util.stringToSqlDate(newEndTime));
		conditions.put("status_id", status_id);

		Long pagecount = applySutService.findPagesByMultiConditions(conditions);

		if (this.getRow() == null)
			this.setRow(10);

		pages = (long) Math.ceil(pagecount / (double) this.getRow());

		List<ApplySut> applySuts = applySutService
				.findAllOrderByMultiConditions(conditions,
						Integer.parseInt(this.getPagenum()), this.getRow());

		List<ApplySutDto> applySutDtos = applySutService
				.getApplySutDto(applySuts);

		this.setApplySutDtos(applySutDtos);
		this.setPages(pages);

		return "success";
	}


	public void setApplySut(ApplySut applySut, Boolean apply){

		ApplySutStatus applySutStatus = applySutStatusService
				.findApplySutStatusById(1);

//		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//		Date now = new Date();
		
		if (apply) {
				this.applytime = new Date();
	
			applySut.setApplysutstatus(applySutStatus);
		} else {
			this.resolvetime = new Date();
			applySut.setApplysutstatus(applySutStatus);
		}

		SutGroup sutGroup = sutgroupService.findSutGroupByName(this
				.getGroupname());

		applySut.setResolvetime(resolvetime);
		applySut.setComment(this.getComment());
		applySut.setGroup(sutGroup);

		applySut.setApplytime(applytime);
		applySut.setCode(this.getCode());
		applySut.setName(this.getSutname());
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

		Sut sut = new Sut(); // Rayleigh
		sut.setCode(this.getCode());
		sut.setName(this.getSutname());
		sut.setDescription(this.getDescription());
		sutService.saveSut(sut);

		sut = sutService.findSutByName(this.getSutname());

		Role role = null;
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
		role.setSut(sut);
		roleService.saveRole(role);

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
		role2.setSut(sut);
		roleService.saveRole(role2); // Save the new system worker

		// Role adminRole = null;
		// adminRole = new Role();
		// adminRole.setName("administrator");
		// adminRole.setDescription("The admin role for the new system!");
		// adminRole.setSut(sut);
		// List<Permission> adminPermissions = permissionService.findAllList();
		// adminRole.setPermissions(adminPermissions);
		// roleService.saveRole(adminRole); // Save the new system administrator

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
}
