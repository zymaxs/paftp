<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (session.getAttribute("user") == null) {
%>
window.location = "index_1.jsp";
<%
	}
	if (request.getAttribute("flag") == null) {
		request.getRequestDispatcher(
				"${pageContext.request.contextPath}/upuserinfo.action")
				.forward(request, response);
	}
	List<String> departments = (List<String>) request
			.getAttribute("departments");
	List<String> positions = (List<String>) request
			.getAttribute("positions");
	String name = "";
	String displayname = "";
	String department = "";
	String position = "";
	String mobile = "";
	String telephone = "";
	String othermail = "";
	String otherinfo = "";
	if (session.getAttribute("user") != null) {
		User user = (User) session.getAttribute("user");
		UserInfo userinfo = (UserInfo) user.getUserInfo();

		if (user.getAlias() != null) {
			name = user.getAlias();
		}

		if (user.getDisplayName() != null) {
			displayname = user.getDisplayName();
		}

		if (userinfo.getDepartment() != null
				&& userinfo.getDepartment().getName() != null) {
			department = userinfo.getDepartment().getName();
		}

		if (userinfo.getPosition() != null
				&& userinfo.getPosition().getName() != null) {
			position = userinfo.getPosition().getName();
		}

		if (userinfo.getMobile() != null) {
			mobile = userinfo.getMobile();
		}

		if (userinfo.getTelephone() != null) {
			telephone = userinfo.getTelephone();
		}

		if (userinfo.getOthermail() != null) {
			othermail = userinfo.getOthermail();
		}

		if (userinfo.getOtherinfo() != null) {
			otherinfo = userinfo.getOtherinfo();
		}
	}
%>
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
<script src="JavaScript/updateuserinfo/updateuserinfo.js"></script>
<script type="text/javascript">
function initSelect(){
	var selected_department = "<%=department%>";
	var selected_position = "<%=position%>";
	var select_department = document.getElementById("department");
	var select_position = document.getElementById("position");
	for(var i=0; i<select_department.options.length; i++){  
	    if(select_department.options[i].innerHTML == selected_department){  
	    	select_department.options[i].selected = true;  
	        break;  
	    }  
	}
	for(var i=0; i<select_position.options.length; i++){  
	    if(select_position.options[i].innerHTML == selected_position){  
	    	select_position.options[i].selected = true;  
	        break;  
	    }  
	}
	
	
}
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<div>
				<form id="updateinfoForm" class="form-horizontal" method="post"
					action="${pageContext.request.contextPath}/updateuserinfo.action">
					<fieldset>
						<legend>
							用户信息更新 <small>(带*号标志为必输项)</small>
						</legend>
						<table style="width:40%" align="left" class="table table-striped">
							<tr>
								<td colspan="2">
									<div class="input-group">
										<span class="input-group-addon">* 真实姓名 :</span> <input
											class="form-control" id="displayname" name="displayname"
											maxlength="10" value="<%=displayname%>" />
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon">* 所属部门</span> <select
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
								<td><div class="input-group">
										<span class="input-group-addon">* 职 位</span> <select
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
								<td colspan="2">
									<div class="input-group">
										<span class="input-group-addon">联系电话 :</span> <input
											class="form-control" id="telephone" name="telephone"
											value="<%=telephone%>" />
									</div></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="input-group">
										<span class="input-group-addon">移动电话 :</span> <input
											class="form-control" id="mobile" name="mobile"
											value="<%=mobile%>" />
									</div></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="input-group">
										<span class="input-group-addon">其他邮件 :</span> <input
											class="form-control" id="othermail" name="othermail"
											value="<%=othermail%>" />
									</div></td>
							</tr>
							<tr>
								<td colspan="2"><div
										class="input-group reg_input_group_div">
										<span class="input-group-addon reg_addon_front">用户备注</span>
										<textarea class="form-control" id="otherinfo" name="otherinfo"><%=otherinfo%></textarea>
									</div></td>
							</tr>
							<tr align="center">
								<td colspan="2"><button type="button"
										class="btn btn-primary" style="width:80px; text-align:center"
										onclick='updateUserInfo();'>提交</button></td>
							</tr>
						</table>
					</fieldset>
				</form>
			</div>
			<div>
				<form id="updatepwdForm" class="form-horizontal" method="post"
					action="${pageContext.request.contextPath}/updatepassword.action">
					<fieldset>
						<legend>用户密码修改</legend>
						<table style="width:40%" align="left" class="table table-striped">
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon">* 旧密码 :</span> <input
											type="password" class="form-control" id="orignpassword"
											name="orignpassword" />
									</div></td>
							</tr>
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon">* 新密码 :</span> <input
											type="password" class="form-control" id="password"
											name="password" />
									</div></td>
							</tr>
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon">* 确认密码 :</span> <input
											type="password" class="form-control" id="confirm_password"
											name="confirm_password" />
									</div></td>
							</tr>
							<tr align="center">
								<td><button type="button" class="btn btn-primary"
										style="width:80px; text-align:center"
										onclick='updateUserPwd();'>提交</button></td>
							</tr>
						</table>
					</fieldset>
				</form>
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>