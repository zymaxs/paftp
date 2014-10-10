<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/rolequeryGroups.action").forward(request,response);}
List<SutGroup> sutGroup = (List<SutGroup>)request.getAttribute("sutgroups");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>权限管理</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<%-- <script type="text/javascript">
$(document).ready(function(){
		//alert(inisutgroup());
		$("#sutgrouptab").append(inisutgroup());
		}
		);

	function inisutgroup() {
		<%String inisutgroup = "";
			for (int i = 0; i < sutGroup.size(); i++) {
				String inisutgroupinfo = "";
				for (int j = 0; j < sutGroup.get(i).getSuts().size(); j++) {
					inisutgroupinfo += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='role.jsp?sut_id="
							+ sutGroup.get(i).getSuts().get(j).getId()
							+ "'>"
							+ sutGroup.get(i).getSuts().get(j).getName()
							+ "</a>" + " ";
				}
				inisutgroup += "<blockquote><p>";
				inisutgroup += sutGroup.get(i).getName();
				inisutgroup += "</p><small>";
				inisutgroup += inisutgroupinfo;
				inisutgroup += "</small></blockquote>";
			}%>
		return "<%=inisutgroup%>";
	};
</script> --%>
<script type="text/javascript">
$(document).ready(function(){
		$("#sutgroup").append(inisutgroup());
		}
		);

	function inisutgroup() {
		<%String inisutgroup = "";
		for (int i=0; i < sutGroup.size(); i++){
		  	inisutgroup += "<tr><td><div style='color:#00000;font-family:Microsoft YaHei;font-size:20px;border-bottom:1px solid gray'>" + sutGroup.get(i).getName() + "</legend></td></tr>";
			inisutgroup += "<tr>";
			String inisutgroupinfo = "";
			for (int j = 0; j< sutGroup.get(i).getSuts().size() ; j++){
				inisutgroupinfo += "<td style='padding:20px"+"'>";
				inisutgroupinfo += "<div class='" +"jumbotron'" + " style='width:300px;height:300px;"+"'>";
				inisutgroupinfo += "<h1 style='"+ "text-align:center;font-family:Microsoft YaHei'>" + sutGroup.get(i).getSuts().get(j).getName() + "</h1>";
				inisutgroupinfo += "<p " +"style='text-align:center;word-wrap: break-word;font-family:Microsoft YaHei"+"'>" + sutGroup.get(i).getSuts().get(j).getDescription()+ "</p>";
				inisutgroupinfo += "<p " +"style='text-align:center;font-family:Microsoft YaHei"+ "'><a class='" + "btn btn-primary btn-lg'" + " role='" + "button'" + " href='role.jsp?sut_id=" + sutGroup.get(i).getSuts().get(j).getId() + "'>查看权限</a></p>";
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