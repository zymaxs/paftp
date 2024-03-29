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
	private String rolealias;
	private String displayname;
	private String operation;
	private String description;
	private String sut_name;
	private String role_name;
	private String sut_id;
	
	private User user = null;
	private Boolean isAdmin;
	private User queryUser = null;
	private Boolean isManager;

	private Integer row;
	private Integer pagenum;
	private String prompt;

	private Long pages;
	private List<User> resultusers = new ArrayList<User>();

	List<User> managers = new ArrayList<User>();
	List<User> workers = new ArrayList<User>();
	List<User> freeusers = new ArrayList<User>();
	List<User> seniormanagers = new ArrayList<User>();
	List<User> normalusers = new ArrayList<User>();
	List<User> nonmanagers = new ArrayList<User>();

	private String managerstring;
	private String workerstring;
	private String seniormanagerstring;

	private Util util = new Util();

	public String initialAddRelationship() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.sessionUser();
		if (user == null){
			request.setAttribute("error", "请登录后进行操作");
			return "error";
		}
		
		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));

		if (isAdmin) {
			if (this.getSut_id() == null) {
				this.setRole_name("seniormanager");
			} else {
				this.setSut_name(sutService.findSutById(Integer.parseInt(this.getSut_id())).getName());
				this.setRole_name(this.getSut_name() + "Manager");
			}
		} else if (isManager) {
			this.setSut_name(sutService.findSutById(Integer.parseInt(this.getSut_id())).getName());
			this.setRole_name(this.getSut_name() + "Worker");
		} else {
			request.setAttribute("error", "This is not a manager for this!");
			return "error";
		}

		List<User> users = userService.findAllList();

		for (int i = 0; i < users.size(); i++) {
			List<Role> roles = users.get(i).getRoles();
			int j;
			boolean freeuser = true;
			boolean normaluser = true;
			for (j = 0; j < roles.size(); j++) {
				if (roles.get(j).getName().equals("administrator")) {
					freeuser = false;
					normaluser = false;
					break;
				} else if (roles.get(j).getName().equals("seniormanager")
						&& normaluser == true) {
					seniormanagers.add(users.get(i));
					normaluser = false;
				}

				if (roles.get(j).getName()
						.equals(this.getSut_name() + "Manager")) {
					if (user.getAlias().equals(users.get(i).getAlias())) {
						freeuser = false;
						break;
					} else {
						managers.add(users.get(i));
						freeuser = false;
						break;
					}
				} else if (roles.get(j).getName()
						.equals(this.getSut_name() + "Sdet")) {
					if (user.getAlias().equals(users.get(i).getAlias())) {
						freeuser = false;
						break;
					} else {
						workers.add(users.get(i));
						nonmanagers.add(users.get(i));
						freeuser = false;
						break;
					}
				}
			}
			if (normaluser) {
				normalusers.add(users.get(i));
			}
			if (freeuser) {
				freeusers.add(users.get(i));
				nonmanagers.add(users.get(i));
			}
		}

		request.setAttribute("managers", managers);
		request.setAttribute("nonmanagers", nonmanagers);
		request.setAttribute("workers", workers);
		request.setAttribute("freeusers", freeusers);
		request.setAttribute("seniormanagers", seniormanagers);
		request.setAttribute("normalusers", normalusers);
		request.setAttribute("role", this.getRole_name());
		if (this.getIsAdmin())
			request.setAttribute("isAdmin", isAdmin);
		if (this.getIsManager())
			request.setAttribute("isManager", isManager);
		request.setAttribute("flag", true);
		request.setAttribute("sut_id", this.getSut_id());

		return "success";
	}

	public String addRelationship() {

		HttpServletRequest request = ServletActionContext.getRequest();

		user = this.sessionUser();

		setIsAdmin(isAdmin(user.getAlias()));
		setIsManager(isManager(user.getAlias()));// Verify whether this needs to
													// be initialed!
		Role sdet_role = new Role();
		Sut sut = null;
		if (isAdmin || isManager) {
			String[] updateusers = null;
			if (isAdmin) {
				if (this.getSut_id() == null
						|| this.getSut_id().equals("null")) {
					this.setRole_name("seniormanager");
					updateusers = util.splitString(this
							.getSeniormanagerstring());
				} else {
					sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
					this.setSut_name(sut.getName());
					this.setRole_name(sut.getName() + "Manager");
					updateusers = util.splitString(this.getManagerstring());
					sdet_role = roleService.findRoleByName(sut.getName() + "Sdet");
				}
			} else {
				sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
				this.setSut_name(sut.getName());
				this.setRole_name(sut.getName() + "Sdet");
				updateusers = util.splitString(this.getWorkerstring());
			}
			Role role = roleService.findRoleByName(this.getRole_name());

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
						if (user != null){
						user.getRoles().add(role);
						if (role.getName().equals(this.getSut_name() + "Manager")){ 
							user.getRoles().remove(sdet_role);
						}
						updatedusers.add(user);
						changenum++;
						}
					}

				}
			}
			for (int l = 0; l < managedusers.size(); l++) {
				User user = managedusers.get(l);
				user.getRoles().remove(role);
				if (role.getName().equals(this.getSut_name() + "Manager")){ 
					user.getRoles().add(sdet_role);
				}
				updatedusers.add(user);
			}
			if (changenum > 0 || managedusers.size() > 0) {
				for (i = 0; i < updatedusers.size(); i++) {
					userService.saveUser(updatedusers.get(i));
				}
			}

		} else {
			request.setAttribute("error", "You are not a manager for this!");
			return "error";
		}

		request.setAttribute("sut_id", this.getSut_id());

		return "success";
	}

	public String initialRoles() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getSut_id() == null) {
			request.setAttribute("error", "One sut must be given!");
			return "error";
		}

		//Sut sut = sutService.findSutByName(this.getSut_name());
		Sut sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
		
		if (sut == null) {
			request.setAttribute("error", "The sut is not exist!");
			return "error";
		}

		List<Role> roles = sut.getRole_results();

		this.setRow(10);
		int number = 0;
		Role role = new Role();
		pages = (long) Math.ceil(roles.size() / (double) row);
		for (int i = 0; i < roles.size(); i++) {
				if (number < this.getRow()){
				role = roles.get(i);
				List<Role> currentroles = new ArrayList<Role>();
				if (role.getName().equals(sut.getName() + "Manager")){
					role.setName("管理员");
				}else if (role.getName().equals(sut.getName() + "Sdet")){
					role.setName("成员");
				}
				currentroles.add(role);
				for (int j = 0; j< role.getUsers().size(); j++){
					User temp_user = new User();
					temp_user.setId(role.getUsers().get(j).getId());
					temp_user.setAlias(role.getUsers().get(j).getAlias());
					temp_user.setDisplayName(role.getUsers().get(j).getDisplayName());
					temp_user.setRoles(currentroles);
					resultusers.add(temp_user);
					number ++;
				}
				}else{
					break;
				}
		}

		request.setAttribute("pages", pages);
		request.setAttribute("resultusers", resultusers);
		request.setAttribute("sut_name", sut.getName());
		request.setAttribute("flag", true);

		return "success";
	}

	public String queryRoles() {

		if (this.getSut_name() == null) {
			this.setPrompt("One sut must be given!");
			return "success";
		}

		Sut sut = sutService.findSutByName(this.getSut_name());
		List<Role> roles = sut.getRole_results();

		if(this.getRow() == null) {
			this.setRow(10);
		} 
		if (this.getPagenum() == null){
			this.setPagenum(1);
		}
		pages = (long) Math.ceil(roles.size() / (double) row);

		User conditionuser = null;
		if (this.getRolealias() != null
				&& this.getRolealias().equals("") == false) {
			conditionuser = userService.findUserByAlias(this.getRolealias());
		}
		Role conditionrole = null;
		if (this.getRole_name() != null
				&& this.getRole_name().equals("") == false) {
			if (this.getRole_name().equals("管理员")) {
				conditionrole = roleService.findRoleByName(sut.getName() + "Manager");
			} else if (this.getRole_name().equals("成员")){
				conditionrole = roleService.findRoleByName(sut.getName() + "Sdet");
			}
			else {
				conditionrole = roleService.findRoleByName(sut.getName() + this.getRole_name());
			}
		}

		Role role = null;
		int number = 0;
		Integer start = (this.getPagenum()-1) * 10;
		Integer end = start + this.getRow();
		for (int i = 0; i < roles.size(); i++) {
			role = roleService.findRoleById(roles.get(i).getId());
			if ((this.getRole_name() == null || this.getRole_name().equals(""))
					|| (conditionrole != null && role.getId().equals(conditionrole.getId()))) {
				List<User> users = role.getUsers();
				for (int j = 0; j < users.size(); j++) {
					if (this.getRolealias() == null || this.getRolealias().equals("") || (conditionuser != null && users.get(j).getAlias().equals(conditionuser.getAlias()))) {
						if (number >= start && number < end){
						Role temp_role = new Role();
						if (role.getName().equals(sut.getName() + "Manager")){
							temp_role.setName("管理员");
							temp_role.setDescription(role.getDescription());
						}else if (role.getName().equals(sut.getName() + "Sdet")){
							temp_role.setName("成员");
							temp_role.setDescription(role.getDescription());
						}
						List<Role> currentroles = new ArrayList<Role>();
						currentroles.add(temp_role);
						User temp_user = new User();
						temp_user.setAlias(users.get(j).getAlias());
						temp_user.setDisplayName(users.get(j).getDisplayName());
						temp_user.setRoles(currentroles);
						this.resultusers.add(temp_user);    //User dto for the out of memory issue
						}
						if (number == end){
							break;
						}
						number ++;
						}
				}
			}
		}

		this.setResultusers(resultusers);
		this.setPages(pages);

		return "success";
	}

