<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.paftp.entity.*" errorPage="" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
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
$().ready(function() {
 $("#updatepwdForm").validate({
   rules: {
   	orignpassword: "required",
   	npassword: {
   		required: true,
   		rangelength: [6, 16]
   	},
   	confirm_password: {
    	required: true,
    	rangelength: [6, 16],
		equalTo: "#npassword"
   	}
  },
  messages: {
   orignpassword: "请输入密码",
   npassword: {
    required: "请输入密码",
    rangelength: "密码长度6位至16位之间"
   },
   confirm_password: {
    required: "请输入密码",
    rangelength: "密码长度6位至16位之间",
	equalTo: "两次输入密码不一致"
   }
  }
  });

});
</script>
<script type="text/javascript">
function resetpwdac() 
{ 
document.updatepwdForm.action="${pageContext.request.contextPath}/updatepassword.action";
if($("#updatepwdForm").valid()){
    $("#updatepwdForm").submit();
}

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
  <div id="loginmodal" style="display:none;">
    <h1>User Login</h1>
    <form id="loginform" name="loginform" method="post" action="${pageContext.request.contextPath}/login.action">
      <label for="username">Username:</label>
      <input type="text" name="username" id="username" class="txtfield" tabindex="1">
      <label for="password">Password:</label>
      <input type="password" name="password" id="password" class="txtfield" tabindex="2">
      <div class="center">
        <input type="submit" name="loginbtn" id="loginbtn" class="flatbtn-blu hidemodal" value="Log In" tabindex="3">
      </div>
    </form>
  </div>
  <script type="text/javascript">
	$(function(){
	$('#login').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
	});
  </script> 
  <!--导航-->
  <ul class="daohang" id="navigator">
    <li><a href="index_1.jsp">主页</a></li>
    <li><a href="casemanagement.jsp">用例管理</a></li>
    <li><a href="resultmanagement.jsp">结果管理</a></li>
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
    <form id="updatepwdForm" name="updatepwdForm" class="form-horizontal" method="post" action="">
      <fieldset>
        <legend>用户初始密码修改</legend>
        <div class="control-group">
          <label class="control-label" for="orignpassword">* 旧密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="orignpassword" name="orignpassword">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="npassword">* 新密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="npassword" name="password">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="confirm_password">* 确认密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="confirm_password" name="confirm_password">
          </div>
        </div>
        <div class="form-actions">
          <input type="button" name="resetpwd" id="resetpwd" class="flatbtn-blu hidemodal" value="修改初始密码" onClick="resetpwdac()">
        </div>
      </fieldset>
    </form>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p><small><b>自动化测试</b>：WebService | App | Web | Stress | Solution<br/>
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small></p>
  </div>
</div>
</body>
</html>