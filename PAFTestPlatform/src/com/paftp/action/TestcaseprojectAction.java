package com.paftp.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.TestcaseProject;
import com.paftp.service.StaticColumn.TestcaseProjectService;
import com.paftp.service.version.VersionService;

@Controller
public class TestcaseprojectAction  extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8012510022473028356L;
	
	@Resource
	private TestcaseProjectService testcaseProjectService;
	
	private Integer id;
	private String name;
	private String description;
	
	public String createTestcaseproject(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		TestcaseProject testcaseproject = testcaseProjectService.findTestcaseProjectByName(this.getName());
		
		if(testcaseproject != null){
			request.setAttribute("error", "This project already exist!");
			return "error";
		}
		
		testcaseproject = new TestcaseProject();
		testcaseproject.setName(this.getName());
		//testcaseproject.setDescription(this.getDescription());
		
		testcaseProjectService.saveTestcaseProject(testcaseproject);
		
		return "success";
	}
	
	public String queryTestcaseproject(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		List<TestcaseProject> testcaseprojects = testcaseProjectService.findAllList();
		
		request.setAttribute("testcaseprojects", testcaseprojects);

		return "success";
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
