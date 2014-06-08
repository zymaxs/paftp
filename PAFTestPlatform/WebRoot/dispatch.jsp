<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<%
String sut_name = (String)request.getAttribute("sut_name");
response.sendRedirect("roleindex.jsp?sut_name="+sut_name);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
</head>

<body>
</body>
</html>