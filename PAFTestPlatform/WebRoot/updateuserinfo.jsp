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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">

<%
	if ( session.getAttribute("user") == null ) { %>
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
                	digits:true,
					maxlength: 20
           		},
            	"mobile":{
                	digits:true,
					maxlength: 20
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
                	digits: "请输入数字",
					maxlength: $.validator.format("最大输入不超过二十个字符.")
            	},
            	"mobile":{
                	digits: "请输入数字",
					maxlength: $.validator.format("最大输入不超过二十个字符.")
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

	if (userinfo.getDepartment() != null && userinfo.getDepartment().getName() != null) {
		department = userinfo.getDepartment().getName();
	}

	if (userinfo.getPosition() != null && userinfo.getPosition().getName() != null) {
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
		otherinfo = userinfo.getOtherinfo();
	}
	;
%>
<script type="text/javascript">
$(document).ready(function(){
	$("#selectPosition").jQSelect({});
	$("#selectDepartment").jQSelect({});
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
<%=session.getAttribute("user")%>
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
    <%} else { %>
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
  <div>
    <form id="updateinfoForm" class="form-horizontal" method="post"
				action="${pageContext.request.contextPath}/updateuserinfo.action">
      <fieldset>
        <legend> 用户信息更新 <small>(带*号标志为必输项)</small> </legend>
        <table style="width:40%" align="left" class="table table-striped">
          <tr>
            <td>* 真实姓名 :</td>
            <td colspan="3"><input type="text" id="displayname"
								name="displayname" value="<%=displayname%>" style="width:200px;"></td>
          </tr>
          <tr>
            <td>* 所属部门 :</td>
            <td><div id="selectDepartment" class="selectbox">
                <div class="cartes">
                  <input type="text" value="<%=department%>" id="department" name="department" class="listTxt" />
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
            <td>* 职  位 :</td>
            <td><div id="selectPosition" class="selectbox">
                <div class="cartes">
                  <input type="text" value="<%=position%>" id="position" name="position" class="listTxt" />
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
            <td colspan="3"><input type="text" id="telephone" name="telephone"
								value="<%=telephone%>" style="width:200px;"></td>
          </tr>
          <tr>
            <td>移动电话 :</td>
            <td colspan="3"><input type="text" id="mobile"
								name="mobile" value="<%=mobile%>" style="width:200px;"></td>
          </tr>
          <tr>
          	<td>其他邮件 :</td>
            <td colspan="3"><input type="text" id="othermail"
								name="othermail" value="<%=othermail%>" style="width:200px;"></td>
          </tr>
          <tr>
          <td>用户备注 :</td>
          <td colspan="3"><textarea  id="otherinfo" name="otherinfo" style="height:100px; max-height:100px; width:300px; max-width:300px" ><%=otherinfo%></textarea></td>
        </tr>
          <tr align="center">
          	<td colspan="4"><button type="submit" class="btn btn-primary" style="width:80px; text-align:center">提交</button></td>
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