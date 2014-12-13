<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
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
</head>

<body>
	<!-- Fixed header -->
	<div id="fixed-header-slide">
		<div id="fixed-header-wrap">
			<div id="fixed-header">
				<div class="fixed-header-nav">
					<ul class="top_navi">
						<li><a href="index.jsp" class="hover">主页</a>
						</li>
						<li><a href="casemanagement.jsp">用例管理</a>
						</li>
						<li><a href="resultmanagement.jsp">结果管理</a>
						</li>
						<li><a href="rolemanagement.jsp">用户权限</a>
						</li>
						<li><a href="sut.jsp">接入申请</a>
						</li>						
						<%
							if (session.getAttribute("isAdmin") != null) {
								String UserIsAdmin = String.valueOf(session
										.getAttribute("isAdmin"));
								if (UserIsAdmin == "true") {
						%>
						<li><a href="inimanager.jsp">隐藏用户权限for Admin</a>
						</li>
						<li><a href="inidata.jsp">隐藏创建版本for Admin</a>
						</li>
						<%
							}
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- Header -->
	<div id="header-wrap">
		<div id="header">
			<div id="top_banner">
				<table class="top_table">
					<tr>
						<td>&nbsp;&nbsp;</td>
						<td class="head_com">平安付科技中心</td>
						<td colspan="7">&nbsp;</td>
						<%
							if (session.getAttribute("user") == null) {
						%>
						<td colspan="2" class="whitelink head_register"><a
							href="reg.jsp">注册</a> | <a href="#" data-toggle='modal'
							data-target='#loginModal'>登录</a>
						</td>
						<%
							} else {
								User user = (User) session.getAttribute("user");
								String header_name = user.getAlias();
						%>
						<td colspan="2" class="whitelink"
							style="font-size:15px; font-family:Microsoft YaHei; text-align:right"><a
							href="updateuserinfo.jsp"><%=header_name%> </a>| <a
							href="logout.jsp">登出</a></td>
						<%
							}
						%>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="12" class="head_platform">移动研发自动化测试平台</td>
					</tr>
					<tr>
						<td colspan="10">&nbsp;</td>
						<td class="head_version whitelink">Version : release 1.0.0 | <a
							href="intro.jsp">Intro </a>| <a
							href="aboutus.jsp">AboutUs</a></td>
						<td>&nbsp;&nbsp;</td>
					</tr>
				</table>
			</div>
		</div>
	</div>


	<!-- Login Modal -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:400px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">登录</h4>
				</div>
				<div class="modal-body">
					<form id="loginForm" name="loginForm" method="post" action="">
						<table align="center">
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon login_box">用户名</span> <input
											type="text" class="form-control" placeholder="UserName"
											id="loginUserName" name="alias" />
									</div></td>
							</tr>
							<tr>
								<td>
									<div class="input-group login_pwd">
										<span class="input-group-addon login_box">密码</span> <input
											type="password" class="form-control" placeholder="Password"
											id="loginPwd" name="password" />
									</div></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer" align="center">
					<div align="center">
						<button type="button" class="btn btn-primary login_box"
							onclick="loginac()">登录</button>
						<button type="button" class="btn btn-primary login_box"
							onClick="window.location.href='findpassword.jsp'">忘记密码</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="main-wrap">
		<div id="container">
			<div align="center">
				<table width="80%" height="410px">
					<tr>
						<td style="width:33%;cursor:pointer " onclick="window.location.href='casemanagement.jsp'" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#E07C24;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">用例管理</td>
								</tr>
								<tr>
									<td style="height:50px;background:#E3893B;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">编辑录入测试用例，用例评审，查询用例状态</td>
								</tr>
							</table>
						</td>
						<td style="width:10px"></td>
						<td style="width:33%;cursor:pointer" onclick="window.location.href='resultmanagement.jsp'" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#C84C4C;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">结果管理</td>
								</tr>
								<tr>
									<td style="height:50px;background:#CB5757;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">测试结果统计及查询，测试结果分析</td>
								</tr>
							</table>
						</td>
						<td style="width:10px"></td>
						<td style="width:33%;cursor:pointer" onclick="window.location.href='sms.jsp'" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#8D8781;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">辅助工具</td>
								</tr>
								<tr>
									<td style="height:50px;background:#97928C;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">辅助工具</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr style="height:10px">
						<td colspan="3"></td>
					</tr>
					<tr>
						<td style="width:33%;cursor:pointer" onclick="window.location.href='rolemanagement.jsp'" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#2DB1C0;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">权限管理</td>
								</tr>
								<tr>
									<td style="height:50px;background:#30BFCF;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">为待测系统分配用户权限，进行用例编辑和结果分析</td>
								</tr>
							</table>
						</td>
						<td style="width:10px"></td>
						<td style="width:33%;cursor:pointer" onclick="window.location.href='sut.jsp'" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#A4CB4E;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">接入申请</td>
								</tr>
								<tr>
									<td style="height:50px;background:#AED161;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">接入一个新的待测系统，进行自动化测试开发</td>
								</tr>
							</table>
						</td>
						<td style="width:10px"></td>
						<td style="width:33%;cursor:pointer" onclick="window.open('/doc/index.htm')" onmouseover="$(this).addClass('homebody');" onmouseout="$(this).removeClass('homebody');">
							<table width="100%" height="100%">
								<tr>
									<td
										style="height:150px;background:#C663D9;text-align:center;color:#FFFFFF;font-size: 40px;font-family:Microsoft YaHei">接口文档</td>
								</tr>
								<tr>
									<td style="height:50px;background:#CA6FDC;text-align:center;color:#FFFFFF;font-family:Microsoft YaHei">接口文档</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>