<%@ page contentType="text/html; charset=gb2312" language="java"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
<%
session.invalidate();//Ïú»Ù»á»°
out.println("<script language='javascript'>");
out.println("window.location.href='index.jsp'");
out.println("</script>");
%> 


</body>
</html>