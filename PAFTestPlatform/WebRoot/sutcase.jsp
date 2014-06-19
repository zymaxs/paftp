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
if (request.getAttribute("projectflag") == null ){
request.getRequestDispatcher("${pageContext.request.contextPath}/queryTestcaseproject.action").forward(request,response);}
List<TestcaseProject> testcaseprojects = (List<TestcaseProject>)request.getAttribute("testcaseprojects");
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
					else if ( topWin.$id('testsuite_name').value.length > 50){
					Dialog.alert("名字不能超过50个字符");
						}
					else if (topWin.$id('testsuite_description').value == ""){
					Dialog.alert("TestSuite描述不能为空");	
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
								   document.getElementById('sutCaseInfoTd').style.display = "block";
				  				   document.getElementById('interfacesearchTd').style.display = "none";
				  				   document.getElementById('showTestSuiteTd').style.display = "none";
				 				   document.getElementById('showTestCaseTd').style.display = "none";
								   querySutCaseInfo();
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
					Dialog.alert("用例名称不能为空");
						}
					else if ( topWin.$id('testcase_name').value.length > 15){
					Dialog.alert("用例名称不能超过15个字符");
						}
					else if (topWin.$id('description').value == ""){
					Dialog.alert("用例描述描述不能为空");	
						}
					else if ( topWin.$id('description').value.length > 50){
					Dialog.alert("用例描述不能超过50个字符");
						}
					else if (topWin.$id('casesteps').value == ""){
					Dialog.alert("用例步骤不能为空");	
						}
					else if (topWin.$id('casesteps').value.length > 150 ){
					Dialog.alert("用例步骤不能超过150个字符");
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
								   document.getElementById('sutCaseInfoTd').style.display = "block";
				  				   document.getElementById('interfacesearchTd').style.display = "none";
				 				   document.getElementById('showTestSuiteTd').style.display = "none";
				 				   document.getElementById('showTestCaseTd').style.display = "none";
								   querySutCaseInfo();
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
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
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
				  document.getElementById('pre_stname').value = ref.get_node(ref.get_parent(sel)).text +"_";
				  document.getElementById('casetestsuite_name').value = ref.get_node(ref.get_parent(sel)).text; 
				  createTestCase();
				  }
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
  /*function demo_delete() {
	  var ref = $('#jstree').jstree(true);
	  var	sel = ref.get_selected();
	  if(!sel.length) { return false; }
	  var type = ref.get_type(sel, true);
	  if (type.type != "sut" && type.type != "interfacetestsuite" && type.type != "stresstestsuite")
		  ref.delete_node(sel);

  };*/
 var datadata = "test"; 
 var isSelf = "";
 
 // 创建TestSuite
  function newTestSuiteac(){
	  var isdiscard_value;
	  isdiacard_radio = document.getElementsByName('isdiscard');
	  for(i=0;i<isdiacard_radio.length;i++){  
	  	if(isdiacard_radio[i].checked){
	    	isdiscard_value = isdiacard_radio[i].value;
	  	}
	  };
	  var testsuite_name;
	  testsuite_name = "Ts_" + $("#testsuite_name").val();
	  var tsparams = {testsuite_name:testsuite_name,sut_name:$("#sut_name").val(),testsuite_description:$("#testsuite_description").val(),isdiscard:"alive",version:$("#version").val()};
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
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  querySutCaseInfo();
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
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
	document.getElementById('showtestsuite_name').readOnly = false;
	document.getElementById('showtestsuite_description').readOnly = false;
	document.getElementById('showversion').readOnly = false;
	document.getElementById('showisdiscardtd').style.display = "none";
	document.getElementById('showisdiscardoption').style.display = "block";
	document.getElementById('showversiontd').style.display = "none";
	document.getElementById('showversionoption').style.display = "block";	
	document.getElementById('upTestSuite').style.display = "none";
	document.getElementById('saveTestSuite').style.display = "block";
	}
	};

