<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>错误信息</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
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
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<div style="text-align:center">
				<p>操作失败！</p>
				<p><%=request.getAttribute("error")%></p>
				<p>
					<span id="settime">3</span>秒后自动返回上一级!
				</p>
			</div>

		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>