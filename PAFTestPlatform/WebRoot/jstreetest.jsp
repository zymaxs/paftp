<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*, net.sf.json.*"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="dist/themes/default/style.min.css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script src="dist/libs/jquery.js"></script>
<script src="dist/jstree.min.js"></script>
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
        <button type="button" class="btn btn-primary" onClick="loginac()" id="loginbtn" name="loginbtn" tabindex="3">LogIn</button>
        <button type="button" class="btn btn-primary" onClick="window.location.href='findpwd.jsp'" id="findpwdbtn" name="findpwdbtn" tabindex="4">找回密码</button>
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
                <li><a href="index_1.jsp">主页</a></li>
                <li><a href="sutindex.jsp">SUT</a></li>
                <li><a href="rolemanagement.jsp">用户权限</a></li>
                <li><a href="inimanager.jsp">隐藏用户权限for Admin</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <div align="center"> Hello World! </div>
  					<div>
						<input type="text" id="plugins4_q" value="" class="input" display:block; padding:4px; border-radius:4px; border:1px solid silver;" />
					</div>
    					<div class="col-md-4 col-sm-8 col-xs-8">
						<button type="button" class="btn btn-success btn-sm" onclick="demo_create();"><i class="glyphicon glyphicon-asterisk"></i> Create</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="demo_delete();"><i class="glyphicon glyphicon-remove"></i> Delete</button>				
					</div>
    
    <div id="jstree"></div>
    <div id="event_result" style="margin-top:2em; text-align:left;">hhhhh&nbsp;</div>
  <!-- 4 include the jQuery library -->
  <script src="dist/libs/jquery.js"></script>
  <!-- 5 include the minified jstree source -->
  <script src="dist/jstree.min.js"></script>
  <script>
  function demo_create() {
		var ref = $('#jstree').jstree(true);
		var	sel = ref.get_selected();
		if(!sel.length) { return false; }
		var type = ref.get_type(sel, true);
		if (type.type != "sut"){
			if(type.valid_children == "interfacetestcase")
				sel = ref.create_node(sel, {"type":type.valid_children[0]});
			else
        		sel = ref.create_node(sel, {"type":type.valid_children[0]});
        	if(sel) {
    			ref.edit(sel);
    		}
		}
	
	};
	/*function demo_rename() {
		var ref = $('#jstree').jstree(true);
		var	sel = ref.get_selected();
		if(!sel.length) { return false; }
		var type = ref.get_type(sel, true);
		if (type.type != "sut" && type.type != "testsuite")
			ref.edit(sel);
	};*/
	function demo_delete() {
		var ref = $('#jstree').jstree(true);
		var	sel = ref.get_selected();
		if(!sel.length) { return false; }
		var type = ref.get_type(sel, true);
		if (type.type != "sut" && type.type != "interfacetestsuite" && type.type != "stresstestsuite"){
			ref.delete_node(sel);
		}
		
	};
var datadata = "test";
	$(document).ready( function(){
		  $.ajax({
				type : "POST",
				url : "initialTestsuites.action",
				data : "",
				dataType : "json",
				success : function(root) {
					datadata = root.jsonArray;
					testtest();
				},

                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
			});
function testtest(){
	// 6 create an instance when the DOM is ready
    $('#jstree').on('changed.jstree', function (e, data) {
        var i, j, r = [];
        for(i = 0, j = data.selected.length; i < j; i++) {
          r.push(data.instance.get_node(data.selected[i]).text);
        }
        $('#event_result').html('Selected: ' + r.join(', '));
      }).jstree({


        'core' : {
			//"animation" : 0,
			"check_callback" : true,
			//"themes" : { "stripes" : true },
			//'data': [{ 'id' : 'ajson1', 'parent' : '#', 'text' : 'Simple root node' },{ 'id' : 'ajson2', 'parent' : '#', 'text' : 'Root node 2' },{ 'id' : 'ajson3', 'parent' : 'ajson2', 'text' : 'Child 1' },{ 'id' : 'ajson4', 'parent' : 'ajson2', 'text' : 'Child 2'}]
        	//'data': datadata 
        	'data' :datadata
			},
			"types" : {
			    "#" : {
			        "max_children" : -2, 
			        "max_depth" : 4, 
			        "valid_children" : ["sut"]
			      },
			    "sut" : {
				  "valid_firstchildren" : ["interfacetestsuite"],
			      "valid_secondchildren" : ["stresstestsuite"]
			    },
			    "interfacetestsuite" : {
			      "valid_children" : ["interfacetestcase"]
			    },
			  	"stresstestsuite" : {
			        "valid_children" : ["stresstestcase"]
			    },
			    "interfacetestcase" : {
			    	"valid_children": ["testcase"]
			    },
			    "stresstestcase" : {
			    	"icon":"xxx",
			      "valid_children" : []
			    },
			    "testcase":{
			    	"icon":"xxx",
			    	"valid_children":[]
			    }

			  },
         'plugins' : ['types','unique','search' ]

  });
    
    var to = false;
    $('#plugins4_q').keyup(function () {
      if(to) { clearTimeout(to); }
      to = setTimeout(function () {
        var v = $('#plugins4_q').val();
        $('#jstree').jstree(true).search(v);
      }, 250);
    });
    // 7 bind to events triggered on the tree
    $('#jstree').on("changed.jstree", function (e, data) {
      console.log(data.selected);
    });
    // 8 interact with the tree - either way is OK
    //$('button').on('click', function () {
     // $('#jstree').jstree(true).select_node('child_node_1');
      //$('#jstree').jstree('select_node', 'child_node_1');
      //$.jstree.reference('#jstree').select_node('child_node_1');
    //});
}
    
  });

  </script>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>

</body>
</html>