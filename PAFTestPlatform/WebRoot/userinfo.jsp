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
<%  
User user = (User)request.getAttribute("user");
UserInfo userinfo = (UserInfo) user.getUserInfo();
Integer id = 0;
String name = "";
String displayname = "";
String department = "";
String position = "";
String mobile = "";
String telephone = "";
String othermail = "";

if(user.getId() != null){
	id = user.getId();
}

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

if (userinfo.getTelephone() != null) {
	telephone = userinfo.getTelephone();
}

if (userinfo.getOthermail() != null) {
	othermail = userinfo.getOthermail();
}
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
							style="text-align:center;font-size:15px; font-family:Microsoft YaHei;"> <a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </div>
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
     <fieldset>
        <legend> 用户信息 </legend>
        <table>
          <tr>
            <td>* 真实姓名：</td>
            <td><%=displayname%></td>
          </tr>
          <tr>
            <td>* 所属部门 :</td>
            <td><%=department%></td>
            <td>* 当前职位 :</td>
            <td><%=position%></td>
          </tr>
          <tr>
            <td style="text-align:right">移动电话 :</td>
            <td style="text-align:right"><%=mobile%></td>
            <td style="text-align:right">座式电话 :</td>
            <td style="text-align:right"><%=telephone%></td>
          </tr>
          <tr>
          	<td>其他邮件 :</td>
            <td><%=othermail%></td>
            </tr>
        </table>
        </fieldset>
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