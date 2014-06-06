<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*,com.paftp.entity.*" errorPage=""%>
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
List<Role> currentPageRoles = (List<Role>)request.getAttribute("currentPageRoles");
String pagenum = request.getAttribute("pages").toString();
String sut_name = (String)request.getAttribute("sut_name");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/shou.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
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
<%  

%>
<script type="text/javascript">
var pagentotal = '<%=pagenum%>';
var sut_name1 = '<%=sut_name%>';
var params;
$(document).ready( function(){
	    $("#roleForm").append(inidata());
		
		$("#queryrole").click(function(){
		params = {pagenum:1,sut_name:sut_name1,alias:$("#alias").val(),role_name:$("#role_name").val};
		
		$.ajax({
						type : "POST",
						url : "queryRolesAjax.action",
						data : params,
						dataType : "json",
						success : function(test) {
							$("#roleFormTab").html("");
							$(test.resultusers).each(function(i,value){
							$(value.roles).each(function(j,role){
								$("#roleFormTab").append("<tr>"+"<td>"+value.alias+"</td>"+"<td>"+role.name+"</td>"+"<td>"+role.description+"</td>"+"</tr>");
							});
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

						params = {pagenum:page,sut_name:sut_name1,alias:$("#alias").val(),role_name:$("#role_name").val()};

						$.ajax({
						type : "POST",
						url : "queryRolesAjax.action",
						data : params,
						dataType : "json",
						success : function(root) {
	
							$("#roleFormTab").html("");
							$(root.users).each(function(i,value){
								$(value.roles).each(function(j,role){
									$("#roleFormTab").append("<tr>"+"<td>"+value.alias+"</td>"+"<td>"+role.name+"</td>"+"<td>"+role.description+"</td>"+"</tr>");
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
</script>
<script type="text/javascript">

function applyUserac(){
	document.queryForm.action = "${pageContext.request.contextPath}/sutinitialAddRelationship.action";
	document.queryForm.submit();
	};


function inidata(){
	<%
	String iniinsertdata="";
	
	for(int i=0; i< currentPageRoles.size() ;i++ ){
		if(currentPageRoles.get(i).getUsers() != null){
		for (int j=0; j<currentPageRoles.get(i).getUsers().size(); j++){
		iniinsertdata +="<tr>";
		iniinsertdata +="<td>"+currentPageRoles.get(i).getUsers().get(j).getAlias()+"</td>";
		iniinsertdata +="<td>"+currentPageRoles.get(i).getName()+"</td>";
		iniinsertdata +="<td>"+currentPageRoles.get(i).getDescription()+"</td>";
		iniinsertdata +="</tr>";
		}
		}
	}
	%>
	return "<%=iniinsertdata%>";
}

</script>
</head>

<body>
<%=pagenum%>
<%=sut_name%>
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
  </div>
  <!--导航-->
  <div class="row-fluid">
    <div class="span12">
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container-fluid">
            <div class="nav-collapse collapse navbar-responsive-collapse">
              <ul class="nav">
                <li class="active"><a href="index_1.jsp">主页</a></li>
                  <li><a href="rolelist.jsp">Role申请</a></li>
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
        <td>用户</td>
        <td><input type="text" id="alias" name="alias"></td>
        <td>角色</td>
        <td><input type="text" id="role_name" name="role_name"></td>
        <td><input style="display:none" id="sut_name" name="sut_name" value="<%=sut_name%>"></td>
        <td rowspan="2"><button type="button" class="btn btn-primary" onClick="applyUserac()">授权用户</button></td>
        </tr>
      <tr>
        <td colspan="2" align="center" align="center"><input type="button" id="queryrole" name="queryrole" value="搜索"></td>
      </tr>
    </table>
  </form>
    <div>
     <fieldset>
   <legend> 用户权限</legend>
  <table id="roleForm" border="1" width="100%">
    <thead>
    	<tr>
        	<td>用户</td>
            <td>角色</td>
            <td>描述</td>
        </tr>
    </thead>
    <tbody id="roleFormTab">
    </tbody>
  </table>
         </fieldset>
  </div>
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