<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/initialroles.action").forward(request,response);}
List<User> resultusers = (List<User>)request.getAttribute("resultusers");
String pagenum = request.getAttribute("pages").toString();
String sut_name = (String)request.getAttribute("sut_name");
String sut_id = request.getAttribute("sut_id").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>系统权限</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/jqpagination.css" rel="stylesheet" />
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<script type="text/javascript">
var pagentotal = '<%=pagenum%>';
var sutname1 = '<%=sut_name%>';
var params;
$(document).ready( function(){
		$("#roleForm").append(inidata());
		$("#queryrole").click(function(){
		params = {pagenum:1,sut_name:sutname1,rolealias:$("#rolealias").val()};
		$.ajax({
						type : "POST",
						url : "queryRolesAjax.action",
						data : params,
						dataType : "json",
						success : function(root) {
							$("#roleFormTab").html("");
							$(root.resultusers).each(function(i,value){
							$(value.roles).each(function(j,role){
								$("#roleFormTab").append("<tr>"+"<td>"+value.alias+"</td>"+"<td>"+value.displayName+"</td>"+"<td>"+role.name+"</td>"+"<td>"+role.description+"</td>"+"</tr>");
							});
							});
							
							$('.pagination').jqPagination('option', 'max_page', root.pages);
						},
						error : function(XMLHttpRequest,textStatus,errorThrown) {

							alert("status=" + XMLHttpRequest.status);
							alert("readyStatus=" + XMLHttpRequest.readyStatus);
							alert("testStatus=" + textStatus);
							return false;

						}
				});
	
	});
	
	$('.pagination').jqPagination({

				link_string : '/?page={page_number}',
				max_page : pagentotal, 
				paged : function(page) {

						params = {pagenum:page,sut_name:sutname1,rolealias:$("#rolealias").val()};

						$.ajax({
						type : "POST",
						url : "queryRolesAjax.action",
						data : params,
						dataType : "json",
						success : function(root) {
	
							$("#roleFormTab").html("");
							$(root.resultusers).each(function(i,value){
								$(value.roles).each(function(j,role){
									$("#roleFormTab").append("<tr>"+"<td>"+value.alias+"</td>"+"<td>"+value.displayName+"</td>"+"<td>"+role.name+"</td>"+"<td>"+role.description+"</td>"+"</tr>");
								});
							});
						},

						error : function(root) {

							alert("json=" + root);

							return false;

						}
					});
				}
	});
 });
 
 
 function applyUserac(){
	document.queryForm.action = "${pageContext.request.contextPath}/sutinitialAddRelationship.action";
	document.queryForm.submit();
	};


function inidata(){
	<%String iniinsertdata="";
	
	for(int i=0; i< resultusers.size() ;i++ ){
		iniinsertdata +="<tr>";
		iniinsertdata +="<td><a href='getuserinfo.action?userid="+resultusers.get(i).getId()+"'>" +resultusers.get(i).getAlias()+"</a></td>";
		iniinsertdata +="<td>"+resultusers.get(i).getDisplayName()+"</td>";
		iniinsertdata +="<td>"+resultusers.get(i).getRoles().get(0).getName()+"</td>";
		iniinsertdata +="<td>"+resultusers.get(i).getRoles().get(0).getDescription()+"</td>";
		iniinsertdata +="</tr>";
	}%>
	return "<%=iniinsertdata%>";
	}
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<form id="queryForm" name="queryForm" action="" method="post">
				<table width="100%">
					<tr>
						<td colspan="3" style="font-size:30px; text-align:left"><%=sut_name%>系统权限</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="80%" align="left"><button type="button"
								class="btn btn-primary btn-success btn-sm"
								style="width:80px;text-align:center" onClick="applyUserac()">授权用户</button>
						</td>
						<td><input type="text" id="rolealias" name="rolealias"
							style="height:30px"></td>
						<td><input type="button" id="queryrole" name="queryrole"
							class="btn btn-primary btn-sm"
							style="width:80px;text-align:center" value="搜索账号"></td>
					</tr>
					<tr>
						<td style="display:none"><input id="sut_id" name="sut_id"
							value="<%=sut_id%>"></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
				</table>
			</form>

			<div>
				<table id="roleForm" class="table table-hover"
					style="text-align:center">
					<thead>
						<tr>
							<td>账号</td>
							<td>昵称</td>
							<td>角色</td>
							<td>描述</td>
						</tr>
					</thead>
					<tbody id="roleFormTab">
					</tbody>
				</table>
				</fieldset>
			</div>
			<div align="center">
				<div class="pagination">
					<a href="#" class="first" data-action="first">&laquo;</a> <a
						href="#" class="previous" data-action="previous">&lsaquo;</a> <input
						type="text" readonly="readonly" /> <a href="#" class="next"
						data-action="next">&rsaquo;</a> <a href="#" class="last"
						data-action="last">&raquo;</a>
				</div>
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>