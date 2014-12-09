<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>短信验证码</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
	function querySMSCode() {
		var phoneNum = $("#phoneNum").val();
		var staging = $("#stg").val();
		var queryparams = {number:phoneNum,stg:staging};
		$.ajax({
			type : "POST",
			url : "querySmsCodeAjax.action",
			data : queryparams,
			dataType : "json",
			success : function(root) {
				alert(root);

			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(textStatus);
			}
		});

	};
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<div>
				<input type="text" id="phoneNum" style="width:100px">
			</div>
			<div>
				<select id="stg" style="width:100%">
					<option value="stg1" selected>stg1</option>
					<option value="stg2">stg2</option>
					<option value="stg3">stg3</option>
					<option value="stg5">stg5</option>
				</select>
				</td>
			</div>
			<div>
				<input type="button" class="btn btn-primary btn-sm"
					style="width:80px; text-align:center" onClick="querySMSCode()"
					value="查询">
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>


</body>
</html>