<%@ page contentType="text/html; charset=gb2312" language="java"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
<%
session.invalidate();//���ٻỰ
out.println("<script language='javascript'>");
out.println("window.location.href='index_1.jsp'");
out.println("</script>");
%> 


</body>
</html>