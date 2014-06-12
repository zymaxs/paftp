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
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/initialParameters.action").forward(request,response);}
String sut_name = (String)request.getAttribute("sut_name");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="dist/themes/default/style.min.css" />
<script src="dist/libs/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
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
<script type="text/javascript">
var interfacetestsuite = "";
var interfacetestcase = "";
function demo_create() {
	  var ref = $('#jstree').jstree(true);
	  var	sel = ref.get_selected();
	  if(!sel.length) { return false; }
	  var type = ref.get_type(sel, true);
	  if (type.type != "sut"){
		  if(type.valid_children == "interfacetestcase"){
			  sel = ref.create_node(sel, {"type":type.valid_children[0]});
		  }
		  else{
			  sel = ref.create_node(sel, {"type":type.valid_children[0]});
		  }
		  if(sel) {
			  ref.deselect_node(ref.get_parent(sel));
			  ref.select_node(sel);
			  if(ref.get_node(sel).type == "interfacetestcase"){
				  interfacetestsuite = ref.get_node(sel).text;
				  document.getElementById('testsuite_name').value = interfacetestsuite;
				  document.getElementById('iniTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "block";
				  document.getElementById('newTestCaseTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  }
			  else if(ref.get_node(sel).type == "testcase"){
				  interfacetestcase = ref.get_node(sel).text;
				  document.getElementById('testcase_name').value = interfacetestcase;
				  document.getElementById('iniTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "none";
				  document.getElementById('newTestCaseTd').style.display = "block";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  }
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
	  if (type.type != "sut" && type.type != "interfacetestsuite" && type.type != "stresstestsuite")
		  ref.delete_node(sel);

  };
 var datadata = "test"; 
 
 // 创建TestSuite
  function newTestSuiteac(){
	  var tsparams = {testsuite_name:$("#testsuite_name").val(),sut_name:$("#sut_name").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  datadata = root.jsonArray;
				  testtest();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "none";
				  document.getElementById('newTestCaseTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	  
	  };

//更新并且保存TestSuite
function updateTestSuiteac(){
	
	document.getElementById('showtestsuite_name').readOnly = false;
	document.getElementById('upTestSuite').style.display = "none";
	document.getElementById('saveTestSuite').style.display = "block";
	
	};

function saveTestSuiteac(){
	var tsparams = {testsuite_name:$("#showtestsuite_name").val(),sut_name:$("#showsut_name").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  datadata = root.jsonArray;
				  testtest();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "none";
				  document.getElementById('newTestCaseTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	};
	  
//创建TestCase
function newTestCaseac(){
	  var tsparams = {testsuite_name:$("#testcase_name").val(),sut_name:$("#sut_name").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  datadata = root.jsonArray;
				  testtest();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "none";
				  document.getElementById('newTestCaseTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	  
	  };
	  
//更新并且保存TestCase

function updateTestCaseac(){	
	document.getElementById('showtestcase_name').readOnly = false;
	document.getElementById('upTestCase').style.display = "none";
	document.getElementById('saveTestCase').style.display = "block";
	}

function saveTestCaseac(){
	var tsparams = {testsuite_name:$("#showtestsuite_name").val(),sut_name:$("#showsut_name").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  datadata = root.jsonArray;
				  testtest();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('newTestSuiteTd').style.display = "none";
				  document.getElementById('newTestCaseTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	}

function testtest(){
  // 6 create an instance when the DOM is ready
  $('#jstree').on('changed.jstree', function (e, data) {
	   var ref = $('#jstree').jstree(true);
	   var sel = ref.get_selected();
	   var type = ref.get_type(sel, true);
	   var zhou = ref.get_node(sel);
	   
	   if ( type.type == "interfacetestcase"){
		interfacetestsuite = ref.get_node(sel).text;
		document.getElementById('showtestsuite_name').value = interfacetestsuite;
		document.getElementById('iniTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "block";
		document.getElementById('newTestSuiteTd').style.display = "none";
		document.getElementById('newTestCaseTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "none";
		}
		else if (type.type == "testcase"){
		interfacetestcase = ref.get_node(sel).text;
		document.getElementById('showtestcase_name').value = interfacetestcase;
	    document.getElementById('iniTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('newTestSuiteTd').style.display = "none";
		document.getElementById('newTestCaseTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "block";	
		}
		else {
		document.getElementById('iniTd').style.display = "block";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('newTestSuiteTd').style.display = "none";
		document.getElementById('newTestCaseTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "none";
			}
	   
	   var i, j, r = [];
	  for(i = 0, j = data.selected.length; i < j; i++) {
		r.push(data.instance.get_node(data.selected[i]).text);
	  }
	  $('#event_result').html('Selected: ' + r.join(', '));
	}).jstree({


	  'core' : {
		  //"multiple" : false,
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
};
  
  $(document).ready( function(){
		$.ajax({
			  type : "POST",
			  url : "initialTestsuites.action",
			  cache : false,
			  data : {sut_name:'<%=sut_name%>'},
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
                <li><a href="casemanagement.jsp">case管理</a></li>
                <li><a href="inimanager.jsp">隐藏用户权限for Admin</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--主体-->
  <table border="1" width="100%">
    <tr>
      <td width="25%"><div style="height:450px;overflow:scroll;overflow-x:hidden;">
          <div>
            <input type="text" id="plugins4_q" value="" class="input" style="display:block; padding:4px; border-radius:4px; border:1px solid silver;">
          </div>
          <div>
            <button type="button" class="btn btn-success btn-sm" onclick="demo_create();"><i class="glyphicon glyphicon-asterisk"></i>Create</button>
            <button type="button" class="btn btn-danger btn-sm" onclick="demo_delete();"><i class="glyphicon glyphicon-remove"></i>Delete</button>
          </div>
          <div id="jstree"></div>
          <div id="event_result" style="margin-top:2em; text-align:left;">hhhhh&nbsp;</div>
        </div></td>
      <td width="75" id="iniTd" style="display:block; text-align:center" > HelloWorld! </td>
      <td width="75%" style="display:none" id="newTestSuiteTd"><form>
          <table width="100%">
            <tr>
              <td><label for="testsuite_name">TestSuiteName</label></td>
              <td><input id="testsuite_name" name="testsuite_name" value=""></td>
            </tr>
            <tr>
              <td><label for="sut_name">所属系统</label></td>
              <td><input id="sut_name" name="sut_name" value="<%=sut_name%>"></td>
            </tr>
            <tr>
              <td></td>
            </tr>
            <tr>
              <td colspan="2"><button type="button" class="btn btn-default" onClick="newTestSuiteac()" id="newTestSuite" name="newTestSuite">确认</button></td>
            </tr>
          </table>
        </form></td>
      <td width="75%" style="display:none" id="showTestSuiteTd"><form id="showTestSuiteForm" name="showTestSuiteForm" action="">
          <table width="100%">
            <tr>
              <td><label for="showtestsuite_name">TestSuiteName</label></td>
              <td><input id="showtestsuite_name" name="testsuite_name" value="" readonly></td>
            </tr>
            <tr>
              <td><label for="showsut_name">所属系统</label></td>
              <td><input id="showsut_name" name="sut_name" value="<%=sut_name%>" readonly></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestSuiteac()" id="upTestSuite" name="upTestSuite" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestSuiteac()" id="saveTestSuite" name="saveTestSuite" style="display:none">保存</button></td>
            </tr>
          </table>
        </form></td>
      <td width="75%" style="display:none" id="newTestCaseTd"><form id="newTestCase" name="newTestCase" action="">
          <table width="100%">
            <tr>
              <td><label for="testcase_name">TestCase</label></td>
              <td><input id="testcase_name" name="testcase_name" value=""></td>
            </tr>
            <tr>
              <td><label for="sut_name">所属系统</label></td>
              <td><input id="sut_name" name="sut_name" value="<%=sut_name%>"></td>
            </tr>
            <tr>
              <td colspan="2"><button type="button" class="btn btn-default" onClick="newTestCaseac()" id="newTestCase" name="newTestCase">确认</button></td>
            </tr>
          </table>
        </form></td>
      <td width="75%" style="display:none" id="showTestCaseTd"><form>
          <table width="100%">
            <tr>
              <td><label for="showtestcase_name">TestSuiteName</label></td>
              <td><input id="showtestcase_name" name="testcase_name" value="" readonly></td>
            </tr>
            <tr>
              <td><label for="sut_name">所属系统</label></td>
              <td><input id="sut_name" name="sut_name" value="<%=sut_name%>" readonly></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestCaseac()" id="upTestCase" name="upTestCase" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestCaseac()" id="saveTestCase" name="saveTestCase" style="display:none">保存</button></td>
            </tr>
          </table>
        </form></td>
    </tr>
  </table>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>