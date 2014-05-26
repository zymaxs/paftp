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
<%=departments.get(0)%>
<%=departments.get(1)%>
<%=departments.size()%>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff; margin:auto">
    <div class="row-fluid">
      <div class="span12">
        <div class="row-fluid">
          <div class="span2" style="text-align:left;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
          <div class="span7"></div>
          <div class="span3"></div>
        </div>
        <div class="row-fluid">
          <div class="span2"></div>
          <div class="span8" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
          <div class="span2 whitelink"><a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a></div>
        </div>
        <div class="row-fluid">
          <div class="span10"> </div>
          <div class="span2" style="text-align:right;font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
        </div>
      </div>
    </div>
  </div>
  <!--登录-->
  <div id="loginmodal" style="display:none;">
    <h1>User Login</h1>
    <form id="loginform" name="loginform" method="post" action="${pageContext.request.contextPath}/login.action">
      <label for="username">Username:</label>
      <input type="text" name="username" id="username" class="txtfield" tabindex="1">
      <label for="password">Password:</label>
      <input type="password" name="password" id="password" class="txtfield" tabindex="2">
      <div class="center">
        <input type="button" name="loginbtn" id="loginbtn"
						class="flatbtn-blu hidemodal" value="Login" tabindex="3"
						onClick="loginac()">
        <input type="button"
						name="findpwdbtn" id="findpwdbtn" class="flatbtn-blu hidemodal"
						value="找回密码" onClick="window.location.href='findpwd.jsp'"
						tabindex="4">
      </div>
    </form>
  </div>
  <script type="text/javascript">
	$(function(){
	$('#login').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
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
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <form id="signupForm" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/register.action">
  <fieldset>
  <legend> 用户注册 <small>(带*号标志为必输项)</small></legend>
  <table border="0">
  	<tr>
  		<td style="text-align:right"><label class="control-label" for="alias">* 用户名 :</label></td>
        <td style="text-align:left"><input type="text" class="input-xlarge" id="alias" name="alias"></td>
        <td colspan="2" style="text-align:left">@pingan.com.cn</td>
  	</tr>
    <tr>
    	<td></td>
    	<td colspan="3" style="text-align:left"><p class="help-block">请使用自己的域账号进行注册，初始密码将发送至你的平安邮箱。请在首次登录时完成密码修改。</p></td>
    </tr>
    <tr>
    	<td style="text-align:right"><label for="displayname">* 真实姓名 :</label></td>
        <td colspan="3" style="text-align:left"><input type="text" class="input-xlarge" id="displayname" name="displayname"></td>
    </tr>
    <tr>
    	<td style="text-align:right"><label  for="department">* 所属部门 :</label></td>
        <td style="text-align:center;"><div id="selectDepartment" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=departments.get(0)%>" id="department" name="department" class="listTxt" />
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
            </div></td>
    	<td style="text-align:right"><label class="control-label" for="position">* 职位 :</label></td>
        <td style="text-align:left"><div id="selectPosition" class="selectbox">
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
            </div></td>
    </tr>
    <tr>
    	<td style="text-align:right"><label for="telephone">联系电话 :</label></td>
        <td style="text-align:left"><input type="text" class="input-xlarge" id="telephone" name="telephone"></td>
        <td style="text-align:right"><label for="mobile">移动电话 :</label></td>
        <td style="text-align:left"><input type="text" class="input-xlarge" id="mobile" name="mobile"></td>
    </tr>
    <tr>
    	<td style="text-align:right"><label for="othermail">其他邮件 :</label></td>
        <td colspan="3" style="text-align:left"><input type="text" class="input-xlarge" id="othermail" name="othermail"></td>
    </tr>
    <tr>
    	<td colspan="4" style="text-align:center"><button type="submit" class="btn btn-primary">保存</button></td>
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