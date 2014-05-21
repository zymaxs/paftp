<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "HOME" + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<base href="<%=basePath%>">

<%@ taglib uri="/struts-tags" prefix="s" %>  

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body>
  <%String s = session.getId(); //获取session ID号 %> <p>你的session对象ID是：</p> <%=s %> 
  Welcome, <s:property value="#session.user.alias"/> 
  <form action="${pageContext.request.contextPath}/profile.action" method="post">
	<input type="submit" value="profile"/>
  </form>
</body>
</html>
