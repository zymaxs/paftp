<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>??</title>
<script type="text/javascript" src="include/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
   $(function() {
     $("#tj").click(function() {
    //?????,name?inch??struts action????????
        var params = {
           name : $("#xm").val(),
           inch : $("#sg").val()
        };
        $.ajax({
    type: "POST",
    url: "jsonAjax.action",
    data: params,
    dataType:"text", //ajax??????text(json????????,??????,?????json)
    success: function(json){  
    var obj = $.parseJSON(json);  //????????json
                var state_value = obj.result;  //result??action????result???get?????
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
<span>??:</span>
<input id="xm" type="text">
<br/>
<span>??:</span>
<input id="sg" type="text">
<br/>
<input type="button" value="??" id="tj">
</body>
</html>
