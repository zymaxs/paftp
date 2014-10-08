<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/initialTestpasses.action").forward(request,response);}
String isManager;
if (String.valueOf(request.getAttribute("isManager")) == "true"){
	isManager = "y";
}
else { isManager = "n";};
if (request.getAttribute("versionflag") == null ){
request.getRequestDispatcher("${pageContext.request.contextPath}/resultqueryVersion.action").forward(request,response);}
List<Version> versions = (List<Version>)request.getAttribute("versions");
List<TestpassDto> testpassdots = (List<TestpassDto>)request.getAttribute("testpassdots");
String sut_id = request.getAttribute("sut_id").toString();
String pagenum = request.getAttribute("pages").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/easyui/themes/default/easyui.css" rel="stylesheet">
<link href="css/easyui/themes/icon.css" rel="stylesheet">
<link href="css/jqpagination.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
function inidata(){
	<%String iniinsertdata="";
	String rowtype = "";
	
	for(int i=0; i< testpassdots.size() ;i++ ){
		if (testpassdots.get(i).getPercentage() == 1){
			rowtype = "class='success'";
		}
		else if (testpassdots.get(i).getPercentage() < 1 && testpassdots.get(i).getPercentage() >= 0.8){
			rowtype = "class='active'";
		}
		else if (testpassdots.get(i).getPercentage() < 0.8 && testpassdots.get(i).getPercentage() >= 0.5){
			rowtype = "class='warning'";
		}
		else {
			rowtype = "class='danger'";
		}
		
		
		iniinsertdata +="<tr "+ rowtype +">";
		iniinsertdata +="<td><a href='tsresult.jsp?testpass_id="+testpassdots.get(i).getId()+"'>"+testpassdots.get(i).getCreatetime()+"</a></td>";
		iniinsertdata +="<td>"+testpassdots.get(i).getTestset()+"</td>";
		iniinsertdata +="<td>"+testpassdots.get(i).getEnv()+"</td>";
		iniinsertdata +="<td>"+testpassdots.get(i).getVersion().getVersionNum()+"</td>";
		iniinsertdata +="<td>"+testpassdots.get(i).getPasscount()+"</td>";
		iniinsertdata +="<td><a href='failresult.jsp?testpass_id="+testpassdots.get(i).getId()+"'>"+testpassdots.get(i).getFailcount()+"</a></td>";
		iniinsertdata +="<td>"+testpassdots.get(i).getTotal()+"</td>";
		iniinsertdata +="<td>"+(testpassdots.get(i).getPercentage()*100)+"%</td>";
		if (testpassdots.get(i).getTag() == null){
			iniinsertdata +="<td><a id='"+testpassdots.get(i).getId()+"' href='#' data-toggle='modal' data-target='#tagModal'>————</a></td>";
		}
		else{
		iniinsertdata +="<td><a id='"+testpassdots.get(i).getId()+"' href='#' data-toggle='modal' data-target='#tagModal'>"+testpassdots.get(i).getTag()+"</a></td>";
		}
		iniinsertdata +="</tr>";
	}%>
	return "<%=iniinsertdata%>";
}

var sut_id = <%=sut_id%>;
var pagentotal = <%=pagenum%>;
var params ="";

