<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
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
                required: true,
            },
			 "displayname":{
                required: true,
				rangelength: [4, 30]
            },
			"department":{
                required: true,
				rangelength: [4, 30]
            },
			"position":{
                required: true
            },
            "othermail":{
                email:true
            }
        },
        messages: {
            "alias":{
                required: "请输入用户名"
            },
			"displayname":{
                required: "请输入真实姓名"
            },
			"department":{
                required: "请输入所属部门"
            },
            "email":{
                email:"请输入正确的email地址"
            }
        }
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
          <div class="span2" style="text-align:left;font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</div>
          <div class="span7"></div>
          <div class="span3"></div>
        </div>
        <div class="row-fluid">
          <div class="span2"></div>
          <div class="span8" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</div>
          <div class="span2 whitelink"><a href="register.jsp">注册</a> | 登录</div>
        </div>
        <div class="row-fluid">
          <div class="span10"> </div>
          <div class="span2" style="text-align:right;font-family:Microsoft YaHei;">Version : beta 0.3.0</div>
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
    <form id="signupForm" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/register.action">
      <fieldset>
        <legend>用户注册 <small>(带*号标志为必输项)</small></legend>
        <div class="control-group">
          <label class="control-label" for="alias"><em>*</em> 用户名 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="alias" name="alias">
            <p class="help-block">请使用各自Alias进行注册，注册完成后将发送密码至平安邮箱。并请各自首次登录完成密码修改。</p>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="displayname">真实姓名 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="displayname" name="displayname">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="department">所属部门 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="department" name="department">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="position">职位 :</label>
          <div class="controls">
            <select id="position" class="input-xlarge" name="position">
              <option>测试</option>
              <option>开发</option>
              <option>产品</option>
              <option>其他</option>
            </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="telephone">联系电话 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="telephone" name="telephone">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="mobile">移动电话 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="mobile" name="mobile">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="othermail">其他邮件 :</label>
          <div class="controls">
            <input type="text" class="input-xlarge" id="othermail" name="othermail">
          </div>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Submit</button>
        </div>
      </fieldset>
    </form>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p><small><b>自动化测试</b>：WebService | App | Web | Stress | Solution<br/>
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small></p>
  </div>
</div>
</body>
</html>