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
<link href="css/sms/sms.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
	function querySMSCode() {
		$("#queryButton").attr({
			value : "加载中",
			disabled : "disabled"
		});
		var phoneNum = $("#phoneNum").val();
		var staging = $("#stg").val();
		var queryparams = {
			number : phoneNum,
			stg : staging
		};
		$.ajax({
			type : "POST",
			url : "queryMsgAjax.action",
			data : queryparams,
			dataType : "json",
			success : function(root) {
				$("#queryButton").attr("value", "查询").removeAttr("disabled");
				$("#smsFormTab").html("");
				$(root.smsCodes).each(
						function(i, value) {
							$("#smsFormTab").append(
									"<tr>" + "<td>" + value.phoneNum + "</td>"
											+ "<td>" + value.channel + "</td>"
											+ "<td>" + value.template + "</td>"
											+ "<td>" + value.msg + "</td>"
											+ "<td>" + value.time + "</td>"
											+ "</tr>");
						});
				var smsCountHtml = "已累计查询" + root.count + "次";
				$("#queryCount").html(smsCountHtml);

			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$("#queryButton").attr("value", "查询").removeAttr("disabled");
				alert("查询失败，请稍后再试");
			}
		});

	};

	function queryCount() {
		$.ajax({
			type : "POST",
			url : "getQueryCountAjax.action",
			data : {countId:2},
			dataType : "json",
			success : function(root) {
				var smsCountHtml = "已累计查询" + root.count + "次";
				$("#queryCount").html(smsCountHtml);

			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}

	$(document).ready(function() {
		queryCount();
	});
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>
	<div id="main-wrap">
		<div id="container">
			<div class="input-group sms_phonenum">
				<span class="input-group-addon">手机号</span> <input type="text"
					class="form-control" placeholder="可选填" id="phoneNum">
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
				<input type="button" id="queryButton"
					class="btn btn-primary btn-sm sms_button"
					style="width:80px; text-align:center" onClick="querySMSCode()"
					value="查询">
			</div>

			<p id="queryCount" class="sms_count"></p>


			<!--TABLE展示-->
			<table id="smsForm" class="table table-striped"
				style="text-align:center; width:100%" align="center">
				<tr>
					<td>手机号</td>
					<td>短信渠道</td>
					<td>模板号</td>
					<td>短信内容</td>
					<td>发送时间</td>
				</tr>
				<tbody id="smsFormTab">
				</tbody>
			</table>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>