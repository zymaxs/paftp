<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*,com.paftp.entity.*" errorPage="" %>
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
 $("#updatepwdform").validate({
        rules: {
   orignpassword: "required",
   password: {
    required: true,
    rangelength: [6, 30]
   },
   	confirm_password: {
    	required: true,
    	rangelength: [6, 16],
		equalTo: "#password"
   	}
  },
        messages: {
   orignpassword: "请输入密码",
   password: {
    required: "请输入密码",
    rangelength: jQuery.format("密码长度6位至16位之间")
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
function changepwdac() 
{ 
document.updatepwdform.action="${pageContext.request.contextPath}/changepwd.action";
 if($("#updatepwdform").valid()){
     $("#updatepwdform").submit();
 }
} 
function resendmailac() 
{ 
document.updatepwdform.action="${pageContext.request.contextPath}/getbakpwd.action";
document.updatepwdform.submit();
} 
</script>
</head>

<body>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff;"> <br>
    <div class="row">
      <div class="col-md-2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> 平安付科技中心 </div>
      <div class="col-md-7"></div>
      <%if (session.getAttribute("user") == null) {%>
      <div class="col-md-3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </div>
      <%} else { User user = (User) session.getAttribute("user");
                      String name = user.getAlias(); %>
      <div class="col-md-3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </div>
      <%}%>
    </div>
    <div class="row">
      <div class="col-md-12" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
    </div>
    <div class="row">
      <div class="col-md-10"></div>
      <div class="col-md-2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
    </div>
    <br>
  </div>
  <!--导航-->
  <nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
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
      </div>
      <!-- /.navbar-collapse --> 
    </div>
    <!-- /.container-fluid --> 
  </nav>
  <!--主体-->
  <div>
    <form id="updatepwdform" name="updatepwdform" class="form-horizontal" method="post" action="">
      <fieldset>
        <legend>用户初始密码修改</legend>
        <div class="control-group">
          <label class="control-label" for="alias">用户名 :</label>
          <div class="controls">
            <input type="text" readonly="true" class="input-xlarge" id="alias" name="alias" value="<%=request.getAttribute("alias")%>">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="originpassword">* 初始密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="originpassword" name="originpassword">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password">* 新密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="password" name="password">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="confirm_password">* 确认密码 :</label>
          <div class="controls">
            <input type="password" class="input-xlarge" id="confirm_password" name="confirm_password">
          </div>
         </div>
         <p>初始密码已发送到您的平安邮箱，收到后请修改初始密码，如果三分钟内未收到，请点击下方的重新获取密码</p>
         <p>如长时间未收到密码邮件，请在您的垃圾箱邮件中查询，并将<webmaster@papay.com>添加到白名单</p>
        <div class="form-actions">
          <input type="button" id="changepwd" name="changepwd" onClick="changepwdac()" class="btn btn-primary" value="确认">
          <input type="button" id="resendmai" name="resendmai" onClick="resendmailac()" class="btn btn-primary" value="重新获取密码">
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