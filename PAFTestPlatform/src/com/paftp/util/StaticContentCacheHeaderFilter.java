package com.paftp.util;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaticContentCacheHeaderFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletResponse response = (HttpServletResponse) servletResponse;
	    HttpServletRequest request = (HttpServletRequest) servletRequest;

	    long ifModifiedSince = 0;
	    try {
	        ifModifiedSince = request.getDateHeader("If-Modified-Since");
	    } catch (Exception e) {
	       System.out.print("Reqeust has error for cache set!");
	    }

//	    long now = DateTime.now().getMillis();
//
//	    long lastModifiedMillis = now;
//
//	    DateTime dateTime = new DateTime();
//
//	    //1 month seems to be the minimum recommended period for static resources acc to          
//	    //https://developers.google.com/speed/docs/best-practices/caching#LeverageBrowserCaching
//	    long expires = dateTime.plusMonths(1).getMillis();
//
//	    if (ifModifiedSince > 0 && ifModifiedSince <= lastModifiedMillis) {
//	        // not modified, content is not sent - only basic
//	        // headers and status SC_NOT_MODIFIED
//	        response.setDateHeader("Expires", expires);
//	        response.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
//	        return;
//	    }
//
//	    // set heading information for caching static content
//	    response.setDateHeader("Date", now);
//	    response.setDateHeader("Expires", expires);
//	    response.setDateHeader("Retry-After", expires);
//	    response.setHeader("Cache-Control", "public");
//	    response.setDateHeader("Last-Modified", lastModifiedMillis);
//
//	    filterChain.doFilter(servletRequest, servletResponse);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
