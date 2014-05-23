package com.paftp.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.User;
import com.paftp.service.user.UserService;
import com.paftp.util.SSHClient;
import com.paftp.util.Util;

@Controller
public class LoginAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;

	private String alias;
	private String password;
	private String originpassword;

	private Util util = new Util();
	private SessionMap<String, Object> sessionMap;

	public String login() {

		HttpServletRequest request = ServletActionContext.getRequest();
		
		User user = null;

		if (this.getAlias() == null || this.getPassword() == null){
			request.setAttribute("error", "Account or Password can't be empty!");
			return "error";
		}
			
		String password_md5 = util.md5Encryption(this.password);
		user = userService.findUserByAliasAndPassword(alias, password_md5);

		if (user != null) {

			sessionMap.put("user", user);
			if(user.getStatus().equals("initial"))
				return "update";

			return "logsuccess";
		} else {
			request.setAttribute("error", "Account is not exist!");
			return "error";
		}

	}

	public String logout() {
		if (sessionMap != null) {
			sessionMap.invalidate();
		}
		return "success";
	}

	public String getbakpwd() throws IOException {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getAlias() == null) {
			request.setAttribute("error", "Your account can't be empty!");
			return "error";
		}

		User user = null;

		user = userService.findUserByAlias(this.getAlias());

		if (user == null) {
			request.setAttribute("error", "The account is not exist!");
			return "error";
		}

		String newpwd = "test2";
		//String newpwd = RandomString(12);
		//request.setAttribute("newpassword", newpwd);
		//this.sendMail(user);
		String password_md5 = util.md5Encryption(newpwd);
		
		user.setPassword(password_md5);
		
		userService.updateUser(user);
		
		request.setAttribute("alias", this.getAlias());
		
		return "success";
	}

	public String changepwd(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		if (this.getAlias() == null || this.getPassword() == null || this.getOriginpassword() == null) {
			request.setAttribute("error", "Your account or password can't be empty!");
			return "error";
		}
		
		String orignpassword_md5 = util.md5Encryption(this.getOriginpassword());
		User dbUser = userService.findUserByAliasAndPassword(this.getAlias(), orignpassword_md5);
		
		if(dbUser == null){
			request.setAttribute("error", "Your orign password or account has not been verified!");
			return "error";
		}
		
		if(dbUser.getStatus().equals("initial"))
			dbUser.setStatus("old");
		
		String password_md5 = util.md5Encryption(this.password);
		dbUser.setPassword(password_md5);
				
		userService.updateUser(dbUser);
		
		sessionMap.put("user", dbUser);

		return "success";
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.sessionMap = (SessionMap) session;
	}

	@SuppressWarnings("unused")
	private Boolean sendMail(User user) throws IOException{
		SSHClient sshClient = new SSHClient();
		Boolean success = sshClient.connect("127.0.0.1", "test", "test");
		
		if(success){
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
	
	public String getOriginpassword() {
		return originpassword;
	}

	public void setOriginpassword(String originpassword) {
		this.originpassword = originpassword;
	}

	public static String RandomString(int length) {
		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random random = new Random();
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int num = random.nextInt(62);
			buf.append(str.charAt(num));
		}
		return buf.toString();
	}

}
