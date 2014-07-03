<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (session.getAttribute("user") == null) {
%>
<Meta http-equiv="refresh" content="0;url='index_1.jsp'; ">
<%
	}
%>
<%
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/sutinitialAddRelationship.action").forward(request,response);}
String isAdmin = String.valueOf(request.getAttribute("isAdmin"));
String isManager = String.valueOf(request.getAttribute("isManager"));
List<User> managers = (List<User>)request.getAttribute("managers");
List<User> workers = (List<User>)request.getAttribute("workers");
List<User> freeusers = (List<User>)request.getAttribute("freeusers");
String sut_name = (String)request.getAttribute("sut_name");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
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
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	};
	
	function updateroleac(){
		document.getElementById('managerstring').value = finmanager();
		document.getElementById('workerstring').value = finworker();
		document.userroleForm.action = "${pageContext.request.contextPath}/sutaddRelationship.action";
		document.userroleForm.submit();
		};
	
	
	function finfreeuser(){
		var finalfreeuser = "";
		for (i = 0; i < document.getElementById('freeuser').length ; i++ ){
			finalfreeuser += document.getElementById('freeuser').options[i].value + ";";
			}
		return finalfreeuser;
	};
	
	function finmanager(){
		var finalmanager = "";
		for (i = 0; i < document.getElementById('manage').length ; i++ ){
			finalmanager += document.getElementById('manage').options[i].value + ";";
			}
		return finalmanager;
	};
	
	function finworker(){
		var finalworker = "";
		for (i = 0; i < document.getElementById('worker').length ; i++ ){
			finalworker += document.getElementById('worker').options[i].value + ";";
			}
		return finalworker;
	};
	
	function ini(){
		if ('<%=isAdmin%>' == "true" && '<%=isManager%>' != "true"){
			document.getElementById('manageselect').style.display = "block";
			document.getElementById('workerselect').style.display = "none";
			document.getElementById('workerselect').disabled = "ture";
			document.getElementById('workerstring').disabled = "true";
			}
		else if ('<%=isAdmin%>' != "true" && '<%=isManager%>' == "true"){
			document.getElementById('manageselect').style.display = "none";
			document.getElementById('manageselect').disabled = "ture";
			document.getElementById('workerselect').style.display = "block";
			document.getElementById('managerstring').disabled = "true";
		}
		};
		
	function inifreeuserdata(){
		<%
		String freeuserdata = "";
		for (int i = 0; i < freeusers.size(); i++ ){
			freeuserdata += "<option>" + freeusers.get(i).getAlias() +"</option>";
		}
		%>
		return '<%=freeuserdata%>';
		};
	
	function iniworkerdata(){
		<%
		String workerdata = "";
		for (int i = 0; i < workers.size(); i++ ){
			workerdata += "<option>" + workers.get(i).getAlias() +"</option>";
		}
		%>
		return '<%=workerdata%>';
		};
	function inimanagerdata(){
		<%
		String managerdata = "";
		for (int i = 0; i < managers.size(); i++ ){
			managerdata += "<option>" + managers.get(i).getAlias() +"</option>";
		}
		%>
		return '<%=managerdata%>';
		};
	
$(function(){
	ini();
	$("#freeuser").append(inifreeuserdata());
	$("#manage").append(inimanagerdata());
	$("#worker").append(iniworkerdata());
    //移到右边
    $('#add').click(function() {
    //获取选中的选项，删除并追加给对方
		if (document.getElementById('manageselect').style.display == "block"){
        $('#freeuser option:selected').appendTo('#manage');
		}
		else {
		$('#freeuser option:selected').appendTo('#worker');
			}
    });
    //移到左边
    $('#remove').click(function() {
		if (document.getElementById('manageselect').style.display == "block"){
        $('#manage option:selected').appendTo('#freeuser');
		}
		else {
		$('#worker option:selected').appendTo('#freeuser');
		}
    });
    //全部移到右边
    $('#add_all').click(function() {
        //获取全部的选项,删除并追加给对方
		if (document.getElementById('manageselect').style.display == "block"){
        $('#freeuser option').appendTo('#manage');
		}
		else {
		$('#freeuser option').appendTo('#worker');
		}
    });
    //全部移到左边
    $('#remove_all').click(function() {
		if (document.getElementById('manageselect').style.display == "block"){
        $('#manage option').appendTo('#freeuser');
		}
		else {
		$('#worker option').appendTo('#freeuser');
		}
    });
});
</script>
</head>

