<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<%
String sut_id = (String)request.getAttribute("sut_id");
response.sendRedirect("roleindex.jsp?sut_id="+sut_id);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
</head>

<body>
</body>
</html>