$(document).ready( function(){
		$("#resultFormTab").append(inidata());
		
		$("#queryresult").click(function(){
		params = {pagenum:1,sut_id:sut_id,starttime:$("#starttime").datetimebox("getValue"),endtime:$("#endtime").datetimebox("getValue"),env:$("#queryenv").val(),testset:$("#querytestset").val(),version:$("#queryversion").val(),tag:$("#querytag").val()};
		
		$.ajax({
						type : "POST",
						url : "queryTestpasses.action",
						data : params,
						dataType : "json",
						success : function(root) {
							$("#resultFormTab").html("");
							
							$(root.testpassdots).each(function(i,value){
								var rowtype = "";
								if (value.percentage == 1){
									rowtype = "class='success'";
									}
								else if (value.percentage < 1 && value.percentage >= 0.8){
									rowtype = "class='active'";
									}
								else if (value.percentage < 0.8 && value.percentage >= 0.5){
									rowtype = "class='warning'";
									}
								else {
									rowtype = "class='danger'";
									}
								
								if ( value.tag == null){
									$("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</a></td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' href='#' data-toggle='modal' data-target='#tagModal'>————</a></td></tr>" );
									}
								else{
									$("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</a></td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' href='#' data-toggle='modal' data-target='#tagModal'>"+value.tag+"</a></td></tr>" );
									}
								
							})
							
							$('.pagination').jqPagination('option', 'max_page', root.pages);
							
							
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
				params = {pagenum:page,sut_id:sut_id,starttime:$("#starttime").datetimebox("getValue"),endtime:$("#endtime").datetimebox("getValue"),env:$("#queryenv").val(),testset:$("#querytestset").val(),version:$("#queryversion").val(),tag:$("#querytag").val()};
				$.ajax({
						type : "POST",
						url : "queryTestpasses.action",
						data : params,
						dataType : "json",
						success : function(root) {
							$("#resultFormTab").html("");
							$(root.testpassdots).each(function(i,value){
								var rowtype = "";
								if (value.percentage == 1){
									rowtype = "class='success'";
									}
								else if (value.percentage < 1 && value.percentage >= 0.8){
									rowtype = "class='active'";
									}
								else if (value.percentage < 0.8 && value.percentage >= 0.5){
									rowtype = "class='warning'";
									}
								else {
									rowtype = "class='danger'";
									}
								
								if ( value.tag == null){
									$("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' href='#' data-toggle='modal' data-target='#tagModal'>————</a></td></tr>" );
									}
								else{
									$("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' href='#' data-toggle='modal' data-target='#tagModal'>"+value.tag+"</a></td></tr>" );
									}
								
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
	
function updatetagac(){
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
		if('<%=isManager%>' != "y"){
			alert("您目前权限不足！");
		}
		else {
			$.ajax({
			 	type : "POST",
			 	 url : "updateTestpass.action",
			   cache : false,
			    data : {sut_id:sut_id,testpass_id:$("#testpass_id").val(),show_tag:$("#tag").val(),tag:$("#querytag").val()},
			dataType : "json",
			 success : function(root) {
				 		if ( root.prompt != null){
					  		alert(root.prompt);
					  		}
						else{
					   $("#resultFormTab").html("");
							
					   $(root.testpassdots).each(function(i,value){
						  var rowtype = "";
						  if (value.percentage == 1){
							  rowtype = "class='success'";
							  }
						  else if (value.percentage < 1 && value.percentage >= 0.8){
							  rowtype = "class='active'";
							  }
						  else if (value.percentage < 0.8 && value.percentage >= 0.5){
							  rowtype = "class='warning'";
							  }
						  else {
							  rowtype = "class='danger'";
							  }
						  
						  if ( value.tag == null){
							  $("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</a></td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' onClick='tagac(this)'>————</a></td></tr>" );
							  }
						  else{
							  $("#resultFormTab").append("<tr "+ rowtype +"><td><a href='tsresult.jsp?testpass_id="+value.id+"'>"+value.createtime+"</a></td><td>"+value.testset+"</td><td>"+value.env+"</td><td>"+value.version.versionNum+"</td><td>"+value.passcount+"</td><td><a href='failresult.jsp?testpass_id="+value.id+"'>"+value.failcount+"</a></td><td>"+value.total+"</td><td>"+(value.percentage*100)+"%</td><td><a id='"+value.id+"' onClick='tagac(this)'>"+value.tag+"</a></td></tr>" );
							  }
						  
					  })
					  
					  $('.pagination').jqPagination('option', 'max_page', root.pages);
						}
			 			},
			  	error: function(XMLHttpRequest, textStatus, errorThrown) {
				  	   alert(XMLHttpRequest.status);
				  	   alert(XMLHttpRequest.readyState);
				  	   alert(textStatus);
			  		   }
		  		});
		}
	}
}
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<!--查询-->
			<table id="interfaceSearchTable" style="width:100%;"
				class="table table-striped">
				<tr style="text-align:center">
					<td width="48%" colspan="4">时间段</td>
					<td width="13%">测试集</td>
					<td width="13%">测试环境</td>
					<td width="13%">版本</td>
					<td width="13%">TAG</td>
				</tr>
				<tr>
					<td>起始日期</td>
					<td><input class="easyui-datetimebox" id="starttime"
						name="starttime" editable="false">
					</td>
					<td>截止日期</td>
					<td><input class="easyui-datetimebox" id="endtime"
						name="endtime" editable="false">
					</td>
					<td><input id="querytestset" class="form-control input-sm"
						name="querytestset" value="" style="width:100%; height:24px">
					</td>
					<td><select id="queryenv" style="width:100%">
							<option value="" selected>All</option>
							<option value="stg1">stg1</option>
							<option value="stg2">stg2</option>
							<option value="stg3">stg3</option>
					</select>
					</td>
					<td><select id="queryversion" style="width:100%">
							<option value="" selected>All</option>
							<%
								for (int i = 0; i < versions.size(); i++) {
							%>
							<option value="<%=versions.get(i).getVersionNum()%>"><%=versions.get(i).getVersionNum()%></option>
							<%
								}
							%>
					</select>
					</td>
					<td><select id="querytag" style="width:100%">
							<option value="" selected>All</option>
							<option value="">————</option>
							<option value="冒烟测试">冒烟测试</option>
							<option value="系统测试">系统测试</option>
							<option value="回归测试">回归测试</option>
					</select>
					</td>
				</tr>
				<tr>
					<td colspan="8" style="text-align:center"><input type="button"
						id="queryresult" class="btn btn-primary btn-sm" style="width:80px"
						name="queryresult" value="搜索">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td width="70%"
						style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">接口自动化测试结果</td>
					<td width="30%">
						<table class="table table-bordered">
							<tr>
								<th colspan="4"><center>Passrate</center>
								</th>
							</tr>
							<tr>
								<td class="success" style="width:150px"><center>100%</center>
								</td>
								<td class="active" style="width:150px"><center>80%-99%</center>
								</td>
								<td class="warning" style="width:150px"><center>50%-79%</center>
								</td>
								<td class="danger" style="width:150px"><center>0%-49%</center>
								</td>
							</tr>
						</table></td>
				</tr>
			</table>

			<!--图表-->
			<table id="resultForm" class="table table-bordered"
				style="text-align:center; width:100%" align="center">
				<thead>
					<tr>
						<td>执行日期</td>
						<td>测试集</td>
						<td>测试环境</td>
						<td>版本</td>
						<td>Pass</td>
						<td>Fail</td>
						<td>Total</td>
						<td>Passrate</td>
						<td>Tag</td>
					</tr>
				</thead>
				<tbody id="resultFormTab">
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

	<!--打TAG 隐藏模块-->
	<div class="modal fade" id="tagModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:400px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">为本次测试结果打一个标签</h4>
				</div>
				<div class="modal-body">
					<form id="updatetagForm" name="updatetagForm" action="">
						<table>
							<tr>
								<td><input type="text" id="testpass_id" name="testpass_id"
									value="" style="display:none"></td>
							</tr>
							<tr>
								<td><select id="tag" name="tag" style="width:150px;">
										<option value="" selected>————</option>
										<option value="冒烟测试">冒烟测试</option>
										<option value="系统测试">系统测试测试</option>
										<option value="回归测试">回归测试</option>
								</select>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer" align="center">
					<div align="center">
						<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
						<button class="btn btn-primary" onclick="updatetagac()">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>