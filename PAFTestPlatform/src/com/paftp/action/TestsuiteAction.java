package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.stereotype.Controller;

import com.paftp.entity.Sut;
import com.paftp.entity.TestcaseStep;
import com.paftp.entity.Testcase;
import com.paftp.entity.Testsuite;
import com.paftp.entity.User;
import com.paftp.entity.UserInfo;
import com.paftp.service.Testcase.TestcaseService;
import com.paftp.service.Testsuite.TestsuiteService;
import com.paftp.service.sut.SutService;
import com.paftp.service.TestcaseStep.TestcaseStepService;
import com.paftp.service.user.UserService;
import com.paftp.util.Util;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class TestsuiteAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;
	@Resource
	private TestcaseService testcaseService;
	@Resource
	private TestsuiteService testsuiteService;
	@Resource
	private TestcaseStepService testcasestepService;
	@Resource
	private SutService sutService;

	private JSONArray jsonArray;
	private JSONObject jsonObject;
	
	private Util util = new Util();
	

	public String getTestsuites() throws ServletException, IOException {

		HttpServletRequest request = ServletActionContext.getRequest();
		List<Testsuite> testsuites = testsuiteService.findAllList();

//		JSONArray jsonarray = new JSONArray();
//		JSONObject object = new JSONObject();
//		object.put("id", "ajson1");
//		object.put("text", "Simple root node");
//		jsonarray.add(object);
//		object = new JSONObject();
//		object.put("id", "ajson2");
//		object.put("text", "Simple root node2");
//		jsonarray.add(object);
//		object = new JSONObject();
//		object.put("id", "ajson3");
//		object.put("text", "Simple root node3");
//		jsonarray.add(object);
//		object = new JSONObject();
//		object.put("id", "ajson4");
//		object.put("text", "Simple root node4");
//		jsonarray.add(object);

//		request.setAttribute("json", jsonarray);
//		request.setAttribute("flag", "true");
		

		JSONArray parentNode0 = new JSONArray();
		JSONObject childNode00 = util.childNode("login001", util.nodeType("00"), null);
		JSONObject childNode01 = util.childNode("login002", util.nodeType("00"), null);
		parentNode0.add(childNode00);
		parentNode0.add(childNode01);
		
		JSONArray parentNode00 = new JSONArray();
		JSONObject childNode000 = util.childNode("Login", util.nodeType("0"), parentNode0);
		parentNode00.add(childNode000);
		
		JSONArray parentNode1 = new JSONArray();
		JSONObject childNode10 = util.childNode("register001", util.nodeType("1"), null);
		JSONObject childNode11 = util.childNode("register002", util.nodeType("1"), null);
		parentNode1.add(childNode10);
		parentNode1.add(childNode11);
	
		JSONArray rootNode = util.rootNode(parentNode00, parentNode1);
		
		this.setJsonArray(rootNode);
//		this.setJsonStr(jsonarray);
		
		return "success";

	}

	

	public JSONArray getJsonArray() {
		return jsonArray;
	}

	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}

	public JSONObject getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(JSONObject jsonObject) {
		this.jsonObject = jsonObject;
	}
	
	

}
