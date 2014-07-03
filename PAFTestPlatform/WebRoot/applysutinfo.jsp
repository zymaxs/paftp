<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/showsutgroup.action").forward(request,response);}
List<String> sutgroup = (List<String>)request.getAttribute("sutgroupnames");
String isLogin = "test";
String isAdmin = "test";
String alias = "";
if (session.getAttribute("user") != null){
	 isLogin = "y";
	 User userinfo = (User) session.getAttribute("user");
	 alias = userinfo.getAlias();
} else { isLogin = "n";};


if ((String)request.getAttribute("isAdmin") != null){
	isAdmin = "y";
	}else { isAdmin = "n";};
	
	
ApplySut applySut = (ApplySut)request.getAttribute("applySut");
String applyer = applySut.getUser().getAlias();
int id = applySut.getId();
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
//todo
var alias = '<%=alias%>';
var isLogin = '<%=isLogin%>';
var isAdmin = '<%=isAdmin%>';
var applyer = '<%=applyer%>';
	function inipermission() {
		if (alias == null) {
			alert("inside if");
			document.getElementById('approvebtn').style.display = "none";
			document.getElementById('rejectbtn').style.display = "none";
			document.getElementById('updatebtnTd').style.display = "none";
		} else {
			if (isAdmin == "y") {
				document.getElementById('approvebtn').style.display = "block";
				document.getElementById('rejectbtn').style.display = "block";
				document.getElementById('updatebtnTd').style.display = "block";
			} else {
				if (alias == applyer) {
					document.getElementById('approvebtn').style.display = "none";
					document.getElementById('rejectbtn').style.display = "none";
					document.getElementById('updatebtnTd').style.display = "block";
				} else if (alias != applyer) {
					document.getElementById('approvebtn').style.display = "none";
					document.getElementById('rejectbtn').style.display = "none";
					document.getElementById('updatebtnTd').style.display = "none";
				}

			}
		}
	}
</script>
<script type="text/javascript">
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}
	function approveac() {
		document.sutinfoform.action = "${pageContext.request.contextPath}/approveSut.action?status=Pass";
		document.sutinfoform.submit();
	}
	function rejectac() {
		document.sutinfoform.action = "${pageContext.request.contextPath}/approveSut.action?status=Reject";
		document.sutinfoform.submit();
	}
	function updateac() {
		document.getElementById('sutname').readOnly = false;
		document.getElementById('groupname').readOnly = false;
		document.getElementById('code').readOnly = false;
		document.getElementById('description').readOnly = false;
		document.getElementById('updatebtnTd').style.display = "none";
		document.getElementById('grouplist').style.display = "block";
		document.getElementById('savebtnTd').style.display = "block";

	}
	function saveac() {
		if($("#sutinfoform").valid()){
			document.sutinfoform.action = "${pageContext.request.contextPath}/updateSut.action";
			document.sutinfoform.submit();
			}
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sutgroup").jQSelect({});
		inipermission();
		$("#sutinfoform").validate({
        rules: {
            "sutname":{
                required: true,
				maxlength: 20
            },
			 "code":{
                required: true,
				maxlength: 30
            },
			"description":{
                required: true,
				maxlength: 60
            }
        },
        messages: {
            "sutname":{
                required: "请输入系统名",
				maxlength: $.validator.format("系统名最大不超过20个字符")
            },
			"code":{
                required: "请输入系统中文名",
				maxlength: $.validator.format("系统中文名最大不超过30个字符")
            },
			"description":{
                required: "请输入系统描述",
				maxlength: $.validator.format("系统描述最大不超过60个字符")
            }
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
  <form id="sutinfoform" name="sutinfoform" class="form-horizontal"
			method="post" action="">
    <fieldset>
      <legend> 接入系统申请详情页 <small>(带*号标志为必输项)</small> </legend>
      <table>
        <tr>
          <td style="text-align:right">* 系统名 :&nbsp;&nbsp;</td>
          <td><input type="text" class="form-control input-sm" style="width:200px" id="sutname"
							name="sutname" value="<%=applySut.getName()%>" readonly></td>
        </tr>
        <tr>
         <td>&nbsp;</td>
        </tr>
        <tr>
          <td style="text-align:right">申请状态 :&nbsp;&nbsp;</td>
          <td><input type="text"  class="form-control input-sm" style="width:200px" id="sutstatus"
							name="sutstatus"
							value="<%=applySut.getApplysutstatus().getDescription()%>" disabled></td>
        </tr>
        <tr>
         <td>&nbsp;</td>
        </tr>
        <tr>
          <td style="text-align:right">* 系统所属平台 :&nbsp;&nbsp;</td>
          <td><div id="sutgroup" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=applySut.getGroup().getName()%>"
										id="groupname" name="groupname" class="listTxt" readonly />
                <div class="listBtn"> <b></b> </div>
                <input type="hidden" value="<%=sutgroup.get(0)%>"
										class="listVal" />
              </div>
              <div class="lists">
                <ul class="list" id="grouplist" style="display:none">
                  <%
											for (int i = 0; i < sutgroup.size(); i++) {
										%>
                  <li id=<%=i%>><%=sutgroup.get(i)%></li>
                  <%
											}
										%>
                </ul>
              </div>
            </div></td>
        </tr>
        <tr>
         <td>&nbsp;</td>
        </tr>
        <tr>
          <td style="text-align:right">* 系统中文名 :&nbsp;&nbsp;</td>
          <td><input type="text"  class="form-control input-sm" style="width:200px" id="code"
							name="code" value="<%=applySut.getCode()%>" readonly></td>
        </tr>
        <tr>
         <td>&nbsp;</td>
        </tr>
        <tr>
          <td style="text-align:right">* 系统描述 :&nbsp;&nbsp;</td>
          <td><textarea rows="4"  class="form-control" style="width:200px" id="description"
								name="description" readonly><%=applySut.getDescription()%></textarea></td>
        </tr>
        <tr>
        <td colspan="2"><input type="text" id="id" name="id" value="<%=id %>" style="display:none"></td>
        </tr>
        <tr>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="2">
          <table>
            <tr>
              <td width="100px"><input type="button" id="approvebtn" name="approvebtn"
							class="btn btn-primary btn-sm" style="width:80px; text-align:center"		value="通过" onClick="approveac()"></td>
              <td width="100px"><input type="button" id="rejectbtn" name="rejectbtn"
							class="btn btn-primary btn-sm" style="width:80px; text-align:center"		value="拒绝" onClick="rejectac()"></td>
              <td width="100px" id="updatebtnTd" style="display:block"><input type="button" id="updatebtn" name="uptadebtn"
							class="btn btn-primary btn-sm" style="width:80px; text-align:center;"		value="修改" onClick="updateac()"></td>
              <td width="100px" id="savebtnTd" style="display:none"><input type="button" id="savebtn" name="savebtn"
							class="btn btn-primary btn-sm" style="width:80px; text-align:center;"		value="更新" onClick="saveac()"></td>
            </tr>
            <tr>
        		<td colspan="2">&nbsp;</td>
        	</tr>
          </table>
        </td>
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