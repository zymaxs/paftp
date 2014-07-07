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
List<Role> roles = (List<Role>)request.getAttribute("currentPageRoles");
String pagenum = request.getAttribute("pages").toString();
User users = (User)request.getAttribute("user");
UserInfo userinfo = (UserInfo) users.getUserInfo();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/shou.css" rel="stylesheet">
<link href="css/jqpagination.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="js/jQSelect.js"></script>
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
		othermail = userinfo.getOtherinfo();
	}
	;
%>
<script type="text/javascript">
var pagentotal = <%=pagenum%>;
var params;
$(document).ready( function(){
	$("#roleFormTab").append(inidata());
		
	$('.pagination').jqPagination({
		link_string : '/?page={page_number}',
		max_page : pagentotal, 
		paged : function(page) {
			params = {pagenum:page,userid:$("#id").val()};
		$.ajax({
				type : "POST",
				url : "getUserInfoAjax.action",
				data : params,
				dataType : "json",
				success : function(root) {

					$("#roleFormTab").html("");
					$(root.currentPageRoles).each(function(i,value){
						if (value.sut == null)
							$("#sutFormTab").append("<tr>"+"<td>"+value.name+"</td>"+"<td>"+value.description+"</td>"+"</tr>");
						else
							$("#sutFormTab").append("<tr>"+"<td>"+value.name+"</td>"+"<td>"+value.sut.name+"</td>"+"<td>"+value.description+"</td>"+"</tr>");
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
<style>
/*导航默认样式，可根据实际情况修改*/
* {
	margin:0;
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
    <%} else { User loginuser = (User) session.getAttribute("user");
                      String name = loginuser.getAlias(); %>
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
      <div> <br/>
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
  <div>
    <fieldset>
      <legend> 用户信息 </legend>
      <table style="width:40%" align="left" class="table table-striped">
      	<tr>
        <td>&nbsp;&nbsp;Alias&nbsp;&nbsp;:</td>
        <td><%=username%></td>
        </tr>
        <tr>
          <td>真实姓名 :</td>
          <td ><%=displayname%></td>
        </tr>
        <tr>
          <td>所属部门 :</td>
          <td ><%=department%></td>
        </tr>
        <tr>
          <td>当前职位 :</td>
          <td ><%=position%></td>
        </tr>
        <tr>
          <td>移动电话 :</td>
          <td ><%=mobile%></td>
        </tr>
        <tr>
          <td>座式电话 :</td>
          <td ><%=telephone%></td>
        </tr>
        <tr>
          <td>其他邮件 :</td>
          <td ><%=othermail%></td>
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
      <table id="roleForm" class="table table-bordered" style="width:80%" align="left">
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
  <div class="pagination"> <a href="#" class="first" data-action="first">&laquo;</a> <a href="#"
			class="previous" data-action="previous">&lsaquo;</a>
    <input
			type="text" readonly="readonly"/>
    <a href="#"
			class="next" data-action="next">&rsaquo;</a> <a href="#" class="last"
			data-action="last">&raquo;</a> </div>
  
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>