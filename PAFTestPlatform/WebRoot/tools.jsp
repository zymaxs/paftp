<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>辅助工具</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>

</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>
	<div id="main-wrap">
		<div id="container">
			<table>
				<tr>
					<td style="padding:20px">
						<div class="jumbotron" style="width:300px;height:300px">
							<p
								style="text-align:center;font-family:Microsoft YaHei;font-size:30px">查询验证码</p>
							<p style="text-align:center;font-family:Microsoft YaHei">
								<a class="btn btn-primary btn-lg" role="button" href="sms.jsp">点击进入</a>
							</p>
						</div>
					</td>
					<td>
						<div>&nbsp;&nbsp;</div>
					</td>
					<td style="padding:20px">
						<div class="jumbotron" style="width:300px;height:300px">
							<p
								style="text-align:center;font-family:Microsoft YaHei;font-size:30px">查询下发短信</p>
							<p style="text-align:center;font-family:Microsoft YaHei">
								<a class="btn btn-primary btn-lg" role="button" href="msg.jsp">点击进入</a>
							</p>
						</div>
					</td>
					<td>
						<div>&nbsp;&nbsp;</div>
					</td>
				</tr>
			</table>


		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>