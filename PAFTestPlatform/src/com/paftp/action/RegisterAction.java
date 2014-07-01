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
	private String department;
	private String position;
	private String mobile;
	private String telephone;
	private String othermail;
	private String otherinfo;
	private Util util = new Util();

	public String register() {

		HttpServletRequest request = ServletActionContext.getRequest();

		User user = userService.findUserByAlias(alias);

		if (user != null) {
			request.setAttribute("error", "用户名已存在!");
			return "exist";
		}

		if (this.getAlias() == null || this.getDepartment() == null
				|| this.getPosition() == null)
			return "error";

		user = new User();

		setRegisterInfor(user);

		userService.saveUser(user);

		this.sendMail(user);

		request.setAttribute("alias", user.getAlias());

		return "success";

	}

	private void setRegisterInfor(User user) {

		this.createtime = new Date();
		String md5Password= util.md5Encryption(this.getPassword()); /*
													 * Temp password and send it
													 * to SMTP in future!
													 */
		user.setAlias(this.getAlias());
		user.setDisplayName(this.getDisplayname());
		user.setCreateTime(this.getCreatetime());
		user.setPassword(md5Password);
		user.setStatus("initial");

		UserInfo userInfo = new UserInfo();
		Department department = departmentService.findDepartmentByName(this.getDepartment());
		userInfo.setDepartment(department);
		userInfo.setMobile(this.getMobile());
		Position position = positionService.findPositionByName(this.getPosition());
		userInfo.setPosition(position);
		userInfo.setTelephone(this.getTelephone());
		userInfo.setOtherinfo(this.getOtherinfo());
		userInfo.setOthermail(this.getOthermail());
		user.setUserInfo(userInfo);

	}

	private Boolean sendMail(User user) {
		SSHClient sshClient = new SSHClient();
		Boolean success;
		try {
			success = sshClient.connect("192.168.21.172", "wls81", "Paic#234");
			
			if (success) {
				sshClient.execute("sh /wls/wls81/email-confirm/register.sh " + user.getAlias() + " " + this.getPassword());
				return true;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