<body>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff;"> <br>
    <div class="row">
      <div class="col-md-2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> 平安付科技中心 </div>
      <div class="col-md-7"></div>
      <%if (session.getAttribute("user") == null) {%>
      <div class="col-md-3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </div>
      <%} else { User user = (User) session.getAttribute("user");
                      String name = user.getAlias(); %>
      <div class="col-md-3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </div>
      <%}%>
    </div>
    <div class="row">
      <div class="col-md-12" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
    </div>
    <div class="row">
      <div class="col-md-10"></div>
      <div class="col-md-2" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
    </div>
    <br>
  </div>
  <!--登录-->
  <div id="loginmodal" style="display:none;" align="center">
    <div>
      <p>用户登录</p>
    </div>
    <form id="loginform" name="loginform" method="post" action="">
      <label for="alias" style="Microsoft YaHei; font-size:12px;">Username:</label>
      <input type="text" name="alias" id="alias" tabindex="1">
      <label for="password" style="Microsoft YaHei; font-size:12px;">Password:</label>
      <input type="password" name="password" id="password" tabindex="2">
      <div>
      	<br/>
        <button type="button" class="btn btn-primary btn-sm" onClick="loginac()" id="loginbtn" name="loginbtn" tabindex="3">LogIn</button>
        <button type="button" class="btn btn-primary btn-sm" onClick="window.location.href='findpwd.jsp'" id="findpwdbtn" name="findpwdbtn" tabindex="4">找回密码</button>
      </div>
    </form>
  </div>
  <script type="text/javascript">
			$(function() {
				$('#login').leanModal({
					top : 110,
					overlay : 0.45,
					closeButton : ".hidemodal"
				});
			});
		</script> 
  <!--导航-->
  <nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li><a href="index_1.jsp">主页</a></li>
          <li><a href="casemanagement.jsp">用例管理</a></li>
          <li><a href="#">结果管理</a></li>
          <li><a href="sutindex.jsp">接入申请</a></li>
          <li><a href="rolemanagement.jsp">用户权限</a></li>
          <%if (session.getAttribute("isAdmin") != null){
        String UserIsAdmin = String.valueOf(session.getAttribute("isAdmin"));
        if (UserIsAdmin == "true"){%>
          <li><a href="inimanager.jsp">隐藏用户权限for Admin</a></li>
          <li><a href="inidata.jsp">隐藏创建版本for Admin</a></li>
          <%}}%>
        </ul>
      </div>
      <!-- /.navbar-collapse --> 
    </div>
    <!-- /.container-fluid --> 
  </nav>
  <!--主体-->
  <form id="userroleForm" name="userroleForm" action="">
    <fieldset>
      <legend>用户权限变更</legend>
      <table align="center">
        <tr>
          <td id="freeuserselect"><select multiple="multiple"  id="freeuser" style="height:300px; width:200px">
            </select></td>
          <td><table>
              <tr>
                <td><input class="btn" style="width:60px" id="add" value=">"></td>
              </tr>
              <tr>
                <td><input class="btn " style="width:60px" id="add_all" value=">>"></td>
              </tr>
              <tr>
                <td><input class="btn" style="width:60px" id="remove" value="<"></td>
              </tr>
              <tr>
                <td><input class="btn" style="width:60px" id="remove_all" value="<<"></td>
              </tr>
            </table></td>
          <td id="manageselect"><select multiple="multiple" id="manage" style="height:300px; width:200px">
            </select></td>
          <td id="workerselect"><select multiple="multiple" id="worker" style="height:300px; width:200px">
            </select></td>
          <td ><input style="display:none" id="managerstring" name="managerstring" value="managerstring"></td>
          <td><input style="display:none" id="workerstring" name="workerstring" value="workerstring"></td>
          <td><input style="display:none" id="sut_name" name="sut_name" value="<%=sut_name%>"></td>
        </tr>
        <tr style="text-align:center">
          <td colspan="3"><input type="button" onClick="updateroleac()" value="更新"></td>
        </tr>
      </table>
    </fieldset>
  </form>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>