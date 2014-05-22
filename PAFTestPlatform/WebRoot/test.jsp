<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript">
$().ready(function() {

 $("#signupForm").validate({

        rules: {

   firstname: "required",

   email: {

    required: true,

    email: true

   },

   password: {

    required: true,

    minlength: 5

   },

   confirm_password: {

    required: true,

    minlength: 5,

    equalTo: "#password"

   }

  },

        messages: {

   firstname: "请输入姓名",

   email: {

    required: "请输入Email地址",

    email: "请输入正确的email地址"

   },

   password: {

    required: "请输入密码",

    minlength: jQuery.format("密码不能小于{0}个字 符")

   },

   confirm_password: {

    required: "请输入确认密码",

    minlength: "确认密码不能小于5个字符",

    equalTo: "两次输入密码不一致不一致"

   }

  }

    });

});
</script>
</head>

<body>
<form id="signupForm" method="get" action="">
  <p>
    <label for="firstname">Firstname</label>
    <input id="firstname" name="firstname" />
  </p>
  <p>
    <label for="email">E-Mail</label>
    <input id="email" name="email" />
  </p>
  <p>
    <label for="password">Password</label>
    <input id="password" name="password" type="password" />
  </p>
  <p>
    <label for="confirm_password">确认密码</label>
    <input id="confirm_password" name="confirm_password" type="password" />
  </p>
  <p>
    <input class="submit" type="submit" value="Submit"/>
  </p>
</form>
</body>
</html>