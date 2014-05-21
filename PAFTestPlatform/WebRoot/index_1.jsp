<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*"%>
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
<link href="css/style.css" rel="stylesheet" type="text/css">
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
          <div class="span2 whitelink"><a href="register.jsp">注册</a> | 登录</div>
        </div>
        <div class="row-fluid">
          <div class="span10"> </div>
          <div class="span2" style="text-align:right;font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
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
                <li class="active"> <a href="#">主页</a> </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!--主体-->
  <div align="center">
    <h1>HellWord！</h1>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p><small><b>自动化测试</b>：WebService | App | Web | Stress | Solution<br/>
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small></p>
  </div>
</div>
</body>
</html>