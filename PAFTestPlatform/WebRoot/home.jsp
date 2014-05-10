<%@ page language="java" import="java.util.*,com.paftp.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "home" + "/";
	pageContext.setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

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

	<%
		//List<User> users = (List) request.getAttribute("users");
		//String s ="";
		//for (int i = 0; i < users.size(); i++) {

		//	if (users.get(i).getAuths().size()!=0 ) {
		//		s += "userid:"+users.get(i).getId().toString()+";"+users.get(i).getAuths().get(0).getAuthName() + ";";
		//	}
		//}
		List<Testsuite> testsuites = (List) request
				.getAttribute("testsuites");
		String s = "";
		for (int i = 0; i < testsuites.size(); i++) {
			s += "testsuite_id: " + testsuites.get(i).getId().toString()
					+ " testsuite_name: " + testsuites.get(i).getName()
					+ " sut_name:" + testsuites.get(i).getSut().getName()
					+ " testcase_name"
					+ testsuites.get(i).getTestcases().get(0).getCaseName()+" creator_name:"+testsuites.get(i).getTestcases().get(0).getCreator().getUserName();
		}
	%>
	<%=s%>
</body>
</html>
