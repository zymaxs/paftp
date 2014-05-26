package com.paftp.action;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.entity.Department;
import com.paftp.entity.Position;
import com.paftp.service.StaticColumn.DepartmentService;
import com.paftp.service.StaticColumn.PositionService;
import com.paftp.service.user.UserService;
import com.paftp.util.SSHClient;
import com.paftp.util.Util;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class RegisterAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;
	@Resource
	private DepartmentService departmentService;
	@Resource
	private PositionService positionService;

	private String alias;
	private String password;
	private String status;
	private String displayname;
	private Date createtime;
	private Integer department;
	private Integer position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	private Util util = new Util();

	public String register() {

		HttpServletRequest request = ServletActionContext.getRequest();

		User user = userService.findUserByAlias(alias);

		if (user != null) {
			request.setAttribute("error", "���û��Ѵ���!");
			return "exist";
		}

		if (this.getAlias() == null || this.getdepartmentId() == null
				|| this.getPositionId() == null)
			return "error";

		user = new User();

		setRegisterInfor(user);

		userService.saveUser(user);

		// this.sendMail(user);

		request.setAttribute("alias", user.getAlias());

		return "success";

	}

	private void setRegisterInfor(User user) {

		this.createtime = new Date();
		this.password = util.md5Encryption("test"); /*
													 * Temp password and send it
													 * to SMTP in future!
													 */
		user.setAlias(this.getAlias());
		user.setDisplayName(this.getDisplayname());
		user.setCreateTime(this.getCreatetime());
		user.setPassword(this.getPassword());
		user.setStatus("initial");

		UserInfo userInfo = new UserInfo();
		Department department = departmentService.findDepartmentById(this.getdepartmentId());
		userInfo.setDepartment(department);
		userInfo.setMobile(this.getMobile());
		Position position = positionService.findPositionById(this.getPositionId());
		userInfo.setPosition(position);
		userInfo.setTelephone(this.getTelephone());
		userInfo.setOtherinfo(this.getOtherinfo());
		userInfo.setOthermail(this.getOthermail());
		user.setUserInfo(userInfo);

	}

	@SuppressWarnings("unused")
	private Boolean sendMail(User user) throws IOException {
		SSHClient sshClient = new SSHClient();
		Boolean success = sshClient.connect("127.0.0.1", "test", "test");

		if (success) {
			sshClient.execute("");
			return true;
		}

		return false;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}

	public Integer getdepartmentId() {
		return department;
	}

	public void setdepartmentId(Integer department) {
		this.department = department;
	}

	public Integer getPositionId() {
		return position;
	}

	public void setPositionId(Integer position) {
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

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

}
