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
		List<Testsuite> testsuites = (List) request
				.getAttribute("testsuites");
		String s = "";
		for (int i = 0; i < testsuites.size(); i++) {

			String testsuitename = testsuites.get(i).getName() + ";";
			String sutname = testsuites.get(i).getSut().getName() + ";";
			//String testcasename = testsuites.get(i).getTestcases().get(0)
			//		.getCaseName()
			//		+ ";";
			//String testcasecontent = testsuites.get(i).getTestcases().get(0).getTestcaseSteps().get(0).getContent()+";";
			//s+=testsuitename+sutname+testcasename+testcasecontent;
			s += testsuitename + sutname;
		}
	%>
	<%=s%>
</body>
</html>
