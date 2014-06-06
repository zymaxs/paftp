package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Role;
import com.paftp.entity.Sut;
import com.paftp.entity.User;
import com.paftp.service.permission.PermissionService;
import com.paftp.service.role.RoleService;
import com.paftp.service.sut.SutService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;

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
	private String operation;
	private String description;
	private String sutname;
	private String rolename;

	private User user = null;
	private Boolean isAdmin;
	private User queryUser = null;
	private Boolean isManager;

	private Integer row;
	private Integer pagenum;
	private Long pages;
	private List<Role> currentPageRoles = new ArrayList<Role>();
	private List<User> resultusers = new ArrayList<User>();

	List<User> managers = new ArrayList<User>();
	List<User> workers = new ArrayList<User>();
	List<User> freeusers = new ArrayList<User>();
	List<User> seniormanagers = new ArrayList<User>();
	List<User> normalusers = new ArrayList<User>();

	private String managerstring;
	private String workerstring;
	private String seniormanagerstring;

	private Util util = new Util();

	public String initialAddRelationship() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.getSessionUser();

		if (user == null)
			return "login";

		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));

		if (isAdmin) {
			if (this.getSutname() == null) {
				this.setRolename("seniormanager");
			} else {
				this.setRolename(this.getSutname() + "Manager");
			}
		} else if (isManager) {
			this.setRolename(this.getSutname() + "Worker");
		} else {
			request.setAttribute("error", "This is not a manager for this!");
			return "error";
		}

		List<User> users = userService.findAllList();

		for (int i = 0; i < users.size(); i++) {
			List<Role> roles = users.get(i).getRoles();
			int j;
			for (j = 0; j < roles.size(); j++) {
				if (roles.get(j).getName().equals("administrator")) {
					break;
				} else if (roles.get(j).getName().equals("seniormanager")) {
					seniormanagers.add(users.get(i));
					break;
				}

				if (roles.get(j).getName()
						.equals(this.getSutname() + "Manager")) {
					if (user.getAlias().equals(users.get(i).getAlias())) {
						break;
					} else {
						managers.add(users.get(i));
						break;
					}
				} else if (roles.get(j).getName()
						.equals(this.getSutname() + "Worker")) {
					if (user.getAlias().equals(users.get(i).getAlias())) {
						break;
					} else {
						workers.add(users.get(i));
						break;
					}
				}
			}
			if (j == roles.size()) {
				normalusers.add(users.get(i));
				freeusers.add(users.get(i));
			}
		}

		request.setAttribute("managers", managers);
		request.setAttribute("workers", workers);
		request.setAttribute("freeusers", freeusers);
		request.setAttribute("seniormanagers", seniormanagers);
		request.setAttribute("normalusers", normalusers);
		request.setAttribute("role", this.getRolename());
		if (this.getIsAdmin())
			request.setAttribute("isAdmin", isAdmin);
		if (this.getIsManager())
			request.setAttribute("isManager", isManager);
		request.setAttribute("flag", true);
		request.setAttribute("sut_name", this.getSutname());

		return "success";
	}

	public String addRelationship() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.getSessionUser();

		if (user == null)
			return "login";

		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));// Verify whether this needs to
													// be initialed!

		if (isAdmin || isManager) {
			String[] updateusers = null;
			if (isAdmin) {
				if (this.getSutname() == null
						|| this.getSutname().equals("null")) {
					this.setRolename("seniormanager");
					updateusers = util.splitString(this
							.getSeniormanagerstring());
				} else {
					this.setRolename(this.getSutname() + "Manager");
					updateusers = util.splitString(this.getManagerstring());
				}
			} else {
				this.setRolename(this.getSutname() + "Worker");
				updateusers = util.splitString(this.getWorkerstring());
			}
			Role role = roleService.findRoleByName(this.getRolename());

			List<User> managedusers = role.getUsers();
			List<User> updatedusers = new ArrayList<User>();
			int changenum = 0;
			int i;
			if (updateusers != null) {
				for (i = 0; i < updateusers.length; i++) {
					int j;
					int total = managedusers.size();
					for (j = 0; j < managedusers.size(); j++) {
						if (updateusers[i].equals(managedusers.get(j)
								.getAlias())) {
							managedusers.remove(j);
							break;
						}
					}
					if (j == total) {
						User user = userService.findUserByAlias(updateusers[i]);
						user.getRoles().add(role);
						updatedusers.add(user);
						changenum++;
					}

				}
			}
			for (int l = 0; l < managedusers.size(); l++) {
				User user = managedusers.get(l);
				user.getRoles().remove(role);
				updatedusers.add(user);
			}
			if (changenum > 0 || managedusers.size() > 0) {
				for (i = 0; i < updatedusers.size(); i++) {
					userService.saveUser(updatedusers.get(i));
				}
			}

		} else {
			request.setAttribute("error", "This is not a manager for this!");
			return "error";
		}

		return "success";
	}

	public String initialRoles() {

		HttpServletRequest request = ServletActionContext.getRequest();

		// user = this.getSessionUser();
		// if (user == null)
		// return "login";

		if (this.getSutname() == null) {
			request.setAttribute("error", "One sut must be given!");
			return "error";
		}

		Sut sut = sutService.findSutByName(this.getSutname());

		if (sut == null) {
			request.setAttribute("error", "The sut is not exist!");
			return "error";
		}

		List<Role> roles = sut.getRole_results();

		row = 10;
		pages = (long) Math.ceil(roles.size() / (double) row);
		Role role = null;
		for (int i = 0; i < row; i++) {
			if (i < roles.size()) {
				role = roleService.findRoleById(roles.get(i).getId());
				currentPageRoles.add(role);
			} else {
				break;
			}
		}

		// setIsAdmin(isAdmin(user.getAlias()));
		// setIsManager(isManager(user.getAlias()));
		//
		// request.setAttribute("isAdmin", this.getIsAdmin());
		// request.setAttribute("isManager", this.getIsManager());
		request.setAttribute("pages", pages);
		request.setAttribute("currentPageRoles", roles);
		request.setAttribute("sut_name", this.getSutname());
		request.setAttribute("flag", true);

		return "success";
	}

	public String queryRoles() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.getSessionUser();
