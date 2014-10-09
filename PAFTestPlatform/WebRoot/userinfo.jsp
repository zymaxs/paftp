<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<% 
List<Role> roles = (List<Role>)request.getAttribute("currentPageRoles");
String pagenum = request.getAttribute("pages").toString();
User users = (User)request.getAttribute("user");
UserInfo userinfo = (UserInfo) users.getUserInfo();
%>
<%  
Integer id = 0;
String username = "";
String displayname = "";
String department = "";
String position = "";
String mobile = "";
String telephone = "";
String othermail = "";
String otherinfo ="";

if(users.getId() != null){
	id = users.getId();
}

if (users.getAlias() != null) {
	username = users.getAlias();
}

if (users.getDisplayName() != null) {
	displayname = users.getDisplayName();
}

if (userinfo.getDepartment() != null && userinfo.getDepartment().getName() != null) {
	department = userinfo.getDepartment().getName();
}

if (userinfo.getPosition() != null && userinfo.getPosition().getName() != null) {
	position = userinfo.getPosition().getName();
}

if (userinfo.getMobile() != null) {
	mobile = userinfo.getMobile();
}

if (userinfo.getTelephone() != null) {
	telephone = userinfo.getTelephone();
}

if (userinfo.getOthermail() != null) {
	othermail = userinfo.getOthermail();
}
if (userinfo.getOtherinfo() != null) {
		otherinfo = userinfo.getOtherinfo();
	}
	;
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>用户信息</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/jqpagination.css" rel="stylesheet" />
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
var pagentotal = <%=pagenum%>;
var params;
$(document).ready( function(){
	$("#roleFormTab").append(inidata());
		
	$('.pagination').jqPagination({
		link_string : '/?page={page_number}',
		max_page : pagentotal, 
		paged : function(page) {
		params = {pagenum:page,userid:<%=id%>};
		$.ajax({
				type : "POST",
				url : "getUserInfoAjax.action",
				data : params,
				dataType : "json",
				success : function(root) {

					$("#roleFormTab").html("");
					$(root.currentPageRoleDtoes).each(function(i,value){
					$("#roleFormTab").append("<tr><td>"+value.name+"</td><td>"+value.sutdto.name+"</td><td>"+value.description+"</td></tr>");
					})
				},

				error : function(root) {

					alert("failed");

					return false;

				}
			})
		}
		});
	
  });
  
function inidata(){
	<%
	String iniinsertdata="";
	
	for(int i=0; i< roles.size() ;i++ ){
		iniinsertdata +="<tr>";
		iniinsertdata +="<td>"+roles.get(i).getName()+"</td>";
		if (roles.get(i).getSut() != null){
			iniinsertdata +="<td>"+roles.get(i).getSut().getName()+"</td>";
		}
		else {
			iniinsertdata += "<td></td>";
			}
		iniinsertdata +="<td>"+roles.get(i).getDescription()+"</td>";
		iniinsertdata +="</tr>";
	}
	%>
	return "<%=iniinsertdata%>";
}

</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<div>
				<fieldset>
					<legend> 用户信息 </legend>
					<table style="width:40%" align="left" class="table table-striped">
						<tr>
							<td>&nbsp;UM账号&nbsp;&nbsp;:</td>
							<td><%=username%></td>
						</tr>
						<tr>
							<td>真实姓名 :</td>
							<td><%=displayname%></td>
						</tr>
						<tr>
							<td>所属部门 :</td>
							<td><%=department%></td>
						</tr>
						<tr>
							<td>当前职位 :</td>
							<td><%=position%></td>
						</tr>
						<tr>
							<td>移动电话 :</td>
							<td><%=mobile%></td>
						</tr>
						<tr>
							<td>座式电话 :</td>
							<td><%=telephone%></td>
						</tr>
						<tr>
							<td>其他邮件 :</td>
							<td><%=othermail%></td>
						</tr>
						<tr>
							<td>备注信息 :</td>
							<td><%=otherinfo%></td>
						</tr>
					</table>
				</fieldset>
			</div>
			<div>
				<fieldset>
					<legend> 用户权限</legend>
					<table id="roleForm" class="table table-bordered" style="width:80%"
						align="left">
						<thead>
							<tr>
								<td>角色</td>
								<td>系统</td>
								<td>描述</td>
							</tr>
						</thead>
						<tbody id="roleFormTab">
						</tbody>
					</table>
				</fieldset>
			</div>
			<div class="pagination">
				<a href="#" class="first" data-action="first">&laquo;</a> <a
					href="#" class="previous" data-action="previous">&lsaquo;</a> <input
					type="text" readonly="readonly" /> <a href="#" class="next"
					data-action="next">&rsaquo;</a> <a href="#" class="last"
					data-action="last">&raquo;</a>
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>