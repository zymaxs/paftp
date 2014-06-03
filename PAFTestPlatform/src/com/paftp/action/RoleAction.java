package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Permission;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.User;
import com.paftp.service.permission.PermissionService;
import com.paftp.service.role.RoleService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;

@Controller
public class RoleAction extends ActionSupport {

	/**
	 * Lei Lei Zhang For role creation
	 */
	private static final long serialVersionUID = 4416240262855666885L;
	@Resource
	private RoleService roleService;
	@Resource
	private UserService userService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private SutService sutService;
	private String alias;
	private String displayname;
	private String role;
	private String operation;
	private String description;
	private String sut_name;

	private User user = null;
	private Boolean isAdmin;
	private User queryUser = null;
	private Boolean isManager;
	
	private Integer row;
	private Integer pagenum;
	private Long pages;
	private List<Role> currentPageRoles = new ArrayList<Role>();

	public String getWorkers() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.getSessionUser();

		if (user == null)
			return "login";

		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));

		if (!isAdmin || !isManager) {
			request.setAttribute("error", "This is not a manager for this!");
			return "error";
		}

		List<String> suts = this.getManagedSut(user.getAlias());
		request.setAttribute("Suts", suts);
		List<String> roles = null;
		if (this.getIsManager()) {
			roles = this.getRoles("manager");
			request.setAttribute("Roles", roles);
		}
		if (this.getIsAdmin()) {
			roles = this.getRoles("administrator");
			request.setAttribute("Roles", roles);
		}

		List<User> managedUsers = getManagedUsers(user.getAlias());

		if (managedUsers.size() > 0) {
			request.setAttribute("Users", managedUsers);
			return "success";
		} else {
			request.setAttribute("error", "You are not a manager for this!");
			return "error";
		}

	}

	public String addWorker() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.getSessionUser();

		if (user == null)
			return "login";

		if (this.getAlias() == null || this.getSut_name() == null
				|| this.getRole() == null) {
			request.setAttribute("error",
					"The account or system or role can't be empty!");
			return "error";
		}

		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));

		if (!this.getIsAdmin() || !this.getIsManager()) {
			request.setAttribute("error", "This is not a manager for this!");
			return "error";
		}

		Role role = null;
		User applyUser = userService.findUserByAlias(this.getAlias());
		Integer sut_id = sutService.findSutByCode(this.getSut_name()).getId();
		role = roleService.findRoleBySutIdAndName(sut_id, this.getRole());
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		applyUser.setRoles(roles);
		userService.updateUser(applyUser);

		return "success";
	}

	public String initialRoles() {

		HttpServletRequest request = ServletActionContext.getRequest();

		Sut sut = sutService.findSutByName(this.getSut_name());

		List<Role> roles = sut.getRole_results();

		row = 10;
		pages = (long) Math.ceil(roles.size() / (double) row);
		Role role = null;
		for (int i = 0; i< row; i++){
			if (i < roles.size()){
			role = roleService.findRoleById(roles.get(i).getId());
			currentPageRoles.add(role);
			}else{
				break;
			}
		}

		request.setAttribute("pages", pages);
		request.setAttribute("currentPageRoles", roles);

		return "success";
	}

	public String queryRoles() {

		HttpServletRequest request = ServletActionContext.getRequest();

		Sut sut = sutService.findSutByName(this.getSut_name());
		List<Role> roles = sut.getRole_results();
		
		User user = userService.findUserByAlias(this.getAlias());
		
		Role role = null;
		for(int i=0; i<roles.size(); i++){
			role = roleService.findRoleById(roles.get(i).getId());
			List<User> users = role.getUsers();
			for (int j=0; j<users.size(); j++){
				if(users.get(j).getAlias().equals(user.getAlias())){
					request.setAttribute("user", user);
					return "success";
				}
			}
		}

		return "success";
	}

	public List<String> getManagedSut(String alias) {

		String sutName;
		List<String> sut_names = new ArrayList<String>();
		List<Role> managerRoles = userService.findUserByAlias(alias).getRoles();
		for (int i = 0; i < managerRoles.size(); i++) {
			if (managerRoles.get(i).getName().equals("administator")) {
				List<Sut> suts = sutService.findAllList(); // Rayleigh
				for (int j = 0; j < suts.size(); j++) {
					sut_names.add(j, suts.get(j).getName());
				}
				return sut_names;
			} else {
				sutName = managerRoles.get(i).getSut().getName();
				sut_names.add(sutName);
			}

		}

		return sut_names;
	}

	public List<String> getRoles(String roleName) {
		List<Role> roles = roleService.findAllList();
		List<String> names = new ArrayList<String>();
		for (int i = 0; i < roles.size(); i++) {
			if (!roles.get(i).getName().equals("administrator")
					&& !roles.get(i).getName().equals(roleName))
				names.add(i, roles.get(i).getName());
		}
		return names;
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

	private Boolean isManager(String alias) {
		user = userService.findUserByAlias(alias);
		List<Role> roles = user.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName().equals("manager")) {
				return true;
			}
		}
		return false;
	}

	private List<User> getManagedUsers(String alias) {

		List<User> managedUsers = new ArrayList<User>();

		User currentUser = userService.findUserByAlias(alias); // find the
																// current user
																// in database
		List<Role> roles = currentUser.getRoles(); // query the roles of current
													// manager

		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName() == "manager") {
				List<Role> workerRoles = roleService.findRoleBySutId(roles.get(
						i).getId()); // get all the roles under the managed
										// system under current manager
				for (int j = 0; j < workerRoles.size(); j++) {
					if (workerRoles.get(j).getName() == "worker") {
						List<User> workerUsers = workerRoles.get(j).getUsers();
						for (int m = 0; m < workerUsers.size(); m++) {
							managedUsers.add(m, workerUsers.get(m));
						}
					}
				}
			}
			if (roles.get(i).getName() == "administrator") {
				List<Role> workerRoles = roleService.findAllList();
				for (int j = 0; j < workerRoles.size(); j++) {
					if (workerRoles.get(j).getName() != "administrator") {
						List<User> workerUsers = workerRoles.get(j).getUsers();
						for (int m = 0; m < workerUsers.size(); m++) {
							managedUsers.add(m, workerUsers.get(m));
						}
					}
				}
			}

		}

		return managedUsers;
	}

	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public User getQueryUser() {
		return queryUser;
	}

	public void setQueryUser(User queryUser) {
		this.queryUser = queryUser;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Boolean getIsManager() {
		return isManager;
	}

	public void setIsManager(Boolean isManager) {
		this.isManager = isManager;
	}

	public String getSut_name() {
		return sut_name;
	}

	public void setSut_name(String sut_name) {
		this.sut_name = sut_name;
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
}
