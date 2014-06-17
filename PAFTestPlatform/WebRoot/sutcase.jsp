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
if (request.getAttribute("versionflag") == null ){
request.getRequestDispatcher("${pageContext.request.contextPath}/queryVersion.action").forward(request,response);}
List<Version> versions = (List<Version>)request.getAttribute("versions");
String sut_name = (String)request.getAttribute("sut_name");
String isCurrentRole;
if (String.valueOf(request.getAttribute("isCurrentRole")) == "true"){
	isCurrentRole = "y";
}
else { isCurrentRole = "n";};
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="dist/themes/default/style.min.css" />
<link href="css/shou.css" rel="stylesheet">
<script src="dist/libs/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script src="dist/jstree.min.js"></script>
<script type="text/javascript" src="js/zDialog.js"></script>
<script type="text/javascript" src="js/zDrag.js"></script>
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
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}
	
	function createTestSuite(){
	var diag = new Dialog();
	diag.Width = 500;
	diag.Height = 150;
	diag.Title = "创建TestSuite";
	diag.InvokeElementId="createTestSuite"
	diag.OKEvent = function(){
					//alert(topWin.$id("testsuite_name").value);
					//alert(topWin.$id("testsuite_name").value.length);
					if (topWin.$id("testsuite_name").value == ""){
					Dialog.alert("用户名不能为空");
						}
					else if ( topWin.$id('testsuite_description').value.length > 50){
					Dialog.alert("描述不能超过50个字符");
						}
					else {
					newTestSuiteac();
					diag.close();
					}
					};//点击确定后调用的方法
	diag.CancelEvent = function(){
						$.ajax({
			 			 type : "POST",
			 			 url : "initialTestsuites.action",
			 			 cache : false,
					     data : {sut_name:'<%=sut_name%>'},
			  			 dataType : "json",
			 			 success : function(root) {
								   $('#jstree').jstree(true).destroy();
				  				   datadata = root.jsonArray;
				 				   testtest();
								   diag.close();
								   document.getElementById('iniTd').style.display = "block";
				  				   document.getElementById('showTestSuiteTd').style.display = "none";
				                   document.getElementById('showTestCaseTd').style.display = "none";
			 					   },
			  			 error: function(XMLHttpRequest, textStatus, errorThrown) {
				  				alert(XMLHttpRequest.status);
				  				alert(XMLHttpRequest.readyState);
				  				alert(textStatus);
			  					}
		  				});
						};
	diag.show();
	};
	
	function createTestCase(){
	var diag = new Dialog();
	diag.Width = 600;
	diag.Height = 500;
	diag.Title = "创建TestCase";
	diag.InvokeElementId="createTestCase"
	diag.OKEvent = function(){
					//alert(topWin.$id('description').value.length);
					if (topWin.$id("testcase_name").value == ""){
					Dialog.alert("用户名不能为空");
						}
					else if ( topWin.$id('description').value.length > 50){
					Dialog.alert("描述不能超过50个字符");
						}
					else if (topWin.$id('casesteps').value.length > 150 ){
					Dialog.alert("描述不能超过150个字符");
						}
					else{
						newTestCaseac();
						diag.close();
						}
					};//点击确定后调用的方法
	diag.CancelEvent = function(){
						$.ajax({
			 			 type : "POST",
			 			 url : "initialTestsuites.action",
			 			 cache : false,
					     data : {sut_name:'<%=sut_name%>'},
			  			 dataType : "json",
			 			 success : function(root) {
								   $('#jstree').jstree(true).destroy();
				  				   datadata = root.jsonArray;
				 				   testtest();
								   diag.close();
								   document.getElementById('iniTd').style.display = "block";
				  				   document.getElementById('showTestSuiteTd').style.display = "none";
				                   document.getElementById('showTestCaseTd').style.display = "none";
			 					   },
			  			 error: function(XMLHttpRequest, textStatus, errorThrown) {
				  				alert(XMLHttpRequest.status);
				  				alert(XMLHttpRequest.readyState);
				  				alert(textStatus);
			  					}
		  				});
						};
	diag.show();
	};
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
			  //alert(ref.get_node(sel).type);
			  if(ref.get_node(sel).type == "interfacetestcase"){
				  interfacetestsuite = ref.get_node(sel).text;
				  document.getElementById('testsuite_name').value = interfacetestsuite;
				  createTestSuite();
				  }
			  else if(ref.get_node(sel).type == "testcase"){
				  interfacetestcase = ref.get_node(sel).text;
				  document.getElementById('testcase_name').value = interfacetestcase;
				  document.getElementById('casetestsuite_name').value = ref.get_node(ref.get_parent(sel)).text; 
				  createTestCase();
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
	  var isdiscard_value;
	  isdiacard_radio = document.getElementsByName('isdiscard');
	  for(i=0;i<isdiacard_radio.length;i++){  
	  	if(isdiacard_radio[i].checked){
	    	isdiscard_value = isdiacard_radio[i].value;
	  	}
	  };
	  var tsparams = {testsuite_name:$("#testsuite_name").val(),sut_name:$("#sut_name").val(),testsuite_description:$("#testsuite_description").val(),isdiscard:"alive",version:$("#version").val()};
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
	document.getElementById('showtestsuite_description').readOnly = false;
	document.getElementById('showversion').readOnly = false;
	document.getElementById('showisdiscardtd').style.display = "none";
	document.getElementById('showisdiscardoption').style.display = "block";
	document.getElementById('showversiontd').style.display = "none";
	document.getElementById('showversionoption').style.display = "block";	
	document.getElementById('upTestSuite').style.display = "none";
	document.getElementById('saveTestSuite').style.display = "block";
	
	};

