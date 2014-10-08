<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/findpassword/findpassword.css" rel="stylesheet">
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script src="JavaScript/findpassword/findpassword.js"></script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<form id="findpwdForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/getbakpwd.action">
				<div style="text-align: -webkit-center;">
					<h3>找回密码</h3>
					<div class="input-group findpwd_input">
						<span class="input-group-addon">* 用户名:</span> <input
							type="password" class="form-control" id="alias" name="alias" />
					</div>
					<p>用户名为您的平安邮箱前缀，邮件将发送至您的平安邮箱，请注意查收！</p>
					<button type="button" class="btn btn-primary findpwd_submitBtn"
						onclick="findpassword()">确定</button>
				</div>
			</form>



		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>