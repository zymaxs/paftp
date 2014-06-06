<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
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

<script language="javascript">
 var i=2;
 window.setInterval("settime()",1000);
 window.setTimeout("toload()",3000);
 function settime(){
    var divinner=document.getElementById("settime");
    divinner.innerText=i;
    i--;
 }
 function toload(){
    history.go(-1);
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
          <div class="span2" style="text-align:left;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
          <div class="span7"></div>
          <div class="span3"></div>
        </div>
        <div class="row-fluid">
          <div class="span2"></div>
          <div class="span8" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
          <div class="span2 whitelink"><a href="register.jsp">注册</a> |<a href="#loginmodal" id="login"> 登录</a></div>
        </div>
        <div class="row-fluid">
          <div class="span10"> </div>
          <div class="span2" style="text-align:right;font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
        </div>
      </div>
    </div>
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
  <div class="row-fluid">
    <div class="span12">
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container-fluid">
            <div class="nav-collapse collapse navbar-responsive-collapse">
              <ul class="nav">
                <li class="active"><a href="index_1.jsp">主页</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <div align="center" style="height:600px">
    <div>
      <p>操作失败！</p>
      <p><%=request.getAttribute("error")%></p>
      <p><span id="settime">3</span>秒后自动返回上一级!</p>
    </div>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p><small><b>自动化测试</b>：WebService | App | Web | Stress | Solution<br/>
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small></p>
  </div>
</div>
</body>
</html>