function saveTestSuiteac(){
	var isdiscard_value;
	  isdiacard_radio = document.getElementsByName('updateisdiscard');
	  for(i=0;i<isdiacard_radio.length;i++){  
	  	if(isdiacard_radio[i].checked){
	    	isdiscard_value = isdiacard_radio[i].value;
	  	}
	  };
	var tsparams = {testsuite_name:$("#showtestsuite_name").val(),sut_name:$("#showsut_name").val(),testsuite_id:$("#showtestsuite_id").val(),testsuite_description:$("#showtestsuite_description").val(),isdiscard:isdiscard_value,version:$("#updateversion").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  document.getElementById('showtestsuite_name').readOnly = true;
				  document.getElementById('showtestsuite_description').readOnly = true;
				  document.getElementById('showversion').readOnly = true;
				  document.getElementById('showversiontd').style.display = "block";
				  document.getElementById('showversionoption').style.display = "none";
				  document.getElementById('showisdiscardtd').style.display = "block";
				  document.getElementById('showisdiscardoption').style.display = "none";
				  document.getElementById('upTestSuite').style.display = "block";
				  document.getElementById('saveTestSuite').style.display = "none";
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
	  var priority_value;
	  priority_radio = document.getElementsByName('priority');
	  for(i=0;i<priority_radio.length;i++){  
	  	if(priority_radio[i].checked){
	    	priority_value = priority_radio[i].value;
	  	}
	  };
	  var status_value;
	  status_radio = document.getElementsByName('status');
	  for(i=0;i<status_radio.length;i++){  
	  	if(status_radio[i].checked){
	    	status_value = status_radio[i].value;
	  	}
	  };
	  var type_value;
	  type_radio = document.getElementsByName('type');
	  for(i=0;i<type_radio.length;i++){  
	  	if(type_radio[i].checked){
	    	type_value = type_radio[i].value;
	  	}
	  };
	  var tsparams = {testcase_name:$("#testcase_name").val(),sut_name:$("#casesut_name").val(),testsuite_name:$("#casetestsuite_name").val(),description:$("#description").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#casesteps").val(),testcase_approval:"待评审"};
	  $.ajax({
			  type : "POST",
			  url : "createTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
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
	document.getElementById('showcaseprioritytd').style.display = "none";
	document.getElementById('showcasepriorityoption').style.display = "block";
	document.getElementById('showcasestatustd').style.display = "none";
	document.getElementById('showcasestatusoption').style.display = "block";
	document.getElementById('showcasetypetd').style.display = "none";
	document.getElementById('showcasetypeoption').style.display = "block";
	document.getElementById('showapprovaltd').style.display = "none";
	document.getElementById('showaprovaloption').style.display = "block";
	document.getElementById('showcasedescription').readOnly = false;
	document.getElementById('showcasesteps').readOnly = false;	
	document.getElementById('upTestCase').style.display = "none";
	document.getElementById('saveTestCase').style.display = "block";
	}

function saveTestCaseac(){
	var priority_value;
	  priority_radio = document.getElementsByName('updatepriority');
	  for(i=0;i<priority_radio.length;i++){  
	  	if(priority_radio[i].checked){
	    	priority_value = priority_radio[i].value;
	  	}
	  };
	  var status_value;
	  status_radio = document.getElementsByName('updatestatus');
	  for(i=0;i<status_radio.length;i++){  
	  	if(status_radio[i].checked){
	    	status_value = status_radio[i].value;
	  	}
	  };
	  var type_value;
	  type_radio = document.getElementsByName('updatetype');
	  for(i=0;i<type_radio.length;i++){  
	  	if(type_radio[i].checked){
	    	type_value = type_radio[i].value;
	  	}
	  };
	  var approval_value;
	  approval_radio = document.getElementsByName('updateapproval');
	  for(i=0;i<approval_radio.length;i++){  
	  	if(approval_radio[i].checked){
	    	approval_value = approval_radio[i].value;
	  	}
	  };
	  var sut_name = '<%=sut_name%>';
	  var tsparams = {testcase_name:$("#showtestcase_name").val(),sut_name:sut_name,testcase_id:$("#showtestcase_id").val(),testsuite_name:$("#showcasetestsuite_name").val(),description:$("#showcasedescription").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#showcasesteps").val(),testcase_approval:approval_value};
	  $.ajax({
			  type : "POST",
			  url : "updateTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();
				  document.getElementById('iniTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  document.getElementById('showtestcase_name').readOnly = true;
				  document.getElementById('showcaseprioritytd').style.display = "block";
	  		      document.getElementById('showcasepriorityoption').style.display = "none";
				  document.getElementById('showcasestatustd').style.display = "block";
				  document.getElementById('showcasestatusoption').style.display = "none";
				  document.getElementById('showcasetypetd').style.display = "block";
				  document.getElementById('showcasetypeoption').style.display = "none";
				  document.getElementById('showapprovaltd').style.display = "block";
				  document.getElementById('showaprovaloption').style.display = "none";
	  			  document.getElementById('showcasedescription').readOnly = true;
			   	  document.getElementById('showcasesteps').readOnly = true;	
				  document.getElementById('upTestCase').style.display = "block";
				  document.getElementById('saveTestCase').style.display = "none";
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
	   var tsparams;
	   var sut_name = '<%=sut_name%>';
	   if ( type.type == "interfacetestcase"){
		interfacetestsuite = ref.get_node(sel).text;
		document.getElementById('showtestsuite_name').value = interfacetestsuite;
		tsparams = {testsuite_name:interfacetestsuite,sut_name:sut_name};
		$.ajax({
			  type : "POST",
			  url : "queryTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  document.getElementById('showtestsuite_id').value = root.testsuite.id;
				  document.getElementById('showtestsuite_description').value = root.testsuite.description;
				  document.getElementById('showversion').value = root.testsuite.version.versionNum;
				  document.getElementById('showisdiscard').value = root.testsuite.status;
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
		interfacetestsuite = ref.get_node(sel).text;
		document.getElementById('showtestsuite_name').value = interfacetestsuite;
		document.getElementById('iniTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "block";
		document.getElementById('showTestCaseTd').style.display = "none";
		}
		else if (type.type == "testcase"){
		interfacetestcase = ref.get_node(sel).text;
		document.getElementById('showtestcase_name').value = interfacetestcase;
		document.getElementById('showcasetestsuite_name').value = ref.get_node(ref.get_parent(sel)).text;
		tsparams = {testcase_name:interfacetestcase,sut_name:sut_name};
		$.ajax({
			  type : "POST",
			  url : "queryTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  document.getElementById('showtestcase_id').value = root.testcase.id;
				  document.getElementById('showcasepriority').value = root.testcase.priority;
				  document.getElementById('showcasestatus').value = root.testcase.status;
				  document.getElementById('showcasetype').value = root.testcase.casetype;
				  document.getElementById('showcasedescription').value = root.testcase.description;
				  document.getElementById('showcasesteps').value = root.testcase.casesteps;
				  document.getElementById('showapproval').value = root.testcase.testcase_approval;
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert("function error");
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	    document.getElementById('iniTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "block";
		}
		else {
		document.getElementById('iniTd').style.display = "block";
		document.getElementById('showTestSuiteTd').style.display = "none";
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

function initree(){
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
	};

function queryinterfaceac(){
	var querystatus = $("#querystatus").val();
	var querypriority = $("#querypriority").val();
	var querytype = $("#querytype").val();
	var queryapproval = $("#queryapproval").val();
	var queryparams = {status:querystatus,priority:querypriority,casetype:querytype,testcase_approval:queryapproval,sut_name:'<%=sut_name%>'};
	$.ajax({
			  type : "POST",
			  url : "queryCombineConditions.action",
			  data : queryparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  datadata = root.jsonArray;
				  testtest();
				   
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	
};



function validateac(){
	if($("#validateForm").valid()){
			alert("validate success");
			}
		else {alert("validate failed");}
	};

  $(document).ready( function(){
	  initree();
	$("#versiongroup").jQSelect({});
	$("#updateversiongroup").jQSelect({});
	$("#showTestSuiteForm").validate({
			rules : {
				"testsuite_name" : {
					required : true,
					maxlength : 15
				}
			},
			messages : {
				"testsuite_name" : {
					required : "请输入TestSuiteName",
					maxlength : $.validator.format("TestSuiteName最大输入不超过十五个字符.")
				}
			}
		});
		/*$("#validateForm").validate({
			rules : {
				"validatezhou1111" : {
					required : true,
					maxlength : 15
				}
			},
			messages : {
				"validatezhou1111" : {
					required : "请输入TestSuiteName",
					maxlength : $.validator.format("TestSuiteName最大输入不超过十五个字符.")
				}
			}
		});*/
  
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
      <td width="75" id="iniTd" style="display:block;" ><!--查询-->
        <table border="1">
          <tr>
            <td colspan="5" style="text-align:center">查询条件</td>
          </tr>
          <tr>
            <td>TestCase</td>
            <td>自动化
              <select id="querystatus">
                <option value="All" selected>All</option>
                <option value="自动">自动</option>
                <option value="手动">手动</option>
                <option value="废弃">废弃</option>
              </select></td>
            <td>优先级
              <select id="querypriority">
                <option value="All" selected>All</option>
                <option value="P1">P1</option>
                <option value="P2">P2</option>
                <option value="P3">P3</option>
              </select></td>
            <td>正反例
              <select id="querytype">
                <option value="All" selected>All</option>
                <option value="正例">正例</option>
                <option value="反例">反例</option>
              </select></td>
            <td>用例评审
              <select id="queryapproval">
                <option value="All" selected>All</option>
                <option value="待评审">待评审</option>
                <option value="通过">通过</option>
                <option value="未通过">未通过</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="5" style="text-align:center"><input type="button" onClick="queryinterfaceac()" value="搜索"></td>
          </tr>
        </table>
        <table id="resulttable">
        </table>
        </td>
      <!--展示、更新testsuite-->
      <td width="75%" style="display:none" id="showTestSuiteTd"><form id="showTestSuiteForm" name="showTestSuiteForm">
          <table width="100%">
            <tr>
              <td><label for="showtestsuite_name">TestSuiteName</label></td>
              <td><input id="showtestsuite_name" name="testsuite_name" value="" readonly></td>
            </tr>
            <tr>
              <td colspan="2"><input id="showtestsuite_id" name="testsuite_id" value="" style="display:block" readonly></td>
            </tr>
            <tr>
              <td><label for="showsut_name">所属系统</label></td>
              <td><input id="showsut_name" name="sut_name" value="<%=sut_name%>" readonly></td>
            </tr>
            <tr>
              <td>起始版本</td>
              <td id="showversiontd" style="display:block"><input id="showversion" value="" readonly></td>
              <td id="showversionoption" style="display:none"><div id="updateversiongroup" class="selectbox">
                  <div class="cartes">
                    <input type="text" value="<%=versions.get(0).getVersionNum()%>" id="updateversion" name="version" class="listTxt" readonly />
                    <div class="listBtn"><b></b></div>
                    <input type="hidden" value="" class="listVal" />
                  </div>
                  <div class="lists">
                    <ul class="list">
                      <% for (int i =0; i<versions.size(); i++){%>
                      <li id=<%=i%>><%=versions.get(i).getVersionNum()%></li>
                      <%}%>
                    </ul>
                  </div>
                </div></td>
            </tr>
            <tr>
              <td>是否废弃</td>
              <td id="showisdiscardtd" style="display:block"><input id="showisdiscard" value="" readonly></td>
              <td id="showisdiscardoption" style="display:none"><input type="radio" name="updateisdiscard" value="alive" checked>
                Alive&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateisdiscard" value="discard">
                Discard&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
              <td>描述</td>
              <td><textarea  rows="4" name="testsuite_description" class="input-xlarge" readonly id="showtestsuite_description" style="max-height:50px; max-width:200px; width:200px; height:50px;"></textarea></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestSuiteac()" id="upTestSuite" name="upTestSuite" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestSuiteac()" id="saveTestSuite" name="saveTestSuite" style="display:none">保存</button></td>
            </tr>
          </table>
        </form></td>
      <!--展示更新testcase-->
      <td width="75%" style="display:none" id="showTestCaseTd"><form id="showTestCaseForm">
          <table width="100%">
            <tr>
              <td><label for="showtestcase_name">TestCaseName</label></td>
              <td><input id="showtestcase_name" name="testcase_name" value="" readonly></td>
            </tr>
            <tr>
              <td colspan="2"><input id="showtestcase_id" name="testcase_id" value="" style="display:block" readonly></td>
            </tr>
            <tr>
              <td>所属TestSuite</td>
              <td><input id="showcasetestsuite_name" name="testsuite_name" value="" maxlength="15" readonly></td>
            </tr>
            <tr>
              <td>优先级</td>
              <td id="showcaseprioritytd" style="display:block"><input id="showcasepriority" value="" readonly></td>
              <td id="showcasepriorityoption" style="display:none"><input type="radio" name="updatepriority" id="p1" value="P1" checked>
                P1&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatepriority" id="p2" value="P2">
                P2&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatepriority" id="p3" value="P3">
                P3</td>
            </tr>
            <tr>
              <td>状态</td>
              <td id="showcasestatustd" style="display:block"><input id="showcasestatus" value="" readonly></td>
              <td id="showcasestatusoption" style="display:none"><input type="radio" name="updatestatus" id="manul" value="手动" checked>
                手动&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatestatus" id="auto" value="自动">
                自动&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatestatus" value="废弃" id="discard">
                废弃</td>
            </tr>
            <tr>
              <td>正例 or 反例</td>
              <td id="showcasetypetd" style="display:block"><input id="showcasetype" value="" readonly></td>
              <td id="showcasetypeoption" style="display:none"><input type="radio" name="updatetype" id="zhengli" value="正例" checked>
                正例&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" id="fanli" name="updatetype" value="反例" >
                反例</td>
            </tr>
            <tr>
              <td>用例评审</td>
              <td id="showapprovaltd" style="display:block"><input id="showapproval" value="" readonly></td>
              <td id="showaprovaloption" style="display:none"><input type="radio" name="updateapproval" value="待评审" checked>
                待评审&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateapproval" value="通过">
                通过&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateapproval" value="未通过">
                未通过&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
              <td>描述</td>
              <td><textarea  rows="4" name="description" class="input-xlarge" id="showcasedescription" style="max-height:50px; max-width:200px; width:200px; height:50px;" readonly></textarea></td>
            </tr>
            <tr>
              <td>步骤</td>
              <td><textarea  rows="4" name="casesteps" class="input-xlarge" id="showcasesteps" style="max-height:150px; max-width:200px; width:200px; height:150px;" readonly></textarea></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestCaseac()" id="upTestCase" name="upTestCase" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestCaseac()" id="saveTestCase" name="saveTestCase" style="display:none">保存</button></td>
            </tr>
          </table>
        </form></td>
    </tr>
  </table>
  <!--隐藏表单创建testsuite-->
  <div id="createTestSuite" style="display:none">
    <form>
      <table width="500" height="150" style="background:#FFF">
        <tr>
          <td><label for="testsuite_name">TestSuiteName</label></td>
          <td><input id="testsuite_name" name="testsuite_name" value=""></td>
        </tr>
        <tr>
          <td colspan="2"><input id="sut_name" name="sut_name" style="display:none" value="<%=sut_name%>" readonly></td>
        </tr>
        <tr>
          <td>起始版本</td>
          <td><div id="versiongroup" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=versions.get(0).getVersionNum()%>" id="version" name="version" class="listTxt" readonly />
                <div class="listBtn"><b></b></div>
                <input type="hidden" value="" class="listVal" />
              </div>
              <div class="lists">
                <ul class="list">
                  <% for (int i =0; i<versions.size(); i++){%>
                  <li id=<%=i%>><%=versions.get(i).getVersionNum()%></li>
                  <%}%>
                </ul>
              </div>
            </div></td>
        </tr>
        <tr>
          <td>描述</td>
          <td><textarea  rows="4" name="testsuite_description" class="input-xlarge" id="testsuite_description" style="max-height:50px; max-width:200px; width:200px; height:50px;"></textarea></td>
        </tr>
        <tr>
          <td></td>
        </tr>
      </table>
    </form>
  </div>
  <!--隐藏表单创建testcase-->
  <div id="createTestCase" style="display:none">
    <form>
      <table width="600" height="500" style="background:#FFF">
        <tr>
          <td>TestCase</td>
          <td><input id="testcase_name" name="testcase_name" value="" maxlength="15"></td>
        </tr>
        <tr>
          <td colspan="2"><input id="casesut_name" style="display:none" name="sut_name" value="<%=sut_name%>"></td>
        </tr>
        <tr>
          <td>所属TestSuite</td>
          <td><input id="casetestsuite_name" name="testsuite_name" value="" maxlength="15" readonly></td>
        </tr>
        <tr>
          <td>优先级</td>
          <td><input type="radio" name="priority" id="p1" value="P1" checked>
            P1&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="priority" id="p2" value="P2">
            P2&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="priority" id="p3" value="P3">
            P3</td>
        </tr>
        <tr>
          <td>状态</td>
          <td><input type="radio" name="status" id="manul" value="手动" checked>
            手动&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="status" id="auto" value="自动">
            自动&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="status" value="废弃" id="discard">
            废弃</td>
        </tr>
        <tr>
          <td>正例 or 反例</td>
          <td><input type="radio" name="type" id="zhengli" value="正例" checked>
            正例&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" id="fanli" name="type" value="反例">
            反例</td>
        </tr>
        <tr>
          <td>描述</td>
          <td><textarea  rows="4" name="description" class="input-xlarge" id="description" style="max-height:50px; max-width:200px; width:200px; height:50px;"></textarea></td>
        </tr>
        <tr>
          <td>步骤</td>
          <td><textarea  rows="4" name="casesteps" class="input-xlarge" id="casesteps" style="max-height:150px; max-width:200px; width:200px; height:150px;"></textarea></td>
        </tr>
      </table>
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