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
          <div class="span2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
          <div class="span7"></div>
          <% User user = (User)session.getAttribute("user");
		  	 String name = user.getAlias();%>
          <div class="span3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name %> </a>| <a href="#loginmodal" id="logout">登出</a></div>
        </div>
        <div class="row-fluid">
          <div class="span12" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
        </div>
        <div class="row-fluid">
          <div class="span10"> </div>
          <div class="span2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
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