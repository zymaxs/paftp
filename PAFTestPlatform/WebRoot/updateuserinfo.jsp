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
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/upuserinfo.action").forward(request,response);}
List<String> departments = (List<String>)request.getAttribute("departments");
List<String> positions = (List<String>)request.getAttribute("positions");
%>
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
	$(document).ready(function() {
		$("#updateinfoForm").validate({
			rules : {
				"displayname" : {
					required : true,
					maxlength : 10
				},
				"department" : {
					required : true
				},
				"position" : {
					required : true
				},
				"othermail" : {
					email : true
				},
            	"telephone":{
                	digits:true
           		},
            	"mobile":{
                	digits:true
            	},
            	"otherinfo":{
                	maxlength: 60
            	}
			},
			messages : {
				"displayname" : {
					required : "请输入真实姓名",
					maxlength : $.validator.format("真实姓名最大输入不超过十个字符.")
				},
				"othermail" : {
					email : "请输入正确的email地址"
				},
            	"telephone":{
                	digits: "请输入数字"
            	},
            	"moible":{
                	digits: "请输入数字"
            	},
            	"otherinfo":{
                	maxlength: $.validator.format("用户备注最大输入不超过六十个字符.")
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
	UserInfo userinfo = (UserInfo) user.getUserInfo();
	String name = "";
	String displayname = "";
	String department = "";
	String position = "";
	String mobile = "";
	String telephone = "";
	String othermail = "";
	String otherinfo ="";

	if (user.getAlias() != null) {
		name = user.getAlias();
	}

	if (user.getDisplayName() != null) {
		displayname = user.getDisplayName();
	}

	if (userinfo.getDepartment().getName() != null) {
		department = userinfo.getDepartment().getName();
	}

	if (userinfo.getPosition().getName() != null) {
		position = userinfo.getPosition().getName();
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
	if (userinfo.getOtherinfo() != null) {
		othermail = userinfo.getOtherinfo();
	}
	;
%>
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
      <%} else {  %>
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
  <div>
    <form id="updateinfoForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/updateuserinfo.action">
      <fieldset>
        <legend> 用户信息更新 <small>(带*号标志为必输项)</small> </legend>
        <table style="width:40%" align="left" class="table table-striped">
          <tr>
            <td>* 真实姓名 :</td>
            <td><input type="text" id="displayname"
								name="displayname" value="<%=displayname%>" style="width:200px;"></td>
          </tr>
          <tr>
            <td>* 所属部门 :</td>
            <td><div id="selectDepartment" class="selectbox">
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
            </tr>
            <tr>
            <td>* 所属部门 :</td>
            <td><div id="selectPosition" class="selectbox">
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
            <td>联系电话 :</td>
            <td><input type="text" id="telephone" name="telephone"
								value="<%=telephone%>" style="width:200px;"></td>
          </tr>
          <tr>
            <td>移动电话 :</td>
            <td><input type="text" id="mobile"
								name="mobile" value="<%=mobile%>" style="width:200px;"></td>
          </tr>
          <tr>
          	<td>其他邮件 :</td>
            <td><input type="text" id="othermail"
								name="othermail" value="<%=othermail%>" style="width:200px;"></td>
          </tr>
          <tr>
          <td>用户备注 :</td>
          <td><textarea  id="otherinfo" name="otherinfo" style="height:100px; max-height:100px; width:300px; max-width:300px" ><%=otherinfo%></textarea></td>
        </tr>
          <tr align="center">
          	<td colspan="2"><button type="submit" class="btn btn-primary" style="width:80px; text-align:center">提交</button></td>
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
        <table  style="width:40%" align="left" class="table table-striped">
        <tr>
        	<td>* 旧密码 :</td>
            <td><input type="password" id="orignpassword"
								name="orignpassword" style="width:200px;"></td>
        </tr>
        <tr>
        	<td>* 新密码 :</td>
            <td><input type="password" id="password"
								name="password" style="width:200px;"></td>
        </tr>
        <tr>
        	<td>* 确认密码 :</td>
            <td><input type="password" id="confirm_password"
								name="confirm_password" style="width:200px;"></td>
        </tr>
        <tr align="center">
        	<td colspan="2"><button type="submit" class="btn btn-primary" style="width:80px; text-align:center">提交</button></td>
        </tr>
        </table>
      </fieldset>
    </form>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>