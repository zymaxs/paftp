<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/initialSuts.action").forward(request,response);}
List<ApplySut> inisutdata = (List<ApplySut>)request.getAttribute("suts");
String pagenum = request.getAttribute("pages").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/easyui/themes/default/easyui.css" rel="stylesheet">
<link href="css/easyui/themes/icon.css" rel="stylesheet">
<link href="css/easyui/demo.css" rel="stylesheet">
<link href="css/jqpagination.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<style>
.whitelink A:link {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}
.whitelink A:visited {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}
.whitelink A:hover {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}
.whitelink A:active {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}
</style>
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
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</td>"+"<td>"+value.applytime+"</td>"+"<td><a href='initialSut.action?sutname="+value.name+"'>"+value.applysutstatusdto.name+"</a></td>"+"</tr>");
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
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</a></td>"+"<td>"+value.applytime+"</td>"+"<td><a href='initialSut.action?sutname="+value.name+"'>"+value.applysutstatusdto.name+"</a></td>"+"</tr>");
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
</script>
<script type="text/javascript">
function inidata(){
	<%
	String iniinsertdata="";
	
	for(int i=0; i< inisutdata.size() ;i++ ){
		iniinsertdata +="<tr>";
		iniinsertdata +="<td>"+inisutdata.get(i).getId()+"</td>";
		iniinsertdata +="<td>"+inisutdata.get(i).getName()+"</td>";
		iniinsertdata +="<td><a href='getuserinfo.action?userid="+inisutdata.get(i).getUser().getId()+"'>"+inisutdata.get(i).getUser().getAlias()+"</a></td>";
		iniinsertdata +="<td>"+inisutdata.get(i).getApplytime()+"</td>";
		iniinsertdata +="<td><a href='initialSut.action?sutname="+inisutdata.get(i).getName()+"'>"+inisutdata.get(i).getApplysutstatus().getName()+"</a></td>";
		iniinsertdata +="</tr>";
	}
	%>
	return "<%=iniinsertdata%>";
}
</script>
<script type="text/javascript">
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}

	
</script>

</head>

<body>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff; margin:auto">
    <div class="row-fluid">
      <div class="span12">
        <div class="row-fluid">
          <div class="span12"></div>
        </div>
        <div class="row-fluid">
          <div class="span2"
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
          <div class="span7"></div>
          <%if (session.getAttribute("user") == null) {%>
          <div class="span3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </div>
          <%} else { User user = (User) session.getAttribute("user");
					String name = user.getAlias(); %>
          <div class="span3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </div>
          <%}%>
        </div>
        <div class="row-fluid">
          <div class="span12"
							style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
        </div>
        <div class="row-fluid">
          <div class="span10"></div>
          <div class="span2"
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">Version
            : beta 0.3.0</div>
        </div>
      </div>
    </div>
  </div>
  <!--登录-->
  <div id="loginmodal" style="display:none;">
    <div align="center">
      <p>用户登录</p>
    </div>
    <form id="loginform" name="loginform" method="post" action="">
      <label for="alias" style="Microsoft YaHei; font-size:12px;">Username:</label>
      <input type="text" name="alias" id="alias" class="txtfield"
					tabindex="1">
      <label for="password"
					style="Microsoft YaHei; font-size:12px;">Password:</label>
      <input
					type="password" name="password" id="password" class="txtfield"
					tabindex="2">
      <div class="center">
        <input type="button" name="loginbtn" id="loginbtn"
						class="flatbtn-blu hidemodal" value="Login" tabindex="3"
						onClick="loginac()">
        <input type="button"
						name="findpwdbtn" id="findpwdbtn" class="flatbtn-blu hidemodal"
						value="找回密码" onClick="window.location.href='findpwd.jsp'"
						tabindex="4">
      </div>
    </form>
  </div>
  <script type="text/javascript">
			$(function() {
				$('#login').leanModal({
					top : 110,
					overlay : 0.45,
					closeButton : ".hidemodal"
				});
			});
		</script> 
  <!--导航-->
  <div class="row-fluid">
    <div class="span12">
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container-fluid">
            <div class="nav-collapse collapse navbar-responsive-collapse">
              <ul class="nav">
                <li class="active"><a href="index_1.jsp">主页</a></li>
                <li><a href="sutlist.jsp">SUT申请</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <form id="queryForm" name="queryForm" action="" style="width:100%">
    <table width="900px">
      <tr>
        <td>系统名</td>
        <td><input type="text" id="sutname" name="sutname"></td>
        <td>申请人</td>
        <td><input type="text" id="applyer" name="applyer"></td>
        <td rowspan="2"><button type="button" class="btn btn-primary" onClick="window.location.href='applysut.jsp'">申请接入</button></td>
      </tr>
      <tr>
        <td>Start Date:</td>
        <td><input class="easyui-datetimebox"  id="starttime" name="starttime" ></td>
        <td>End Date:</td>
        <td><input class="easyui-datetimebox"  id="endtime" name="endtime"></td>
      </tr>
      <tr>
        <td colspan="2" align="center" align="center"><input type="button" id="querysut" name="querysut" value="搜索"></td>
      </tr>
    </table>
  </form>
  
  <!--TABLE展示-->
  <table id="sutForm" border="1" width="100%">
    <thead>
    	<tr>
        	<td>系统序列号</td>
            <td>系统名</td>
            <td>申请人</td>
            <td>申请日期</td>
            <td>状态</td>
        </tr>
    </thead>
    <tbody id="sutFormTab">
    </tbody>
  </table>
  <div class="pagination">
		<a href="#" class="first" data-action="first">&laquo;</a> <a href="#"
			class="previous" data-action="previous">&lsaquo;</a> <input
			type="text" readonly="readonly"/> <a href="#"
			class="next" data-action="next">&rsaquo;</a> <a href="#" class="last"
			data-action="last">&raquo;</a>
	</div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>