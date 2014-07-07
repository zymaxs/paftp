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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
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
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</td>"+"<td>"+value.applytime+"</td>"+"<td><a href='initialSut.action?id="+value.id+"'>"+value.applysutstatusdto.description+"</a></td>"+"</tr>");
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
								$("#sutFormTab").append("<tr>"+"<td>"+value.id+"</td>"+"<td>"+value.name+"</td>"+"<td><a href='getuserinfo.action?userid="+value.user_id+"'>"+value.applyer+"</a></td>"+"<td>"+value.applytime+"</td>"+"<td><a href='initialSut.action?id="+value.id+"'>"+value.applysutstatusdto.description+"</a></td>"+"</tr>");
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
		iniinsertdata +="<td><a href='initialSut.action?id="+inisutdata.get(i).getId()+"'>"+inisutdata.get(i).getApplysutstatus().getDescription()+"</a></td>";
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
<style>
/*导航默认样式，可根据实际情况修改*/
* {
	padding:0
}
.daohang {
	width:100%;
	height:30px;
	list-style:none;
	position:relative;
}
.daohang li {
	display:inline-block;
	margin:0;
	position:relative;
	overflow:hidden;
	height:30px; /*建议此高度大于等于里面的a标签高度*/
	float:left;
}
.daohang li span {
	display:inline-block;
	overflow:hidden
}
.daohang li a {
	text-decoration:none;
	outline:none;
	color:#428bca;
	display:inline-block;
	padding:0 10px;
	text-align:center;
	background-color: #FFFFFF;
	font-weight:bold;
	height:30px;
	line-height:30px;
}
/*鼠标经过时样式*/
.daohang li a.over {
	background-color:#428bca;
	color:#FFF
}
</style>
<script type="text/javascript">
(function($){
		  $.fn.dynamicdaohang=function(options){
			  
			   //默认配置
				 var defaults = {
					 direction:"up", //动画切换方向，总共4种up 、down 、left 、right
					 duration:100  //三种预定速度之一的字符串("slow", "normal", or "fast")或表示动画时长的毫秒数值(如：1000)
					 };   
					 
                // 覆盖默认配置
				var opts = $.extend(defaults, options);
			    
				this.each(function(){
					var daohangList=$(this).find("li"),
						daohangLink=daohangList.find("a");
								
						//在a标签外侧插入span
						daohangList.wrapInner("<span></span>");
								 
						var span=daohangLink.parent();
								 
						//判断是否垂直切换
						if(opts.direction=="up" || opts.direction=="down"){
							var v=true;
									 }
									 
						//判断是否改变span初始位置及a样式	 
						if(opts.direction=="right" || opts.direction=="down"){
							var restSpan=true;
								 }
								 
 						daohangLink.each(function(){
													   
							//获取a高度和宽度
							var w=$(this).outerWidth(),
								p=$(this).parent();
														   
							//初始复制现有a标签   
							$(this).clone().appendTo(p).addClass("over");
 													
								//如果是垂直切换
								if(v){	   
 									p.css("width",w);				      
								      }else{
										p.css("width",2*w).parent().css("width",w);	
										}
														 
  								});
								 
						//如果向右或向下切换，改变span初始位置及a样式
						if(restSpan){
						span.each(function(){
													
 								if(opts.direction=="right"){
									$(this).css({"margin-left":-$(this).outerWidth()/2});
									}
														
								if(opts.direction=="down"){
									$(this).css({"margin-top" : -$(this).outerHeight()/2});
									}
 													
								$(this)
								.find('a')
								.last()
								.removeClass("over")
								.prev()
								.addClass("over");
							});
								 }
								
						//鼠标经过时动画函数
						function over(o){
  							o.animate(v?{"margin-top": -o.outerHeight()/2}:{"margin-left": -o.outerWidth()/2}, opts.duration);
 									}
								
						//鼠标移开时动画函数
						function out(o){
							o.animate(v?{"margin-top":0}:{"margin-left": 0}, opts.duration);
									}
								
						//鼠标经过和离开	
						span.hover(function(){
										restSpan ? out($(this)) : over($(this));
											},function(){
												restSpan ? over($(this)) : out($(this));
											});
 							 
				 });
		 };
			  
 })(jQuery);
    $(function(){
		    //向上
		   $("#navigator").dynamicdaohang({
								direction:"up", 
								duration:400 
								});
		   });
</script>
</head>