//	private List<String> getManagedSut(String alias) {
//
//		String sutName;
//		List<String> sut_names = new ArrayList<String>();
//		List<Role> managerRoles = userService.findUserByAlias(alias).getRoles();
//		for (int i = 0; i < managerRoles.size(); i++) {
//			if (managerRoles.get(i).getName().equals("administator")) {
//				List<Sut> suts = sutService.findAllList(); // Rayleigh
//				for (int j = 0; j < suts.size(); j++) {
//					sut_names.add(j, suts.get(j).getName());
//				}
//				return sut_names;
//			} else {
//				sutName = managerRoles.get(i).getSut().getName();
//				sut_names.add(sutName);
//			}
//
//		}
//
//		return sut_names;
//	}

//	private List<String> getRoles(String roleName) {
//		List<Role> roles = roleService.findAllList();
//		List<String> names = new ArrayList<String>();
//		for (int i = 0; i < roles.size(); i++) {
//			if (!roles.get(i).getName().equals("administrator")
//					&& !roles.get(i).getName().equals(roleName))
//				names.add(i, roles.get(i).getName());
//		}
//		return names;
//	}

	
//private List<User> getSpecialPageUsers(List<User> users){
//		
//		Integer start = (this.getPagenum()-1) * 10;
//		List<User> return_users = new ArrayList<User>();
//		
//		for(int i = start; i< (start+this.getRow()); i++){
//			if (i == users.size()){
//				break;
//			}
//			return_users.add(users.get(i));
//		}
//		
//		return return_users;
//	}

	private User sessionUser() {

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
		Sut sut = null;
		if (this.getSut_id() != null){
			sut = sutService.findSutById(Integer.parseInt(this.getSut_id()));
		} else {
			if (this.getSut_name() != null){
				sut = sutService.findSutByName(this.getSut_name());
			}
		}
		if (sut != null){
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName().equals(sut.getName() + "Manager")) {
				return true;
			}
		}
		}
		return false;
	}

