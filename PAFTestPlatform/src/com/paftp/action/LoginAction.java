package com.paftp.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Role;
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

		if (this.getAlias() == null || this.getPassword() == null) {
			request.setAttribute("error",
					"Username or Password cannot be empty!");
			return "error";
		}

		String password_md5 = util.md5Encryption(this.password);
		user = userService.findUserByAliasAndPassword(alias, password_md5);

		if (user != null) {

			// User newuser = new User();
			// newuser.setAlias(user.getAlias());
			// newuser.setStatus("old");
			// newuser.setDisplayName(user.getDisplayName());
			
			sessionMap.put("user", user);
			
			if (this.isAdmin(user.getAlias())){
				sessionMap.put("isAdmin", true);
			}else{
				sessionMap.put("isAdmin", false);
			}
			
			if (user.getStatus().equals("initial"))
				return "update";

			return "logsuccess";
		} else {
			request.setAttribute("error", "Username or Password Wrong!");
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

		String newpwd = this.getRandomString(12);
		// String newpwd = RandomString(12);
		// request.setAttribute("newpassword", newpwd);
		String password_md5 = util.md5Encryption(newpwd);

		user.setPassword(password_md5);

		userService.updateUser(user);

		Boolean mailResult = this.sendMail(user, newpwd);

		if (mailResult) {
			request.setAttribute("error", "Fail to send password to your E-Mail!");
		}

		request.setAttribute("alias", this.getAlias());

		return "success";
	}

	public String changepwd() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (this.getAlias() == null || this.getPassword() == null
				|| this.getOriginpassword() == null) {
			request.setAttribute("error",
					"Your account or password can't be empty!");
			return "error";
		}

		String orignpassword_md5 = util.md5Encryption(this.getOriginpassword());
		User dbUser = userService.findUserByAliasAndPassword(this.getAlias(),
				orignpassword_md5);

		if (dbUser == null) {
			request.setAttribute("error", "User cannot be empty!");
			return "error";
		}

		if (dbUser.getStatus().equals("initial"))
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

	private Boolean isAdmin(String alias) {
		User user = userService.findUserByAlias(alias);
		List<Role> roles = user.getRoles();
		for (int i = 0; i < roles.size(); i++) {
			if (roles.get(i).getName().equals("administrator")) {
				return true;
			}
		}
		return false;
	}
	
	private Boolean sendMail(User user, String pwd) throws IOException {
		SSHClient sshClient = new SSHClient();
		Boolean success = sshClient.connect("192.168.21.172", "wls81",
				"Paic#234");
		
		if (success) {
			if (this.isAdmin(user.getAlias())) {
				sshClient.execute("sh /wls/wls81/email-confirm/forgetpwd.sh "
						+ "duanjuding4512" + " " + pwd);
			} else {
			sshClient.execute("sh /wls/wls81/email-confirm/forgetpwd.sh "
					+ user.getAlias() + " " + pwd);
			}
			return true;
		}

		return false;
	}

	private String getRandomString(int length) {
		String str = "abcdefghigklmnopkrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ0123456789";
		Random random = new Random();
		StringBuffer sf = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(62);// 0~61
			sf.append(str.charAt(number));

		}
		return sf.toString();
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
