<!-- Fixed header -->
<div id="fixed-header-slide">
	<div id="fixed-header-wrap">
		<div id="fixed-header">
			<div class="fixed-header-nav">
				<ul class="top_navi">
					<li><a href="index.jsp" class="hover"
						style="font-family:Microsoft YaHei">主页</a>
					</li>
					<li><a href="casemanagement.jsp"
						style="font-family:Microsoft YaHei">用例管理</a>
					</li>
					<li><a href="resultmanagement.jsp"
						style="font-family:Microsoft YaHei">结果管理</a>
					</li>
					<li><a href="rolemanagement.jsp"
						style="font-family:Microsoft YaHei">用户权限</a>
					</li>
					<li><a href="sut.jsp" style="font-family:Microsoft YaHei">接入申请</a>
					</li>
					<li><a href="tools.jsp" style="font-family:Microsoft YaHei">辅助工具</a>
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
						style=";font-size:15px; font-family:Microsoft YaHei; text-align:right"><a
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
					<td class="head_version whitelink">Version : 1.0.1 | <a
						href="intro.jsp">Intro </a>| <a href="aboutus.jsp">AboutUs</a>
					</td>
					<td>&nbsp;&nbsp;</td>
				</tr>
			</table>
			<ul class="top_navi">
				<li><a href="index.jsp" style="font-family:Microsoft YaHei">主页</a>
				</li>
				<li><a href="casemanagement.jsp"
					style="font-family:Microsoft YaHei">用例管理</a>
				</li>
				<li><a href="resultmanagement.jsp"
					style="font-family:Microsoft YaHei">结果管理</a>
				</li>
				<li><a href="rolemanagement.jsp"
					style="font-family:Microsoft YaHei">用户权限</a>
				</li>
				<li><a href="sut.jsp" style="font-family:Microsoft YaHei">接入申请</a>
				</li>
				<li><a href="tools.jsp" style="font-family:Microsoft YaHei">辅助工具</a>
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