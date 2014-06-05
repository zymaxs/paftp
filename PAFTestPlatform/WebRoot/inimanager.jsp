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
request.getRequestDispatcher("${pageContext.request.contextPath}/initialAddRelationship.action").forward(request,response);}
String isAdmin = String.valueOf(request.getAttribute("isAdmin"));
if ( isAdmin != "true" ){%>
<Meta http-equiv="refresh" content="0;url='index_1.jsp'; ">
	<%}
List<User> seniormanagers = (List<User>)request.getAttribute("seniormanagers");
List<User> normalusers = (List<User>)request.getAttribute("normalusers");
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
	
	function ininormaluserdata(){
		<%
		String normaluserdata = "";
		for (int i = 0; i < normalusers.size(); i++ ){
			normaluserdata += "<option>" + normalusers.get(i).getAlias() +"</option>";
		}
		%>
		return '<%=normaluserdata%>';
		};
		
	function iniseniormanagerdata(){
		<%
		String seniormanagerdata = "";
		for (int i = 0; i < seniormanagers.size(); i++ ){
			seniormanagerdata += "<option>" + seniormanagers.get(i).getAlias() +"</option>";
		}
		%>
		return '<%=seniormanagerdata%>';
		};
		
	function finseniormanager(){
		var finalseniormanager = "";
		for (i = 0; i < document.getElementById('seniormanager').length ; i++ ){
			finalseniormanager += document.getElementById('seniormanager').options[i].value + ";";
			}
		return finalseniormanager;
	};
	
		
	function updateroleac(){
		document.getElementById('seniormanager').value = finseniormanager();
		document.userroleForm.action = "${pageContext.request.contextPath}/addRelationship.action";
		document.userroleForm.submit();
		};
	
	$(function(){
	$("#normaluser").append(ininormaluserdata());
	$("#seniormanager").append(iniseniormanagerdata());
    //移到右边
    $('#add').click(function() {
    //获取选中的选项，删除并追加给对方
        $('#normaluser option:selected').appendTo('#seniormanager');
    });
    //移到左边
    $('#remove').click(function() {
        $('#seniormanager option:selected').appendTo('#normaluser');
    });
    //全部移到右边
    $('#add_all').click(function() {
        //获取全部的选项,删除并追加给对方
        $('#normaluser option').appendTo('#seniormanager');
    });
    //全部移到左边
    $('#remove_all').click(function() {
        $('#manage option').appendTo('#freeuser');
    });
});

</script>
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
          <%if (session.getAttribute("user") == null) {%>
          <div class="span3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </div>
          <%} else { User user = (User) session.getAttribute("user");
					String name = user.getAlias(); %>
          <div class="span3 whitelink" style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </div>
          <%}%>
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
        <button type="button" class="btn btn-primary" onClick="loginac()" id="loginbtn" name="loginbtn" tabindex="3">LogIn</button>
        <button type="button" class="btn btn-primary" onClick="window.location.href='findpwd.jsp'" id="findpwdbtn" name="findpwdbtn" tabindex="4">找回密码</button>
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
  <div class="row-fluid">
    <div class="span12">
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container-fluid">
            <div class="nav-collapse collapse navbar-responsive-collapse">
              <ul class="nav">
                <li class="active"><a href="index_1.jsp">主页</a></li>
                <li><a href="sutindex.jsp">SUT申请</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <form id="userroleForm" name="userroleForm" action="">
    <fieldset>
      <legend>用户权限变更</legend>
      <table align="center">
        <tr>
          <td id="freeuserselect"><select multiple="multiple" id="normaluser" style="height:300px;">
            </select></td>
          <td><table>
              <tr>
                <td><input class="btn input-mini" id="add" value=">"></td>
              </tr>
              <tr>
                <td><input class="btn input-mini" id="add_all" value=">>"></td>
              </tr>
              <tr>
                <td><input class="btn input-mini" id="remove" value="<"></td>
              </tr>
              <tr>
                <td><input class="btn input-mini" id="remove_all" value="<<"></td>
              </tr>
            </table></td>
          <td id="manageselect"><select multiple="multiple" id="seniormanager" style="height:300px;">
            </select></td>
          <td ><input style="display:none" id="seniormanagerstring" name="seniormanagerstring" value="seniormanagerstring"></td>
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