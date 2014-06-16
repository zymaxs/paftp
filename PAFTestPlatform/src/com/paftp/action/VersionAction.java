package com.paftp.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.service.version.VersionService;
import com.paftp.entity.User;
import com.paftp.entity.Version;

@Controller
public class VersionAction  extends ActionSupport{

	/**
	 * Lei Lei Zhang
	 */
	private static final long serialVersionUID = -3711384709023965402L;

	@Resource
	private VersionService versionService;
	
	private String version_num;
	private Integer sut_id;
	private Integer user_id;
	private Date create_time;
	
	private User user;
	
	public String createVersion(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = this.getSessionUser();
		
		if (user.getAlias().equals("admin") == false){
			request.setAttribute("error", "You has not the authority to do this!");
			return "error";
		}
		
		Version version = versionService.findVersionByVersionNum(this.getVersion_num());
		if (version != null){
			request.setAttribute("error", "The version has been exist!");
			return "error";
		}
		
		version = new Version();
		version.setVersionNum(this.getVersion_num());
		this.create_time = new Date();
		java.sql.Timestamp createdatetime = new java.sql.Timestamp(
				create_time.getTime());
		version.setCreateTime(createdatetime);
		version.setUser(user);
		
		versionService.saveVersion(version);
		
		return "success";
	}
	
	public String updateVersion(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		user = this.getSessionUser();
		
		if (user.getAlias().equals("admin") == false){
			request.setAttribute("error", "You has not the authority to do this!");
			return "error";
		}
		
		Version version = versionService.findVersionByVersionNum(this.getVersion_num());
		if (version == null){
			request.setAttribute("error", "The version is not exist!");
			return "error";
		}

		version.setVersionNum(this.getVersion_num());
		
		versionService.updateVersion(version);
		
		return "success";
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
	
	public String getVersion_num() {
		return version_num;
	}

	public void setVersion_num(String version_num) {
		this.version_num = version_num;
	}

	public Integer getSut_id() {
		return sut_id;
	}

	public void setSut_id(Integer sut_id) {
		this.sut_id = sut_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}
