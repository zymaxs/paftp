<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.paftp.entity.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/reguserinfo.action").forward(request,response);}
List<String> departments = (List<String>)request.getAttribute("departments");
List<String> positions = (List<String>)request.getAttribute("positions");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/shou.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="js/jQSelect.js"></script>
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
$(document).ready(function(){
    $("#signupForm").validate({
        rules: {
            "alias":{
                required: true
            },
			 "displayname":{
                required: true,
				maxlength: 10
            },
			"department":{
                required: true,
            },
			"position":{
                required: true
            },
            "othermail":{
                email:true
            },
            "telephone":{
                digits:true
            },
            "mobile":{
                digits:true
            }
        },
        messages: {
            "alias":{
                required: "请输入用户名"
            },
			"displayname":{
                required: "请输入真实姓名",
				maxlength: $.validator.format("真实姓名最大输入不超过十个字符.")
            },
            "othermail":{
                email:"请输入正确的email地址"
            },
            "telephone":{
                digits: "请输入数字"
            },
            "moible":{
                digits: "请输入数字"
            }
        }
    });
});
</script>
<script type="text/javascript">
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("#selectPosition").jQSelect({});
	$("#selectDepartment").jQSelect({});
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
      	<br>
        <button type="button" class="btn btn-primary btn-sm" onClick="loginac()" id="loginbtn" name="loginbtn" tabindex="3">LogIn</button>
        <button type="button" class="btn btn-primary btn-sm" onClick="window.location.href='findpwd.jsp'" id="findpwdbtn" name="findpwdbtn" tabindex="4">找回密码</button>
      </div>
    </form>
  </div>
  <script type="text/javascript">
	$(function(){
	$('#login').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
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
        String isAdmin = String.valueOf(session.getAttribute("isAdmin"));
        if (isAdmin == "true"){%>
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
  <form id="signupForm" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/register.action">
    <fieldset>
      <legend> 用户注册 <small>(带*号标志为必输项)</small></legend>
      <table border="0">
        <tr>
          <td style="text-align:right"><label class="control-label" for="alias">* 用户名 :&nbsp;&nbsp;</label></td>
          <td colspan="3" style="text-align:left"><input type="text" id="alias" name="alias">@pingan.com.cn</td>
        </tr>
        <tr>
          <td></td>
          <td colspan="3" style="text-align:left"><p class="help-block">请使用自己的域账号进行注册，初始密码将发送至你的平安邮箱。请在首次登录时完成密码修改。</p></td>
        </tr>
        <tr>
          <td style="text-align:right"><label for="displayname">* 真实姓名 :&nbsp;&nbsp;</label></td>
          <td colspan="3" style="text-align:left"><input type="text" id="displayname" name="displayname"></td>
        </tr>
        <tr>
          <td style="text-align:right"><label  for="department">* 所属部门 :&nbsp;&nbsp;</label></td>
          <td style="text-align:left;">
          <div id="selectDepartment" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=departments.get(0)%>" id="department" name="department" class="listTxt" style="vertical-align:middle" />
                <div class="listBtn"><b></b></div>
                <input type="hidden" value="" class="listVal" />
              </div>
              <div class="lists">
                <ul class="list">
                  <% for (int i =0; i<departments.size(); i++){%>
                  <li id=<%=i%>><%=departments.get(i)%></li>
                  <%}%>
                </ul>
              </div>
            </div>
            </td>
          <td style="text-align:right"><label class="control-label" for="position">* 职位 :&nbsp;&nbsp;</label></td>
          <td style="text-align:left">
          <div id="selectPosition" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=positions.get(0)%>" id="position" name="position" class="listTxt" />
                <div class="listBtn"><b></b></div>
                <input type="hidden" value="" class="listVal" />
              </div>
              <div class="lists">
                <ul class="list">
                  <% for (int i =0; i<positions.size(); i++){%>
                  <li id=<%=i%>><%=positions.get(i)%></li>
                  <%}%>
                </ul>
              </div>
            </div>
            </td>
        </tr>
        <tr>
          <td style="text-align:right"><label for="telephone">联系电话 :&nbsp;&nbsp;</label></td>
          <td style="text-align:left"><input type="text" id="telephone" name="telephone"></td>
          <td style="text-align:right"><label for="mobile">移动电话 :&nbsp;&nbsp;</label></td>
          <td style="text-align:left"><input type="text" class="input-xlarge" id="mobile" name="mobile"></td>
        </tr>
        <tr>
          <td style="text-align:right"><label for="othermail">其他邮件 :&nbsp;&nbsp;</label></td>
          <td colspan="3" style="text-align:left"><input type="text" class="input-xlarge" id="othermail" name="othermail"></td>
        </tr>
        <tr>
          <td colspan="4" style="text-align:center"><button type="submit" class="btn btn-primary btn-sm">保存</button></td>
        </tr>
      </table>
    </fieldset>
  </form>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p><small><b>自动化测试</b>：WebService | App | Web | Stress | Solution<br/>
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small></p>
  </div>
</div>
</body>
</html>