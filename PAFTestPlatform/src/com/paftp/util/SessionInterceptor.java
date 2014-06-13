package com.paftp.util;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class SessionInterceptor extends AbstractInterceptor{

	/**
	 * Lei Lei Zhang for session
	 */
	private static final long serialVersionUID = 5301906509527211103L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> session = invocation.getInvocationContext().getSession();
	      if(session.isEmpty())
	          return "session"; 
	      return invocation.invoke();
	}

}