<body>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff;"> <br>
  <table width="100%">
  <tr>
  	<td>&nbsp;&nbsp;</td>
  	<td style="font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</td>
    <td colspan="7">&nbsp;</td>
    <%if (session.getAttribute("user") == null) {%>
    <td colspan="2" class="whitelink" style=";font-size:15px; font-family:Microsoft YaHei; text-align:right"><a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </td>
    <%} else { User user = (User) session.getAttribute("user");
                      String name = user.getAlias(); %>
    <td colspan="2" class="whitelink" style=";font-size:15px; font-family:Microsoft YaHei; text-align:right"><a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </td>
    <%}%>
    <td>&nbsp;&nbsp;</td>
  </tr>
  <tr>
  	<td colspan="12" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</td>
  </tr>
  <tr>
  	<td colspan="10">&nbsp;</td>
    <td style="text-align:right;font-size:15px; font-family:Microsoft YaHei;">Version : beta 0.3.0</td>
    <td>&nbsp;&nbsp;</td>
  </tr>
  </table>
  <br>
  </div>
  <!--登录-->
  <div id="loginmodal" style="display:none;" align="center">
    <div>
      <p>用户登录</p>
    </div>
    <form id="loginform" name="loginform" method="post" action="">
      <label for="alias" style="Microsoft YaHei; font-size:12px;">Username:</label>
      <input type="text" name="alias" id="alias" tabindex="1">
      <label for="password" style="Microsoft YaHei; font-size:12px;">Password:</label>
      <input type="password" name="password" id="password" tabindex="2">
      <div>
      	<br/>
        <button type="button" class="btn btn-primary btn-sm" onClick="loginac()" id="loginbtn" name="loginbtn" tabindex="3">LogIn</button>
        <button type="button" class="btn btn-primary btn-sm" onClick="window.location.href='findpwd.jsp'" id="findpwdbtn" name="findpwdbtn" tabindex="4">找回密码</button>
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
  <ul class="daohang" id="navigator">
    <li><a href="index_1.jsp">主页</a></li>
    <li><a href="casemanagement.jsp">用例管理</a></li>
    <li><a href="#">结果管理</a></li>
    <li><a href="sutindex.jsp">接入申请</a></li>
    <li><a href="rolemanagement.jsp">用户权限</a></li>
    <%if (session.getAttribute("isAdmin") != null){
        String UserIsAdmin = String.valueOf(session.getAttribute("isAdmin"));
        if (UserIsAdmin == "true"){%>
    <li><a href="inimanager.jsp">隐藏用户权限for Admin</a></li>
    <li><a href="inidata.jsp">隐藏创建版本for Admin</a></li>
    <%}}%>
  </ul>
  <!--主体-->
  <table>
  <tr align="left">
  <td>
  	<button type="button" class="btn btn-primary btn-success" style="width:80px;text-align:center" onClick="window.location.href='applysut.jsp'">申请接入</button>
  </td>
  <tr>
    <td>&nbsp;</td>
  </tr>
  </tr>
  </table>
  <form id="queryForm" name="queryForm" action="">
    <table>
      <tr>
        <td style="width:50px">系统名</td>
        <td><input type="text" id="sutname" name="sutname" style="width:100px"></td>
        <td style="width:50px">申请人</td>
        <td><input type="text" id="applyer" name="applyer" style="width:100px"></td>
        <td>起始日期</td>
        <td><input class="easyui-datetimebox"  id="starttime" name="starttime" ></td>
        <td>截止日期</td>
        <td><input class="easyui-datetimebox"  id="endtime" name="endtime"></td>
      </tr>
      <tr>
      	<td colspan="8">&nbsp;</td>
      </tr>
      <tr align="center">
          <td colspan="8">
        <input type="button" id="querysut" class="btn btn-primary btn-sm"  style="width:80px" name="querysut" value="搜索">
          </td>
      </tr>
    </table>
  </form>
  
  <!--TABLE展示-->
  <table id="sutForm" class="table table-striped" style="text-align:center; width:80%" align="center">
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
  <div class="pagination"> <a href="#" class="first" data-action="first">&laquo;</a> <a href="#"
			class="previous" data-action="previous">&lsaquo;</a>
    <input
			type="text" readonly="readonly"/>
    <a href="#"
			class="next" data-action="next">&rsaquo;</a> <a href="#" class="last"
			data-action="last">&raquo;</a> </div></div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>