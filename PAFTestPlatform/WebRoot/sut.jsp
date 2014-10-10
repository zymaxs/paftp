<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/initialSuts.action").forward(request,response);}
List<ApplySut> inisutdata = (List<ApplySut>)request.getAttribute("suts");
String pagenum = request.getAttribute("pages").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>接入系统</title>
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

	$("#sutForm").append(inidata());
	
	$("#querysut").click(function(){
		params = {pagenum:1,sutname:$("#sutname").val(),applyer:$("#applyer").val(),starttime:$("#starttime").datetimebox("getValue"),endtime:$("#endtime").datetimebox("getValue")};
		
		$.ajax({
						type : "POST",
						url : "querySutsAjax.action",
						data : params,
						dataType : "json",
						success : function(test) {
							$("#sutFormTab").html("");
							$(test.applySutDtos).each(function(i,value){
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</td>"+"<td>"+value.applytime+"</td>"+"<td><a href='applysutinfo.jsp?id="+value.id+"'>"+value.applysutstatusdto.description+"</a></td>"+"</tr>");
							});
							
							$('.pagination').jqPagination('option', 'max_page', test.pages);
							
						},
						error : function(root) {

							alert("json=" + root);

							return false;

						}
				});
		
	
				
		});
	
	
	$('.pagination').jqPagination({
				link_string : '/?page={page_number}',
				max_page : pagentotal, 
				paged : function(page) {
				params = {pagenum:page,sutname:$("#sutname").val(),applyer:$("#applyer").val(),starttime:$("#starttime").datetimebox("getValue"),endtime:$("#endtime").datetimebox("getValue")};
				$.ajax({
						type : "POST",
						url : "querySutsAjax.action",
						data : params,
						dataType : "json",
						success : function(root) {
	
							$("#sutFormTab").html("");
							$(root.applySutDtos).each(function(i,value){
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</a></td>"+"<td>"+value.applytime+"</td>"+"<td><a href='applysutinfo.jsp?id="+value.id+"'>"+value.applysutstatusdto.description+"</a></td>"+"</tr>");
							})
						},

						error : function(root) {

							alert("json=" + root);

							return false;

						}
					})
				}
				});
  });
  
function inidata(){
	<%String iniinsertdata = "";

			for (int i = 0; i < inisutdata.size(); i++) {
				iniinsertdata += "<tr>";
				iniinsertdata += "<td>" + inisutdata.get(i).getId() + "</td>";
				iniinsertdata += "<td>" + inisutdata.get(i).getName() + "</td>";
				iniinsertdata += "<td><a href='getuserinfo.action?userid="
						+ inisutdata.get(i).getUser().getId() + "'>"
						+ inisutdata.get(i).getUser().getAlias() + "</a></td>";
				iniinsertdata += "<td>" + inisutdata.get(i).getApplytime()
						+ "</td>";
				iniinsertdata += "<td><a href='applysutinfo.jsp?id="
						+ inisutdata.get(i).getId()
						+ "'>"
						+ inisutdata.get(i).getApplysutstatus()
								.getDescription() + "</a></td>";
				iniinsertdata += "</tr>";
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
			<table width="100%">
				<tr align="left">
					<td>
						<button type="button" class="btn btn-primary btn-success"
							style="width:80px;text-align:center"
							onClick="window.location.href='applysut.jsp'">申请接入</button>
					</td>
				<tr>
					<td>&nbsp;</td>
				</tr>
				</tr>
			</table>
			<form id="queryForm" name="queryForm" action="">
				<table width="100%">
					<tr>
						<td style="width:50px">系统名</td>
						<td><input type="text" id="sutname" name="sutname"
							style="width:100px"></td>
						<td style="width:50px">申请人</td>
						<td><input type="text" id="applyer" name="applyer"
							style="width:100px"></td>
						<td>起始日期</td>
						<td><input class="easyui-datetimebox" id="starttime"
							name="starttime" editable="false"></td>
						<td>截止日期</td>
						<td><input class="easyui-datetimebox" id="endtime"
							name="endtime" editable="false"></td>
					</tr>
					<tr>
						<td colspan="8">&nbsp;</td>
					</tr>
					<tr align="center">
						<td colspan="8"><input type="button" id="querysut"
							class="btn btn-primary btn-sm" style="width:80px" name="querysut"
							value="搜索">
						</td>
					</tr>
				</table>
			</form>

			<!--TABLE展示-->
			<table id="sutForm" class="table table-striped"
				style="text-align:center; width:100%" align="center">
				<thead>
					<tr>
						<td>申请序号</td>
						<td>系统名称</td>
						<td>申请人</td>
						<td>申请日期</td>
						<td>状态</td>
					</tr>
				</thead>
				<tbody id="sutFormTab">
				</tbody>
			</table>
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