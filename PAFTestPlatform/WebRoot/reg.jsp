<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag") == null) {
		request.getRequestDispatcher(
				"${pageContext.request.contextPath}/reguserinfo.action")
				.forward(request, response);
	}
	List<String> departments = (List<String>) request
			.getAttribute("departments");
	List<String> positions = (List<String>) request
			.getAttribute("positions");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>注册用户</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/register/register.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script type="text/javascript" src="JavaScript/jquery.validate.js"></script>
<script src="JavaScript/common/common.js"></script>
<script src="JavaScript/register/register.js"></script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>
	<div id="main-wrap">
		<div id="container">
			<form id="signupForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/register.action">
				<fieldset>
					<legend>
						用户注册 <small>(带*号标志为必输项)</small>
					</legend>
					<table border="0">
						<tr>
							<td colspan="2"><div class="input-group">
									<span class="input-group-addon reg_addon_front">* 用户名</span> <input
										type="text" class="form-control" placeholder="UserName"
										id="regAlias" maxlength="30" name="alias"
										onKeyUp="quanjiao(this);" /> <span
										class="input-group-addon reg_addon_after">@pingan.com.cn</span>
								</div>
								<p class="help-block">请使用自己的域账号进行注册，初始密码将发送至你的平安邮箱。请在首次登录时完成密码修改。</p>
							</td>
						</tr>
						<tr>
							<td colspan="2"><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">* 真实姓名</span> <input
										type="text" class="form-control" name="displayname"
										id="regDisplayName" maxlength="10" />
								</div>
							</td>
						</tr>
						<tr>
							<td><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">* 所属部门</span> <select
										class="form-control" id="department" name="department">
										<option value="<%=departments.get(0)%>" selected><%=departments.get(0)%></option>
										<%
											for (int i = 1; i < departments.size(); i++) {
										%>
										<option value="<%=departments.get(i)%>"><%=departments.get(i)%></option>
										<%
											}
										%>
									</select>
								</div>
							</td>
							<td><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">* 职 位</span> <select
										class="form-control" id="position" name="position">
										<option value="<%=positions.get(0)%>" selected><%=positions.get(0)%></option>
										<%
											for (int i = 1; i < positions.size(); i++) {
										%>
										<option value="<%=positions.get(i)%>"><%=positions.get(i)%></option>
										<%
											}
										%>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">联系电话</span> <input
										type="text" class="form-control" id="telephone"
										name="telephone" />
								</div>
							</td>
							<td><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">移动电话</span> <input
										type="text" class="form-control" id="mobile" name="mobile" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">其他邮件</span> <input
										type="text" class="form-control" id="othermail"
										name="othermail" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"><div class="input-group reg_input_group_div">
									<span class="input-group-addon reg_addon_front">用户备注</span>
									<textarea class="form-control" id="otherinfo" name="otherinfo"></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><button type="button"
									class="btn btn-primary" style="width:80px;"
									onclick='signupFormCheck();'>保存</button>
							</td>
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