<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>测试</title>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
   $(function() {
     $("#tj").click(function() {
        var params = {
           name : $("#name").val()
        };
        $.ajax({
    type: "POST",
    url: "${pageContext.request.contextPath}/initialSutsAjax.action",
    data: params,
    dataType:"text",
    success: function(json){  
    var obj = $.parseJSON(json); 
                var state_value = obj.result;
    alert(state_value);
    },
    error: function(json){
     alert("json=" + json);
     return false;
    }
    });
     });
   });
</script>
</head>
<body>
<span>姓名：</span>
<input id="name" name="name" type="text">
<br/>
<br/>
<input type="button" value="提交" id="tj">
</body>
</html>
