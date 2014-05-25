<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
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
  <div>
			<form id="updateinfoForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/updateuserinfo.action">
				<fieldset>
					<legend>系统申请详情</legend>
					<div class="control-group">
						<label class="control-label" for="displayname">* 真实姓名 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="displayname"
								name="displayname" value="<%=displayname%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="department">* 所属部门 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="department"
								name="department" value="<%=department%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="position">* 职位 :</label>
						<div class="controls">
							<select id="position" class="input-xlarge" name="position"
								value="<%=position%>">
								<option>测试</option>
								<option>开发</option>
								<option>产品</option>
								<option>其他</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="telephone">联系电话 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="telephone"
								name="telephone" value="<%=telephone%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="mobile">移动电话 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="mobile" name="mobile"
								value="<%=mobile%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="othermail">其他邮件 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="othermail"
								name="othermail" value="<%=othermail%>">
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</fieldset>
			</form>
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