function saveTestSuiteac(){
	if($("#showTestSuiteForm").valid()){
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
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
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
	}
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
	  var testcase_name;
	  testcase_name = $("#pre_stname").val() + $("#testcase_name").val();
	  var tsparams = {testcase_name:testcase_name,sut_name:$("#casesut_name").val(),testsuite_name:$("#casetestsuite_name").val(),description:$("#description").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#casesteps").val(),testcase_approval:"待评审",project_name:$("#project").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  querySutCaseInfo();
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
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
	document.getElementById('showtestcase_name').readOnly = false;
	document.getElementById('showcaseprioritytd').style.display = "none";
	document.getElementById('showcasepriorityoption').style.display = "block";
	document.getElementById('showcasestatustd').style.display = "none";
	document.getElementById('showcasestatusoption').style.display = "block";
	document.getElementById('showcasetypetd').style.display = "none";
	document.getElementById('showcasetypeoption').style.display = "block";
	document.getElementById('showprojecttd').style.display = "none";
	document.getElementById('showprojectoption').style.display = "block";
	document.getElementById('showcasedescription').readOnly = false;
	document.getElementById('showcasesteps').readOnly = false;	
	document.getElementById('upTestCase').style.display = "none";
	document.getElementById('saveTestCase').style.display = "block";
	}
	}

