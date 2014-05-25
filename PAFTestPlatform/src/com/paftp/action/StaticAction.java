package com.paftp.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.entity.Department;
import com.paftp.entity.Position;
import com.paftp.service.StaticColumn.DepartmentService;
import com.paftp.service.StaticColumn.PositionService;

@Controller
public class StaticAction extends ActionSupport{

	/**
	 *  Lei Lei
	 *  Actions for all the static methods
	 */
	private static final long serialVersionUID = 6816406522302992979L;
	@Resource
	private DepartmentService departmentService;
	@Resource
	private PositionService positionService;
	
	public String userinfo(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		List<String> departments = new ArrayList<String>();
		List<Department> userinfoDepartments = departmentService.findAllList();
		for (int i=0; i<userinfoDepartments.size(); i++){
			departments.add(userinfoDepartments.get(i).getName());
	
		}
		request.setAttribute("departments", departments);
		
		List<String> positions = new ArrayList<String>();
		List<Position> userinfoPositions = positionService.findAllList();
		for (int i=0; i<userinfoPositions.size(); i++){
			positions.add(userinfoPositions.get(i).getName());
		}
		request.setAttribute("positions", positions);
		
		request.setAttribute("flag", "true");
		
		return "success";
	}
	
//	private List<String> getNames(List<StaticModel> list){
//		
//		List<String> names = new ArrayList<String>();
//		for(int i = 0; i < list.size(); i++){
//			names.add(list.get(i).getName());
//		}
//		
//		return names;
//		
//	}
	
}
