<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/applysutgroup.action").forward(request,response);}
List<String> sutgroup = (List<String>)request.getAttribute("sutgroupnames");
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
$(document).ready(function(){
    $("#applysutform").validate({
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
<script type="text/javascript">
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}
	function applysutac() {
		if ('<%=session.getAttribute("user")%>' != "null"){
			document.applysutform.action = "${pageContext.request.contextPath}/applySut.action";
			if($("#applysutform").valid()){
    		 $("#applysutform").submit();
 			}
		}
		else{
		alert("请登录后再提交表单!");
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("#sutgroup").jQSelect({});
});	
</script>
<style>
/*导航默认样式，可根据实际情况修改*/
* {
	margin:0;
	padding:0
}
.daohang {
	width:100%;
	height:30px;
	list-style:none;
	position:relative;
}
.daohang li {
	display:inline-block;
	margin:0;
	position:relative;
	overflow:hidden;
	height:30px; /*建议此高度大于等于里面的a标签高度*/
	float:left;
}
.daohang li span {
	display:inline-block;
	overflow:hidden
}
.daohang li a {
	text-decoration:none;
	outline:none;
	color:#428bca;
	display:inline-block;
	padding:0 10px;
	text-align:center;
	background-color: #FFFFFF;
	font-weight:bold;
	height:30px;
	line-height:30px;
}
/*鼠标经过时样式*/
.daohang li a.over {
	background-color:#428bca;
	color:#FFF
}
</style>
<script type="text/javascript">
(function($){
		  $.fn.dynamicdaohang=function(options){
			  
			   //默认配置
				 var defaults = {
					 direction:"up", //动画切换方向，总共4种up 、down 、left 、right
					 duration:100  //三种预定速度之一的字符串("slow", "normal", or "fast")或表示动画时长的毫秒数值(如：1000)
					 };   
					 
                // 覆盖默认配置
				var opts = $.extend(defaults, options);
			    
				this.each(function(){
					var daohangList=$(this).find("li"),
						daohangLink=daohangList.find("a");
								
						//在a标签外侧插入span
						daohangList.wrapInner("<span></span>");
								 
						var span=daohangLink.parent();
								 
						//判断是否垂直切换
						if(opts.direction=="up" || opts.direction=="down"){
							var v=true;
									 }
									 
						//判断是否改变span初始位置及a样式	 
						if(opts.direction=="right" || opts.direction=="down"){
							var restSpan=true;
								 }
								 
 						daohangLink.each(function(){
													   
							//获取a高度和宽度
							var w=$(this).outerWidth(),
								p=$(this).parent();
														   
							//初始复制现有a标签   
							$(this).clone().appendTo(p).addClass("over");
 													
								//如果是垂直切换
								if(v){	   
 									p.css("width",w);				      
								      }else{
										p.css("width",2*w).parent().css("width",w);	
										}
														 
  								});
								 
						//如果向右或向下切换，改变span初始位置及a样式
						if(restSpan){
						span.each(function(){
													
 								if(opts.direction=="right"){
									$(this).css({"margin-left":-$(this).outerWidth()/2});
									}
														
								if(opts.direction=="down"){
									$(this).css({"margin-top" : -$(this).outerHeight()/2});
									}
 													
								$(this)
								.find('a')
								.last()
								.removeClass("over")
								.prev()
								.addClass("over");
							});
								 }
								
						//鼠标经过时动画函数
						function over(o){
  							o.animate(v?{"margin-top": -o.outerHeight()/2}:{"margin-left": -o.outerWidth()/2}, opts.duration);
 									}
								
						//鼠标移开时动画函数
						function out(o){
							o.animate(v?{"margin-top":0}:{"margin-left": 0}, opts.duration);
									}
								
						//鼠标经过和离开	
						span.hover(function(){
										restSpan ? out($(this)) : over($(this));
											},function(){
												restSpan ? over($(this)) : out($(this));
											});
 							 
				 });
		 };
			  
 })(jQuery);
    $(function(){
		    //向上
		   $("#navigator").dynamicdaohang({
								direction:"up", 
								duration:400 
								});
		   });
</script>
</head>

<body>
<div class="container-fluid"> 
  <!--网页头部-->
  <div style="background:#428bca; color:#ffffff;"> <br>
  <table width="100%">
  <tr>
  	<td>&nbsp;&nbsp;</td>
  	<td style="font-size:15px; font-family:Microsoft YaHei;">平安付科技中心</td>
    <td colspan="7">&nbsp;</td>
    <%if (session.getAttribute("user") == null) {%>
    <td colspan="2" class="whitelink" style=";font-size:15px; font-family:Microsoft YaHei; text-align:right"><a href="register.jsp">注册</a> | <a href="#loginmodal" id="login">登录</a> </td>
    <%} else { User user = (User) session.getAttribute("user");
                      String name = user.getAlias(); %>
    <td colspan="2" class="whitelink" style=";font-size:15px; font-family:Microsoft YaHei; text-align:right"><a href="updateuserinfo.jsp"><%=name%> </a>| <a href="logout.jsp">登出</a> </td>
    <%}%>
    <td>&nbsp;&nbsp;</td>
  </tr>
  <tr>
  	<td colspan="12" style="text-align:center; font-size:35px; font-family:Microsoft YaHei;">移动研发自动化测试平台</td>
  </tr>
  <tr>
  	<td colspan="10">&nbsp;</td>
    <td style="text-align:right;font-size:15px; font-family:Microsoft YaHei;">Version : beta 0.3.0</td>
    <td>&nbsp;&nbsp;</td>
  </tr>
  </table>
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
  <ul class="daohang" id="navigator">
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
  <!--主体-->
  <div >
    <form id="applysutform" name="applysutform" class="form-horizontal" method="post" action="">
      <fieldset>
        <legend>接入系统申请 <small>(带*号标志为必输项)</small></legend>
        <table>
          <tr>
            <td style="text-align:right">* 系统名 :&nbsp;&nbsp;</td>
            <td><input type="text" class="input-xlarge" id="sutname" onKeyUp="quanjiao(this);" name="sutname"></td>
          </tr>
          <tr>
          <td>&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align:right">* 系统所属平台 :&nbsp;&nbsp;</td>
            <td><div id="sutgroup" class="selectbox">
                <div class="cartes">
                  <input type="text" value="<%=sutgroup.get(0)%>" id="groupname" name="groupname" class="listTxt" readonly />
                  <div class="listBtn"><b></b></div>
                  <input type="hidden" value="" class="listVal" />
                </div>
                <div class="lists">
                  <ul class="list">
                    <% for (int i =0; i<sutgroup.size(); i++){%>
                    <li id=<%=i%>><%=sutgroup.get(i)%></li>
                    <%}%>
                  </ul>
                </div>
              </div></td>
          </tr>
          <tr>
          <td>&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align:right">* 系统中文名 :&nbsp;&nbsp;</td>
            <td><input type="text" class="input-xlarge" id="code" name="code"></td>
          </tr>
          <tr>
          <td>&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align:right">* 系统描述 :&nbsp;&nbsp;</td>
            <td><textarea  rows="4" name="description" class="input-xlarge" id="description"></textarea></td>
          </tr>
          <tr>
          <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="2"><input type="button" class="btn btn-primary" style="width:80px; text-align:center" name="apsut" id="apsut" onClick="applysutac()" value="提交申请"></td>
          </tr>
          <tr>
          <td>&nbsp;</td>
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