function saveTestCaseac(){
	if($("#showTestCaseForm").valid()){
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
	  var approval_value = document.getElementById('showapproval').value;
	  /*approval_radio = document.getElementsByName('updateapproval');
	  for(i=0;i<approval_radio.length;i++){  
	  	if(approval_radio[i].checked){
	    	approval_value = approval_radio[i].value;
	  	}
	  };*/
	  var sut_name = '<%=sut_name%>';
	  var tsparams = {testcase_name:$("#showtestcase_name").val(),sut_name:sut_name,testcase_id:$("#showtestcase_id").val(),testsuite_name:$("#showcasetestsuite_name").val(),description:$("#showcasedescription").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#showcasesteps").val(),testcase_approval:approval_value,project_name:$("#updateproject").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();
				  document.getElementById('interfacesearchTd').style.display = "block";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  document.getElementById('showtestcase_name').readOnly = true;
				  document.getElementById('showprojecttd').style.display = "block";
				  document.getElementById('showprojectoption').style.display = "none";
				  document.getElementById('showcaseprioritytd').style.display = "block";
	  		      document.getElementById('showcasepriorityoption').style.display = "none";
				  document.getElementById('showcasestatustd').style.display = "block";
				  document.getElementById('showcasestatusoption').style.display = "none";
				  document.getElementById('showcasetypetd').style.display = "block";
				  document.getElementById('showcasetypeoption').style.display = "none";
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
		initype();
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
				 document.getElementById('showtestsuite_id').value = root.testsuitedto.id;
				 document.getElementById('showtestsuite_description').value = root.testsuitedto.description;
				 document.getElementById('showisdiscard').value = root.testsuitedto.status;
				 document.getElementById('showversion').value = root.testsuitedto.version.versionNum;
				 var p1 = "0";
				 var p2 = "0";
				 var p3 = "0";
				 var zhengli = "0";
				 var fanli = "0";
				 var zidong = "0";
				 var shoudong = "0";
				 var feiqi = "0";
				 var daipingshen = "0";
				 var tongguo = "0";
				 var butongguo = "0";
				 if (root.condtestcase_quantity.priority != null){
				 for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.priority[i] != null){
						if(root.condtestcase_quantity.priority[i][0] == "P1"){
						p1 = root.condtestcase_quantity.priority[i][1];
						} 
					else if(root.condtestcase_quantity.priority[i][0] == "P2"){
						p2 = root.condtestcase_quantity.priority[i][1];
						}  
					else if(root.condtestcase_quantity.priority[i][0] == "P3"){
						p3 = root.condtestcase_quantity.priority[i][1];
						} 
						}
					else if (root.condtestcase_quantity.priority[i] == null){
						break;
						}
				  	}
				 }
				 if (root.condtestcase_quantity.casetype != null){
				 for (i=0 ; i< 2 ;i++){
					if (root.condtestcase_quantity.casetype[i] != null){
						if(root.condtestcase_quantity.casetype[i][0] == "正例"){
						zhengli = root.condtestcase_quantity.casetype[i][1];
						} 
					else if(root.condtestcase_quantity.casetype[i][0] == "反例"){
						fanli = root.condtestcase_quantity.casetype[i][1];
						} 
						}
					else if (root.condtestcase_quantity.casetype[i] == null){
						break;
						}
				  	}
				 }
				 if (root.condtestcase_quantity.status != null){
				 for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.status[i] != null){
						if(root.condtestcase_quantity.status[i][0] == "自动"){
						zidong = root.condtestcase_quantity.status[i][1];
						} 
					else if(root.condtestcase_quantity.status[i][0] == "手动"){
						shoudong = root.condtestcase_quantity.status[i][1];
						}  
					else if(root.condtestcase_quantity.status[i][0] == "废弃"){
						feiqi = root.condtestcase_quantity.status[i][1];
						} 
						}
					else if (root.condtestcase_quantity.status[i] == null){
						break;
						}
				  	}
				 }
				 if (root.condtestcase_quantity.status != null){
				  for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.testcase_approval[i] != null){
						if(root.condtestcase_quantity.testcase_approval[i][0] == "待评审"){
						daipingshen = root.condtestcase_quantity.testcase_approval[i][1];
						} 
					else if(root.condtestcase_quantity.testcase_approval[i][0] == "通过"){
						tongguo = root.condtestcase_quantity.testcase_approval[i][1];
						}  
					else if(root.condtestcase_quantity.testcase_approval[i][0] == "不通过"){
						butongguo = root.condtestcase_quantity.testcase_approval[i][1];
						} 
						}
					else if (root.condtestcase_quantity.testcase_approval[i] == null){
						break;
						}
				  	}
				 }
				  var queryTestSuiteResult = "";
				  queryTestSuiteResult += "<table border='1' width='100%'><tr><td colspan='3'>自动化实现</td><td colspan='3'>优先级</td><td colspan='3'>用例评审</td><td colspan='2'>正反例</td></tr>";
				  queryTestSuiteResult += "<tr><td>已实现</td><td>手动</td><td>废弃</td><td>P1</td><td>P2</td><td>P3</td><td>待审批</td><td>通过</td><td>未通过</td><td>正例</td><td>反例</td>";
				  queryTestSuiteResult += "<tr><td>"+ zidong+"</td><td>"+shoudong+"</td><td>"+feiqi+"</td><td>"+p1+"</td><td>"+p2+"</td><td>"+p3+"</td><td>"+daipingshen+"</td><td>"+tongguo+"</td><td>"+butongguo+"</td><td>"+zhengli+"</td><td>"+fanli+"</td></tr></table>";
				  $("#testsuiteInfoDiv").append(queryTestSuiteResult);
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
		interfacetestsuite = ref.get_node(sel).text;
		document.getElementById('showtestsuite_name').value = interfacetestsuite;
		document.getElementById('sutCaseInfoTd').style.display = "none";
		document.getElementById('interfacesearchTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "block";
		document.getElementById('showTestCaseTd').style.display = "none";
		}
		else if (type.type == "testcase"){
		initype();
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
				  isSelf =  root.isSelf;
				  document.getElementById('showtestcase_id').value = root.testcasedto.id;
				  document.getElementById('showcasepriority').value = root.testcasedto.priority;
				  document.getElementById('showcasestatus').value = root.testcasedto.status;
				  document.getElementById('showcasetype').value = root.testcasedto.casetype;
				  document.getElementById('showcasedescription').value = root.testcasedto.description;
				  document.getElementById('showcasesteps').value = root.testcasedto.casesteps;
				  document.getElementById('showapproval').value = root.testcasedto.testcase_approval;
				  document.getElementById('showproject').value = root.testcasedto.testcaseproject.name;
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
		document.getElementById('sutCaseInfoTd').style.display = "none";
	    document.getElementById('interfacesearchTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "block";
		}
		else if (type.type == "interfacetestsuite"){
		initype();
		document.getElementById('sutCaseInfoTd').style.display = "none";
		document.getElementById('interfacesearchTd').style.display = "block";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "none";
		
		}
		else {
		initype();
		document.getElementById('sutCaseInfoTd').style.display = "block";
		document.getElementById('interfacesearchTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "none";
		document.getElementById('showTestCaseTd').style.display = "none";
		querySutCaseInfo();
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
	

function initype(){
	$("#sutCaseInfoDiv").html("");
	$("#testsuiteInfoDiv").html("");
	$("#interfaceSearchResultDiv").html("");
	document.getElementById('showtestsuite_name').readOnly = true;
	document.getElementById('showtestsuite_description').readOnly = true;
	document.getElementById('showversion').readOnly = true;
	document.getElementById('showisdiscardtd').style.display = "block";
	document.getElementById('showisdiscardoption').style.display = "none";
	document.getElementById('showversiontd').style.display = "block";
	document.getElementById('showversionoption').style.display = "none";	
	document.getElementById('upTestSuite').style.display = "block";
	document.getElementById('saveTestSuite').style.display = "none";
	document.getElementById('showtestcase_name').readOnly = true;
	document.getElementById('showcaseprioritytd').style.display = "block";
	document.getElementById('showcasepriorityoption').style.display = "none";
	document.getElementById('showcasestatustd').style.display = "block";
	document.getElementById('showcasestatusoption').style.display = "none";
	document.getElementById('showcasetypetd').style.display = "block";
	document.getElementById('showcasetypeoption').style.display = "none";
	document.getElementById('showprojecttd').style.display = "block";
	document.getElementById('showprojectoption').style.display = "none";
	document.getElementById('showcasedescription').readOnly = true;
	document.getElementById('showcasesteps').readOnly = true;	
	document.getElementById('upTestCase').style.display = "block";
	document.getElementById('saveTestCase').style.display = "none";
	document.getElementById('showapprovaltd').style.display = "block";
	document.getElementById('showaprovaloption').style.display = "none";
	document.getElementById('showapprovalupdatetd').style.display = "block";
	document.getElementById('showapprovalsavetd').style.display = "none";
	};



function querySutCaseInfo(){
	$.ajax({
			  type : "POST",
			  url : "querySutQuantitys.action",
			  cache : false,
			  data : {sut_name:'<%=sut_name%>'},
			  dataType : "json",
			  success : function(root) {
				 var p1 = "0";
				 var p2 = "0";
				 var p3 = "0";
				 if (root.condtestcase_quantity.priority != null){
				 for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.priority[i] != null){
						if(root.condtestcase_quantity.priority[i][0] == "P1"){
						p1 = root.condtestcase_quantity.priority[i][1];
						} 
					else if(root.condtestcase_quantity.priority[i][0] == "P2"){
						p2 = root.condtestcase_quantity.priority[i][1];
						}  
					else if(root.condtestcase_quantity.priority[i][0] == "P3"){
						p3 = root.condtestcase_quantity.priority[i][1];
						} 
						}
					else if (root.condtestcase_quantity.priority[i] == null){
						break;
						}
				  	}
				 }
					
				 var zhengli = "0";
				 var fanli = "0";
				 if (root.condtestcase_quantity.casetype != null){
				 for (i=0 ; i< 2 ;i++){
					if (root.condtestcase_quantity.casetype[i] != null){
						if(root.condtestcase_quantity.casetype[i][0] == "正例"){
						zhengli = root.condtestcase_quantity.casetype[i][1];
						} 
					else if(root.condtestcase_quantity.casetype[i][0] == "反例"){
						fanli = root.condtestcase_quantity.casetype[i][1];
						} 
						}
					else if (root.condtestcase_quantity.casetype[i] == null){
						break;
						}
				  	}
				 }
					
				 var zidong = "0";
				 var shoudong = "0";
				 var feiqi = "0";
				 if (root.condtestcase_quantity.status != null){
				 for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.status[i] != null){
						if(root.condtestcase_quantity.status[i][0] == "自动"){
						zidong = root.condtestcase_quantity.status[i][1];
						} 
					else if(root.condtestcase_quantity.status[i][0] == "手动"){
						shoudong = root.condtestcase_quantity.status[i][1];
						}  
					else if(root.condtestcase_quantity.status[i][0] == "废弃"){
						feiqi = root.condtestcase_quantity.status[i][1];
						} 
						}
					else if (root.condtestcase_quantity.status[i] == null){
						break;
						}
				  	}
				 }
					
				 var daipingshen = "0";
				 var tongguo = "0";
				 var butongguo = "0";
				 if (root.condtestcase_quantity.testcase_approval != null){
				  for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.testcase_approval[i] != null){
						if(root.condtestcase_quantity.testcase_approval[i][0] == "待评审"){
						daipingshen = root.condtestcase_quantity.testcase_approval[i][1];
						} 
					else if(root.condtestcase_quantity.testcase_approval[i][0] == "通过"){
						tongguo = root.condtestcase_quantity.testcase_approval[i][1];
						}  
					else if(root.condtestcase_quantity.testcase_approval[i][0] == "不通过"){
						butongguo = root.condtestcase_quantity.testcase_approval[i][1];
						} 
						}
					else if (root.condtestcase_quantity.testcase_approval[i] == null){
						break;
						}
				  	}
				 }
					
				  var queryTestSuiteResult = "";
				  queryTestSuiteResult += "<table border='1' width='100%'><tr><td colspan='5'>接口总数</td><td colspan='6'>"+root.testsuite_quantity+"</td></tr>";
				  queryTestSuiteResult += "<tr><td colspan='5'>案例总数</td><td colspan='6'>"+root.testcase_quantity+"</td></tr>"
				  queryTestSuiteResult += "<tr><td colspan='3'>自动化实现</td><td colspan='3'>优先级</td><td colspan='3'>用例评审</td><td colspan='2'>正反例</td></tr>";
				  queryTestSuiteResult += "<tr><td>已实现</td><td>手动</td><td>废弃</td><td>P1</td><td>P2</td><td>P3</td><td>待审批</td><td>通过</td><td>未通过</td><td>正例</td><td>反例</td>";
				  queryTestSuiteResult += "<tr><td>"+ zidong+"</td><td>"+shoudong+"</td><td>"+feiqi+"</td><td>"+p1+"</td><td>"+p2+"</td><td>"+p3+"</td><td>"+daipingshen+"</td><td>"+tongguo+"</td><td>"+butongguo+"</td><td>"+zhengli+"</td><td>"+fanli+"</td></tr></table>";
				  $("#sutCaseInfoDiv").append(queryTestSuiteResult);
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	};
function queryinterfaceac(){
	initype();
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
				  var searchresultdata;
				  searchresultdata = "<h1>此次搜索共匹配"+ root.testcase_quantity +"条记录</h1>";
				  $("#interfaceSearchResultDiv").append(searchresultdata);
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

function updateapprovalac(){
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else if (isSelf == "true"){
		alert("本人无法进行评审，请邀请他人进行评审！");
	}
	else if (isSelf == "false"){
	document.getElementById('showapprovaltd').style.display = "none";
	document.getElementById('showaprovaloption').style.display = "block";
	document.getElementById('showapprovalupdatetd').style.display = "none";
	document.getElementById('showapprovalsavetd').style.display = "block";
	}
		
}

function saveapprovalac(){
	var approval_value;
	  approval_radio = document.getElementsByName('updateapproval');
	  for(i=0;i<approval_radio.length;i++){  
	  	if(approval_radio[i].checked){
	    	approval_value = approval_radio[i].value;
	  	}
	  };
	var sut_name = '<%=sut_name%>';
	var tsparams = {testcase_name:$("#showtestcase_name").val(),sut_name:sut_name,testcase_id:$("#showtestcase_id").val(),testsuite_name:$("#showcasetestsuite_name").val(),description:$("#showcasedescription").val(),priority:$("#showcasepriority").val(),status:$("#showcasestatus").val(),casetype:$("#showcasetype").val(),casesteps:$("#showcasesteps").val(),testcase_approval:approval_value,project_name:$("#updateproject").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $('#jstree').jstree(true).destroy();
				  initree();  
				  initype();
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  querySutCaseInfo();
				  
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	  
	  
	  
	  
}




  $(document).ready( function(){
	  initree();
	  querySutCaseInfo();
	$("#versiongroup").jQSelect({});
	$("#updateversiongroup").jQSelect({});
	$("#projectgroup").jQSelect({});
	$("#updateprojectgroup").jQSelect({});
	$("#showTestSuiteForm").validate({
			rules : {
				"showtestsuite_name" : {
					required : true,
					maxlength : 15
				},
				"showtestsuite_description" : {
					required : true,
					maxlength : 50
				}
			},
			messages : {
				"showtestsuite_name" : {
					required : "请输入TestSuiteName",
					maxlength : $.validator.format("TestSuiteName最大输入不超过十五个字符.")
				},
				"showtestsuite_description" : {
					required : "请输入TestSuite描述",
					maxlength : $.validator.format("TestSuite描述最大输入不超过五十个字符.")
				}
			}
		});
	 $("#showTestCaseForm").validate({
			rules : {
				"showtestcase_name" : {
					required : true,
					maxlength : 15
				},
				"showcasedescription" : {
					required : true,
					maxlength : 50
				},
				"showcasesteps" : {
					required : true,
					maxlength : 150
				},
			},
			messages : {
				"showtestcase_name" : {
					required : "请输入用例名称",
					maxlength : $.validator.format("用例名称最大输入不超过十五个字符.")
				},
				"showcasedescription" : {
					required : "请输入用例详细描述",
					maxlength : $.validator.format("用例详细描述最大输入不超过五十个字符.")
				},
				"showcasesteps" : {
					required : "请输入用例步骤",
					maxlength : $.validator.format("用例步骤最大输入不超过一百五十个字符.")
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
      <!--左边Tree-->
      <td width="25%"><div style="height:600px;overflow:scroll;overflow-x:hidden;">
          <div>
            <input type="text" id="plugins4_q" value="" class="input" style="display:block; padding:4px; border-radius:4px; border:1px solid silver;">
          </div>
          <div>
            <button type="button" class="btn btn-success btn-sm" onclick="demo_create();"><i class="glyphicon glyphicon-asterisk"></i>Create</button>
          </div>
          <div id="jstree"></div>
          <div id="event_result" style="margin-top:2em; text-align:left;">hhhhh&nbsp;</div>
        </div></td>
      <!--About SUT-->
      <td width="100%" id="sutCaseInfoTd" style="display:block;"><div id="sutCaseInfoDiv" style="text-align:center"></div></td>
      <!--Interface Search-->
      <td width="100%" id="interfacesearchTd" style="display:none;" ><table border="1">
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
        <div id="interfaceSearchResultDiv" style="text-align:center"> </div></td>
      <!--展示、更新testsuite-->
      <td width="100%" style="display:none" id="showTestSuiteTd"><form id="showTestSuiteForm" name="showTestSuiteForm">
          <table width="100%">
            <tr>
              <td><label for="showtestsuite_name">TestSuiteName</label></td>
              <td><input id="showtestsuite_name" name="showtestsuite_name" value="" readonly></td>
            </tr>
            <tr>
              <td colspan="2"><input id="showtestsuite_id" name="showtestsuite_id" value="" style="display:block" readonly></td>
            </tr>
            <tr>
              <td><label for="showsut_name">所属系统</label></td>
              <td><input id="showsut_name" name="showsut_name" value="<%=sut_name%>" readonly></td>
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
              <td><textarea  rows="4" name="showtestsuite_description" class="input-xlarge" readonly id="showtestsuite_description" style="max-height:50px; max-width:200px; width:200px; height:50px;"></textarea></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestSuiteac()" id="upTestSuite" name="upTestSuite" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestSuiteac()" id="saveTestSuite" name="saveTestSuite" style="display:none">保存</button></td>
            </tr>
          </table>
        </form>
        <div id="testsuiteInfoDiv" style="text-align:center"> </div></td>
        </td>
      <!--展示更新testcase-->
      <td width="100%" style="display:none" id="showTestCaseTd"><form id="showTestCaseForm" name="showTestCaseForm">
          <table width="100%" border="1" id="showcaseinfo">
            <tr>
              <td colspan="2" style="text-align:center">用例详情</td>
            </tr>
            <tr>
              <td><label for="showtestcase_name">TestCaseName</label></td>
              <td><input id="showtestcase_name" name="showtestcase_name" value="" readonly></td>
            </tr>
            <tr>
              <td colspan="2"><input id="showtestcase_id" name="showtestcase_id" value="" style="display:block" readonly></td>
            </tr>
            <tr>
              <td>所属TestSuite</td>
              <td><input id="showcasetestsuite_name" name="showcasetestsuite_name" value="" maxlength="15" readonly></td>
            </tr>
            <tr>
              <td>所属Project</td>
              <td id="showprojecttd" style="display:block"><input id="showproject" value="" readonly></td>
              <td id="showprojectoption" style="display:none"><div id="updateprojectgroup" class="selectbox">
                  <div class="cartes">
                    <input type="text" value="<%=testcaseprojects.get(0).getName()%>" id="updateproject" name="updateproject" class="listTxt" readonly />
                    <div class="listBtn"><b></b></div>
                    <input type="hidden" value="" class="listVal" />
                  </div>
                  <div class="lists">
                    <ul class="list">
                      <% for (int i =0; i<testcaseprojects.size(); i++){%>
                      <li id=<%=i%>><%=testcaseprojects.get(i).getName()%></li>
                      <%}%>
                    </ul>
                  </div>
                </div></td>
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
              <td>描述</td>
              <td><textarea  rows="4" name="showcasedescription" class="input-xlarge" id="showcasedescription" style="max-height:50px; max-width:200px; width:200px; height:50px;" readonly></textarea></td>
            </tr>
            <tr>
              <td>步骤</td>
              <td><textarea  rows="4" name="showcasesteps" class="input-xlarge" id="showcasesteps" style="max-height:150px; max-width:200px; width:200px; height:150px;" readonly></textarea></td>
            </tr>
            <tr>
              <td><button type="button" class="btn btn-default" onClick="updateTestCaseac()" id="upTestCase" name="upTestCase" style="display:block">更新</button></td>
              <td><button type="button" class="btn btn-default" onClick="saveTestCaseac()" id="saveTestCase" name="saveTestCase" style="display:none">保存</button></td>
            </tr>
          </table>
          <table id="showcasestatus" width="100%" border="1">
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
            <tr id="showaprovalbtntd">
              <td colspan="2" id="showapprovalupdatetd" style="display:block"><input type="button" value="开始评审" onClick="updateapprovalac()"></td>
              <td colspan="2" id="showapprovalsavetd" style="display:none"><input type="button" value="确认评审" onClick="saveapprovalac()"></td>
            </tr>
          </table>
        </form></td>
      <!--showcasechangehistory-->
      <td style="width:300px;"><div class="panel-group" id="accordion">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"> <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"> Collapsible Group Item #1 </a> </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse in">
              <div class="panel-body"> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. </div>
            </div>
          </div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"> <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"> Collapsible Group Item #2 </a> </h4>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse">
              <div class="panel-body"> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. </div>
            </div>
          </div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"> <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseThree"> Collapsible Group Item #3 </a> </h4>
            </div>
            <div id="collapseThree" class="panel-collapse collapse">
              <div class="panel-body"> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. </div>
            </div>
          </div>
        </div></td>
    </tr>
  </table>
  <!--隐藏表单创建testsuite-->
  <div id="createTestSuite" style="display:none">
    <form>
      <table width="500" height="150" style="background:#FFF">
        <tr>
          <td><label for="testsuite_name">TestSuiteName</label></td>
          <td><input value="Ts_" size="3" readonly style="text-align:right; width:20px">
            <input id="testsuite_name" name="testsuite_name" value=""></td>
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
          <td><input id="pre_stname" name="pre_stname" value="" style="text-align:right" readonly>
            <input id="testcase_name" name="testcase_name" value="" maxlength="15"></td>
        </tr>
        <tr>
          <td colspan="2"><input id="casesut_name" style="display:none" name="sut_name" value="<%=sut_name%>"></td>
        </tr>
        <tr>
          <td>所属TestSuite</td>
          <td><input id="casetestsuite_name" name="testsuite_name" value="" maxlength="15" readonly></td>
        </tr>
        <tr>
          <td>所属Project</td>
          <td><div id="projectgroup" class="selectbox">
              <div class="cartes">
                <input type="text" value="<%=testcaseprojects.get(0).getName()%>" id="project" name="project" class="listTxt" readonly />
                <div class="listBtn"><b></b></div>
                <input type="hidden" value="" class="listVal" />
              </div>
              <div class="lists">
                <ul class="list">
                  <% for (int i =0; i<testcaseprojects.size(); i++){%>
                  <li id=<%=i%>><%=testcaseprojects.get(i).getName()%></li>
                  <%}%>
                </ul>
              </div>
            </div></td>
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