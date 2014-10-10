<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("initialSutflag") == null) {
		request.getRequestDispatcher(
		"${pageContext.request.contextPath}/initialSut.action")
		.forward(request, response);
	}
	if (request.getAttribute("flag") == null) {
		request.getRequestDispatcher(
		"${pageContext.request.contextPath}/showsutgroup.action")
		.forward(request, response);
	}
	List<String> sutgroup = (List<String>) request
	.getAttribute("sutgroupnames");
	String isLogin = "test";
	String isAdmin = "test";
	String alias = "";
	Integer sut_id = 0;
	if (session.getAttribute("user") != null) {
		isLogin = "y";
		User userinfo = (User) session.getAttribute("user");
		alias = userinfo.getAlias();
	} else {
		isLogin = "n";
	}
	;

	if ((String) request.getAttribute("isAdmin") != null) {
		isAdmin = "y";
	} else {
		isAdmin = "n";
	}
	;

	ApplySut applySut = (ApplySut) request.getAttribute("applySut");
	if (request.getAttribute("sut_id") != null) {
		sut_id = (Integer) request.getAttribute("sut_id");
	}
	String applyer = applySut.getUser().getAlias();
	int id = applySut.getId();
%>
<script type="text/javascript">
var alias = '<%=alias%>';
var isLogin = '<%=isLogin%>';
var isAdmin = '<%=isAdmin%>';
var applyer = '<%=applyer%>';
var selected_groupname = "<%=applySut.getGroup().getName()%>";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>系统申请详情</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script src="JavaScript/applysutinfo/applysutinfo.js"></script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<form id="sutinfoform" name="sutinfoform" class="form-horizontal"
				method="post" action="">
				<fieldset>
					<legend>
						接入系统申请详情页 <small>(带*号标志为必输项)</small>
					</legend>
					<table>
						<tr>
							<td><div class="input-group">
									<span class="input-group-addon">* 系统名 :</span> <input
										type="text" class="form-control" name="sutname" id="sutname"
										value="<%=applySut.getName()%>" readonly />
								</div>
							</td>
						</tr>
						<tr style="display:none">
							<td><input type="text" class="form-control" id="sut_id"
								name="sut_id" value="<%=sut_id%>">
							</td>
						</tr>
						<tr>
							<td><div class="input-group">
									<span class="input-group-addon">申请状态 :</span> <input
										type="text" class="form-control" name="sutstatus"
										id="sutstatus"
										value="<%=applySut.getApplysutstatus().getDescription()%>"
										disabled />
								</div>
							</td>
						</tr>
						<tr>
							<td><div class="input-group">
									<span class="input-group-addon">* 系统所属平台 :</span> <input
										type="text" class="form-control"
										value="<%=applySut.getGroup().getName()%>" id="show_groupname"
										readonly /> <select class="form-control" id="groupname"
										name="groupname" style="display:none">
										<option value="<%=sutgroup.get(0)%>" selected><%=sutgroup.get(0)%></option>
										<%
											for (int i = 1; i < sutgroup.size(); i++) {
										%>
										<option value="<%=sutgroup.get(i)%>"><%=sutgroup.get(i)%></option>
										<%
											}
										%>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td><div class="input-group">
									<span class="input-group-addon">* 系统中文名 :</span> <input
										type="text" class="form-control" name="code" id="code"
										value="<%=applySut.getCode()%>" readonly />
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon">* 系统描述 :</span>
									<textarea class="form-control" id="description"
										name="description"
										style=" width:100px; max-height:100px; width:200px; max-width:200px"
										readonly><%=applySut.getDescription()%></textarea>
								</div></td>
						</tr>
						<tr>
							<td><input type="text" id="id" name="id" value="<%=id%>"
								style="display:none"></td>
						</tr>
						<tr>
							<td>
								<table>
									<tr>
										<td width="100px"><input type="button" id="approvebtn"
											name="approvebtn" class="btn btn-primary btn-sm"
											style="width:80px; text-align:center" value="通过"
											onClick="approveac()"></td>
										<td width="100px"><input type="button" id="rejectbtn"
											name="rejectbtn" class="btn btn-primary btn-sm"
											style="width:80px; text-align:center" value="拒绝"
											onClick="rejectac()"></td>
										<td width="100px" id="updatebtnTd" style="display:block"><input
											type="button" id="updatebtn" name="uptadebtn"
											class="btn btn-primary btn-sm"
											style="width:80px; text-align:center;" value="修改"
											onClick="updateac()"></td>
										<td width="100px" id="savebtnTd" style="display:none"><input
											type="button" id="savebtn" name="savebtn"
											class="btn btn-primary btn-sm"
											style="width:80px; text-align:center;" value="更新"
											onClick="saveac()"></td>
									</tr>
								</table></td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>