//		if (user == null) {
////			return "error";
//		}

		if (this.getSutname() == null) {
			request.setAttribute("error", "One sut must be given!");
			return "error";
		}

		Sut sut = sutService.findSutByName(this.getSutname());
		List<Role> roles = sut.getRole_results();

		row = 10;
		pages = (long) Math.ceil(roles.size() / (double) row);

		User conditionuser = null;
		if (this.getAlias() != null) {
			conditionuser = userService.findUserByAlias(this.getAlias());
		}
		Role conditionrole = null;
		if (this.getRolename() != null) {
			conditionrole = roleService.findRoleByName(this.getRolename());
		}

		Role role = null;
		for (int i = 0; i < roles.size(); i++) {
			role = roleService.findRoleById(roles.get(i).getId());
			if (conditionrole == null
					|| role.getId().equals(conditionrole.getId())) {
				List<User> users = role.getUsers();
				for (int j = 0; j < users.size(); j++) {
					if (this.getAlias() == null
							|| (conditionuser != null && users.get(j)
									.getAlias()
									.equals(conditionuser.getAlias()))) {
						Role seniorrole = roleService
								.findRoleByName("seniormanager");
						users.get(j).getRoles().remove(seniorrole);
						this.resultusers.add(users.get(j));
					}
				}
			}
		}

		this.setResultusers(resultusers);
		this.setPages(pages);

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
			if (roles.get(i).getName().equals(this.getSutname() + "Manager")) {
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

	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
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

	public String getSutname() {
		return sutname;
	}

	public void setSutname(String sutname) {
		this.sutname = sutname;
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

	public String getRolename() {
		return rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	public List<User> getResultusers() {
		return resultusers;
	}

	public void setResultusers(List<User> resultusers) {
		this.resultusers = resultusers;
	}

	public List<User> getManagers() {
		return managers;
	}

	public void setManagers(List<User> managers) {
		this.managers = managers;
	}

	public List<User> getWorkers() {
		return workers;
	}

	public void setWorkers(List<User> workers) {
		this.workers = workers;
	}

	public List<User> getFreeusers() {
		return freeusers;
	}

	public void setFreeusers(List<User> freeusers) {
		this.freeusers = freeusers;
	}

	public String getManagerstring() {
		return managerstring;
	}

	public void setManagerstring(String managerstring) {
		this.managerstring = managerstring;
	}

	public String getWorkerstring() {
		return workerstring;
	}

	public void setWorkerstring(String workerstring) {
		this.workerstring = workerstring;
	}

	public String getSeniormanagerstring() {
		return seniormanagerstring;
	}

	public void setSeniormanagerstring(String seniormanagerstring) {
		this.seniormanagerstring = seniormanagerstring;
	}
}
