package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.paftp.entity.Auth;
import com.paftp.entity.Sut;
import com.paftp.entity.Team;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.auth.AuthService;
import com.paftp.service.sut.SutService;
import com.paftp.service.team.TeamService;
import com.paftp.service.user.UserService;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class IndexAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;
	@Resource
	private TeamService teamService;
	@Resource
	private AuthService authService;
	
	@Resource
	private TestcaseService testcaseService;
	@Resource
	private TestsuiteService testsuiteService;
	@Resource
	private SutService sutService;
	
	
	private String username;
	private String password;

	public String index() {

		HttpServletRequest request = ServletActionContext.getRequest();

		//Team team = teamService.findTeamByName("team2");
		// Team team = users.get(0).getTeam();

		Testsuite testsuite = testsuiteService.findTestsuiteById(1);
//		testsuite.setId(1);
//		testsuite.setName("Ts_Login");
//		
//		testsuite.setSut(sutService.findSutById(1));
		//testsuiteService.saveTestsuite(testsuite);
		
		if (testsuite != null) {
			testsuiteService.deleteTestsuite(testsuite);
//			Testcase testcase = new Testcase();
//
//			testcase.setCaseName("Tc_Login_0001");
//			User creator = userService.findUserById(1);
//			testcase.setCreator(creator);
//			testcase.setTestsuite(testsuite);
//			//testcaseService.saveTestcase(testcase);
//			List<Testcase> testcases = new ArrayList<Testcase>();
//			
//			testcases.add(testcase);
//			testsuite.setTestcases(testcases);
//			testsuiteService.saveTestsuite(testsuite);

//			List<Auth> auths = new ArrayList<Auth>();
//			Auth auth = authService.findAuthById(1);
//			auths.add(auth);
//			User user = userService.findUserById(3);
//			user.setAuths(auths);
//			userService.updateUser(user);
			// List<User> users = userService.findAllList()

			// teamService.deleteTeam(team);
			// teamService.deleteTeam(team);
			// User user = userService.findUserById(2);
			// userService.deleteUser(user);
			// userService.saveUser(user);
			// List<User> users = userService.findAllList();
			// for(int i=0;i<users.size();i++){
			// if(users.get(i).getTeam()==null){
			// users.get(i).setTeam(team);
			// userService.updateUser(users.get(i));
			// }
			// }

			request.setAttribute("testsuites", testsuiteService.findAllList());
			request.setAttribute("T_flag", "123");
			return "success";
		} else {
			return ERROR;
		}

	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
