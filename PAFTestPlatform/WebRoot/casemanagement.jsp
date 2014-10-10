<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/casequeryGroups.action").forward(request,response);}
List<SutGroup> sutGroup = (List<SutGroup>)request.getAttribute("sutgroups");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		$("#sutgroup").append(inisutgroup());
		}
		);

	function inisutgroup() {
		<%String inisutgroup = "";
		for (int i=0; i < sutGroup.size(); i++){
		  	inisutgroup += "<tr><td><div style='color:#00000;font-family:Microsoft YaHei;font-size:20px;border-bottom:1px solid gray'>"+sutGroup.get(i).getName()  +"</div>" + "</td></tr>";
			inisutgroup += "<tr>";
			String inisutgroupinfo = "";
			for (int j = 0; j< sutGroup.get(i).getSuts().size() ; j++){
				inisutgroupinfo += "<td style='padding:20px"+"'>";
				inisutgroupinfo += "<div class='" +"jumbotron'" + " style='width:300px;height:300px"+"'>";
				inisutgroupinfo += "<h1 style='"+ "text-align:center;font-family:Microsoft YaHei'>" + sutGroup.get(i).getSuts().get(j).getName() + "</h1>";
				inisutgroupinfo += "<p " +"style='text-align:center;font-family:Microsoft YaHei"+"'>共" + sutGroup.get(i).getSuts().get(j).getTestsuites().size()+ "个测试集</p>";
				inisutgroupinfo += "<p " +"style='text-align:center;font-family:Microsoft YaHei"+ "'><a class='" + "btn btn-primary btn-lg'" + " role='" + "button'" + " href='sutcase.jsp?sut_id=" + sutGroup.get(i).getSuts().get(j).getId() + "'>查看用例</a></p>";
				inisutgroupinfo += "</div>";
				inisutgroupinfo += "</td>";
				inisutgroupinfo += "<td><div>&nbsp;&nbsp;</div></td>";
			}
			
			inisutgroup += inisutgroupinfo;
			inisutgroup +="</tr>";
		}%>
		return "<%=inisutgroup%>";
	};
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">			
			<table id="sutgroup">
			</table>			
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>