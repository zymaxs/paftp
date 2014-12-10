<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>短信验证码</title>
     <style type="text/css">
         .main-wrap a {
             font-size: 20px;
         }
 
         .over {
             display: none;
             position: absolute;
             top: 0;
             left: 0;
             width: 100%;
             height: 100%;
             background-color: #f5f5f5;
             opacity:0.5;
             z-index: 1000;
         }
 
         .layout {
             display: none;
             position: absolute;
             top: 40%;
             left: 40%;
             width: 20%;
             height: 20%;
             z-index: 1001;
             text-align:center;
         }
     </style>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/sms/sms.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
	function querySMSCode() {
		document.getElementById("over").style.display = "block";
        document.getElementById("layout").style.display = "block";
		var phoneNum = $("#phoneNum").val();
		var staging = $("#stg").val();
		var queryparams = {
			number : phoneNum,
			stg : staging
		};
		$.ajax({
			type : "POST",
			url : "querySmsCodeAjax.action",
			data : queryparams,
			dataType : "json",
			success : function(root) {
				$("#smsFormTab").html("");
				$(root.smsCodes).each(
						function(i, value) {
							$("#smsFormTab").append(
									"<tr>" + "<td>" + value.phoneNum + "</td>"
											+ "<td>" + value.code + "</td>"
											+ "<td>" + value.template + "</td>"
											+ "<td>" + value.time + "</td>"
											+ "</tr>");
						});
						document.getElementById("over").style.display = "none";
        				document.getElementById("layout").style.display = "none";

			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
				document.getElementById("over").style.display = "none";
        		document.getElementById("layout").style.display = "none";
				alert("查询失败，请稍后再试");
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
			<div class="input-group sms_phonenum">
				<span class="input-group-addon">手机号</span> <input type="text"
					class="form-control" placeholder="电话号码" id="phoneNum">
			</div>
			<div class="input-group sms_stg">
				<span class="input-group-addon">测试环境</span> <select id="stg"
					class="form-control">
					<option value="stg1" selected>stg1</option>
					<option value="stg2">stg2</option>
					<option value="stg3">stg3</option>
					<option value="stg5">stg5</option>
				</select>
			</div>

			<div>
				<input type="button" class="btn btn-primary btn-sm sms_button"
					style="width:80px; text-align:center" onClick="querySMSCode()"
					value="查询">
			</div>


			<!--TABLE展示-->
			<table id="smsForm" class="table table-striped"
				style="text-align:center; width:100%" align="center">
				<tr>
					<td>手机号</td>
					<td>验证码</td>
					<td>模板号</td>
					<td>发送时间</td>
				</tr>
				<tbody id="smsFormTab">
				</tbody>
			</table>
		</div>
		<!-- #container -->
	</div>
	<div id="over" class="over"></div>
    <div id="layout" class="layout"><div class="spinner">
  <div class="spinner-container container1">
    <div class="circle1"></div>
    <div class="circle2"></div>
    <div class="circle3"></div>
    <div class="circle4"></div>
  </div>
  <div class="spinner-container container2">
    <div class="circle1"></div>
    <div class="circle2"></div>
    <div class="circle3"></div>
    <div class="circle4"></div>
  </div>
  <div class="spinner-container container3">
    <div class="circle1"></div>
    <div class="circle2"></div>
    <div class="circle3"></div>
    <div class="circle4"></div>
  </div>
</div></div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>