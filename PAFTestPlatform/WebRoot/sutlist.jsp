<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/easyui/themes/default/easyui.css" rel="stylesheet">
<link href="css/easyui/themes/icon.css" rel="stylesheet">
<link href="css/easyui/demo.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
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
	}
	function submitForm(){
            $('#queryForm').form('submit');
        }
</script>
<!--分页-->
<script>

var myPagination;

$(function() {

	initEvent();
	
  });

	
	function initEvent(){
		$("#sysname").focus();
		$("#query").click(function(){
			var formData = $("#queryForm").serialize(); //序列化表单
            formData = decodeURIComponent(formData, true);	//解码
			$.fn.debug("开始指定加载");
			myPagination.onLoad({param:formData});
			$.fn.debug("结束指定加载");
		});
	}
	
function createTR(obj){
	var tr = "<tr>";
	tr += "<td>"+obj.name+"</td>";
	tr += "<td><a href='"+obj.blogs+"'>"+obj.blogs+"</a></td>";
	tr += "<td>"+obj.email+"</td>";
	tr += "<td><a href='"+obj.download+"'>"+obj.download+"</a></td>";
	tr += "<td>"+obj.qq+"</td>";
	tr += "</tr>";
	return tr;
}

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
  <div id="loginmodal" style="display:none;">
    <div align="center">
      <p>用户登录</p>
    </div>
    <form id="loginform" name="loginform" method="post" action="">
      <label for="alias" style="Microsoft YaHei; font-size:12px;">Username:</label>
      <input type="text" name="alias" id="alias" class="txtfield"
					tabindex="1">
      <label for="password"
					style="Microsoft YaHei; font-size:12px;">Password:</label>
      <input
					type="password" name="password" id="password" class="txtfield"
					tabindex="2">
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
                <li><a href="sutlist.jsp">SUT申请</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <form id="queryForm" name="queryForm" action="">
    <table width="900px">
      <tr>
        <td>系统名</td>
        <td><input type="text" id="sysname" name="sysname"></td>
        <td>申请人</td>
        <td><input type="text" id="applicant" name="applicant"></td>
      </tr>
      <tr>
        <td>Start Date:</td>
        <td><input class="easyui-datebox" data-options="sharedCalendar:'#timebox'"></td>
        <td>End Date:</td>
        <td><input class="easyui-datebox" data-options="sharedCalendar:'#timebox'"></td>
      </tr>
      <tr>
        <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">搜索</a></td>
      </tr>
    </table>
    <div id="timebox" class="easyui-calendar"></div>
  </form>
  <button type="button" class="btn btn-primary" onClick="window.location.href='applysut.jsp'">申请接入</button>
  <table id="sutlist" class="t1">
    <thead>
    <th>申请序号</th>
      <th>系列名</th>
      <th>申请人</th>
      <th>申请日期</th>
      <th>状态</th>
        </thead>
    <tbody>
    </tbody>
  </table>
  <div id="demo1"></div>
  
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>