<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*,com.paftp.entity.*" errorPage=""%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	if (session.getAttribute("user") == null) {
%>
<Meta http-equiv="refresh" content="0;url='index_1.jsp'; ">
<%
	}
%>
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<style>
.whitelink A:link {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}

.whitelink A:visited {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}

.whitelink A:hover {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}

.whitelink A:active {
	COLOR: #ffffff;
	TEXT-DECORATION: none
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#updateinfoForm").validate({
			rules : {
				"displayname" : {
					required : true,
					maxlength : 10
				},
				"department" : {
					required : true,
					maxlength : 15
				},
				"position" : {
					required : true
				},
				"othermail" : {
					email : true
				}
			},
			messages : {
				"displayname" : {
					required : "请输入真实姓名",
					maxlength : $.validator.format("真实姓名最大输入不超过十个字符.")
				},
				"department" : {
					required : "请输入所属部门",
					maxlength : $.validator.format("所属部门最大输入最大输入不超过十五个字符.")
				},
				"othermail" : {
					email : "请输入正确的email地址"
				}
			}
		});
		$("#updatepwdForm").validate({
			rules : {
				"orignpassword" : {
					required : true,
				},
				"password" : {
					required : true,
					rangelength : [ 6, 30 ]
				},
				"confirm_password" : {
					required : true,
					rangelength : [ 6, 16 ],
					equalTo : "#password"
				}
			},
			messages : {
				"orignpassword" : {
					required : "请输入旧密码"
				},
				"password" : {
					required : "请输入新密码",
					rangelength : "密码长度6位至16位之间"
				},
				"confirm_password" : {
					required : "请输入密码",
					rangelength : "密码长度6位至16位之间",
					equalTo : "两次输入密码不一致"
				}
			}
		});
	});
</script>
<%
	User user = (User) session.getAttribute("user");
	String s = user.getUserInfo().getDepartment();
	UserInfo userinfo = (UserInfo) user.getUserInfo();
	String name = "";
	String displayname = "";
	String department = "";
	String position = "";
	String mobile = "";
	String telephone = "";
	String othermail = "";

	if (user.getAlias() != null) {
		name = user.getAlias();
	}

	if (user.getDisplayName() != null) {
		displayname = user.getDisplayName();
	}

	if (userinfo.getDepartment() != null) {
		department = userinfo.getDepartment();
	}

	if (userinfo.getPosition() != null) {
		position = userinfo.getPosition();
	}

	if (userinfo.getMobile() != null) {
		mobile = userinfo.getMobile();
	}
	;

	if (userinfo.getTelephone() != null) {
		telephone = userinfo.getTelephone();
	}
	;

	if (userinfo.getOthermail() != null) {
		othermail = userinfo.getOthermail();
	}
	;
%>
</head>

<body>
	<div class="container-fluid">
		<!--网页头部-->
		<div style="background:#428bca; color:#ffffff; margin:auto">
			<div class="row-fluid">
				<div class="span12">
					<div class="row-fluid">
						<div class="span12"></div>
					</div>
					<div class="row-fluid">
						<div class="span2"
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
						<div class="span7"></div>
						<div class="span3 whitelink"
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">
							<a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12"
							style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
					</div>
					<div class="row-fluid">
						<div class="span10"></div>
						<div class="span2"
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">Version
							: beta 0.3.0</div>
					</div>
				</div>
			</div>
		</div>
		<!--导航-->
		<div class="row-fluid">
			<div class="span12">
				<div class="navbar">
					<div class="navbar-inner">
						<div class="container-fluid">
							<div class="nav-collapse collapse navbar-responsive-collapse">
								<ul class="nav">
									<li class="active"><a href="index_1.jsp">主页</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--主体-->
		<div>
			<form id="updateinfoForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/updateuserinfo.action">
				<fieldset>
					<legend>
						用户信息更新 <small>(带*号标志为必输项)</small>
					</legend>
					<div class="control-group">
						<label class="control-label" for="displayname">* 真实姓名 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="displayname"
								name="displayname" value="<%=displayname%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="department">* 所属部门 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="department"
								name="department" value="<%=department%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="position">* 职位 :</label>
						<div class="controls">
							<select id="position" class="input-xlarge" name="position"
								value="<%=position%>">
								<option>测试</option>
								<option>开发</option>
								<option>产品</option>
								<option>其他</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="telephone">联系电话 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="telephone"
								name="telephone" value="<%=telephone%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="mobile">移动电话 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="mobile" name="mobile"
								value="<%=mobile%>">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="othermail">其他邮件 :</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="othermail"
								name="othermail" value="<%=othermail%>">
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</fieldset>
			</form>
		</div>
		<div>
			<form id="updatepwdForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/updatepassword.action">
				<fieldset>
					<legend>用户密码修改</legend>
					<div class="control-group">
						<label class="control-label" for="orignpassword">* 旧密码 :</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="orignpassword"
								name="orignpassword">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="password">* 新密码 :</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="password"
								name="password">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="confirm_password">* 确认密码
							:</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="confirm_password"
								name="confirm_password">
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</fieldset>
			</form>
		</div>
		<!--网页底部-->
		<div style="background:#428bca; color:#ffffff; text-align:center">
			<p>
				<small><b>自动化测试</b>：WebService | App | Web | Stress |
					Solution<br /> Copyright© 2013-2016 平安付科技中心移动研发系统测试</small>
			</p>
		</div>
	</div>
</body>
</html>