//	private List<User> getManagedUsers(String alias) {
//
//		List<User> managedUsers = new ArrayList<User>();
//
//		User currentUser = userService.findUserByAlias(alias); // find the
//																// current user
//																// in database
//		List<Role> roles = currentUser.getRoles(); // query the roles of current
//													// manager
//
//		for (int i = 0; i < roles.size(); i++) {
//			if (roles.get(i).getName() == "manager") {
//				List<Role> workerRoles = roleService.findRoleBySutId(roles.get(
//						i).getId()); // get all the roles under the managed
//										// system under current manager
//				for (int j = 0; j < workerRoles.size(); j++) {
//					if (workerRoles.get(j).getName() == "worker") {
//						List<User> workerUsers = workerRoles.get(j).getUsers();
//						for (int m = 0; m < workerUsers.size(); m++) {
//							managedUsers.add(m, workerUsers.get(m));
//						}
//					}
//				}
//			}
//			if (roles.get(i).getName() == "administrator") {
//				List<Role> workerRoles = roleService.findAllList();
//				for (int j = 0; j < workerRoles.size(); j++) {
//					if (workerRoles.get(j).getName() != "administrator") {
//						List<User> workerUsers = workerRoles.get(j).getUsers();
//						for (int m = 0; m < workerUsers.size(); m++) {
//							managedUsers.add(m, workerUsers.get(m));
//						}
//					}
//				}
//			}
//
//		}
//
//		return managedUsers;
//	}

//	private Boolean isSeniorManager(String alias) {
//		user = userService.findUserByAlias(alias);
//		List<Role> roles = user.getRoles();
//		for (int i = 0; i < roles.size(); i++) {
//			if (roles.get(i).getName().equals("seniormanager")) {
//				return true;
//			}
//		}
//		return false;
//	}

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

	public Boolean getIsManager() {
		return isManager;
	}

	public void setIsManager(Boolean isManager) {
		this.isManager = isManager;
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

	public String getRolealias() {
		return rolealias;
	}

	public void setRolealias(String rolealias) {
		this.rolealias = rolealias;
	}

	public String getSut_name() {
		return sut_name;
	}

	public void setSut_name(String sut_name) {
		this.sut_name = sut_name;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	
	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}
	
	public String getSut_id() {
		return sut_id;
	}

	public void setSut_id(String sut_id) {
		this.sut_id = sut_id;
	}
}
