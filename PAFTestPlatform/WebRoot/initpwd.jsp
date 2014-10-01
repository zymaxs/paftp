<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%if(session.getAttribute("user") == null)
{%>
<script>
window.location.href="index.jsp";
</scripe>
<%}%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script src="JavaScript/initpwd/initpwd.js"></script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<form id="updatepwdform" name="updatepwdform" class="form-horizontal"
				method="post" action="">
				<fieldset>
					<legend>用户初始密码修改</legend>
					<div class="control-group">
						<label class="control-label" for="alias">用户名 :</label>
						<div class="controls">
							<input type="text" readonly="true" class="input-xlarge"
								id="alias" name="alias"
								value="<%=request.getAttribute("alias")%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="originpassword">* 初始密码 :</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="originpassword"
								name="originpassword">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="password">* 新密码 :</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="password"
								name="password">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="confirm_password">* 确认密码
							:</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="confirm_password"
								name="confirm_password">
						</div>
					</div>
					<p>初始密码已发送到您的平安邮箱，收到后请修改初始密码，如果三分钟内未收到，请点击下方的重新获取密码</p>
					<p>
						如长时间未收到密码邮件，请在您的垃圾箱邮件中查询，并将
						<webmaster @papay.com>添加到白名单 
					</p>
					<div class="form-actions">
						<input type="button" id="changepwd" name="changepwd"
							onClick="changepwdac()" class="btn btn-primary" value="确认">
						<input type="button" id="resendmai" name="resendmai"
							onClick="resendmailac()" class="btn btn-primary" value="重新获取密码">
					</div>
				</fieldset>
			</form>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>