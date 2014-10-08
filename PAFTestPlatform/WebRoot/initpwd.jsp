<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>

<script type="text/javascript">
	
<%String initAlias = "";
			if (session.getAttribute("user") == null
					|| session.getAttribute("user") == "") {%>
	window.location = "index.jsp";
<%} else {
				User initUser = (User) session.getAttribute("user");
				initAlias = (String) initUser.getAlias();
			}%>
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/initpwd/initpwd.css" rel="stylesheet" />
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
					<div class="input-group init_margin_bottom">
						<span class="input-group-addon init_addon_front">用户名 ：</span> <input type="text"
							class="form-control" id="alias" name="alias" readonly="true"
							value="<%=initAlias%>" />
					</div>
					<div class="input-group init_margin_bottom">
						<span class="input-group-addon init_addon_front">*初始密码 ：</span> <input
							type="password" class="form-control" id="originpassword"
							name="originpassword" />
					</div>
					<div class="input-group init_margin_bottom">
						<span class="input-group-addon init_addon_front">*新密码 ：</span> <input type="password"
							class="form-control" id="password" name="password" />
					</div>
					<div class="input-group init_margin_bottom">
						<span class="input-group-addon init_addon_front">*新密码确认 ：</span> <input type="password"
							class="form-control" id="confirm_password" name="confirm_password" />
					</div>
					<p>初始密码已发送到您的平安邮箱，收到后请修改初始密码，如果三分钟内未收到，请点击下方的重新获取密码</p>
					<p>
						如长时间未收到密码邮件，请在您的垃圾箱邮件中查询，并将
						<webmaster @papay.com>添加到白名单 
					</p>
					<div class="init_margin_top">
						<input type="button" id="changepwd" name="changepwd"
							onClick="changepwdac()" class="btn btn-primary init_button" value="确认">
						<input type="button" id="resendmai" name="resendmai"
							onClick="resendmailac()" class="btn btn-primary init_button" value="重新获取密码">
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