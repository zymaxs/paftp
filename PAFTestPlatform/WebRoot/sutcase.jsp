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
Sut sut  = (Sut)request.getAttribute("sut");
String sut_name = sut.getName();
String sut_id = request.getAttribute("sut_id").toString();
String isCurrentRole;
if (String.valueOf(request.getAttribute("isCurrentRole")) == "true"){
	isCurrentRole = "y";
}
else { isCurrentRole = "n";};
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
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
<script language="javascript">
function quanjiao(obj)
{
    var str=obj.value;
    if (str.length>0)
    {
        for (var i = str.length-1; i >= 0; i--)
        {
            unicode=str.charCodeAt(i);
            if (unicode>65280 && unicode<65375)
            {
                alert("不能输入全角字符，请输入半角字符");
                obj.value=str.substr(0,i);
            }
        }
    }
}
</script>
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
	$("#testsuite_description").val('');
	var diag = new Dialog();
	diag.Width = 500;
	diag.Height = 200;
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
					diag.close();
					newTestSuiteac();
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
								   $("#jstree").jstree("destroy");
				  				   initree();
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
	$("#description").val('');
	$("#casesteps").val('');
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
					else if ( topWin.$id('testcase_name').value.length > 50){
					Dialog.alert("用例名称不能超过50个字符");
						}
					else if (topWin.$id('description').value == ""){
					Dialog.alert("用例描述描述不能为空");	
						}
					else if ( topWin.$id('description').value.length > 150){
					Dialog.alert("用例描述不能超过150个字符");
						}
					else if (topWin.$id('casesteps').value == ""){
					Dialog.alert("用例步骤不能为空");	
						}
					else if (topWin.$id('casesteps').value.length > 1000 ){
					Dialog.alert("用例步骤不能超过1000个字符");
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
								   $("#jstree").jstree("destroy");
				  				   initree();
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
var node_id = "";

function demo_refresh(){
$("#jstree").jstree("destroy");
initree();
initype();
document.getElementById('sutCaseInfoTd').style.display = "block";
document.getElementById('interfacesearchTd').style.display = "none";
document.getElementById('showTestSuiteTd').style.display = "none";
document.getElementById('showTestCaseTd').style.display = "none";
querySutCaseInfo();
}


function demo_create() {
	if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
	if('<%=isCurrentRole%>' != "y"){
	alert("您目前权限不足，请向该项目经理去申请操作权限！")
	}
	else {
	  var ref = $('#jstree').jstree(true);
	  var	sel = ref.get_selected();
	  if(!sel.length) { return false; }
	  var type = ref.get_type(sel, true);
	  if (type.type != "sut"){
		  if(type.valid_children == "interfacetestcase"){
			  sel = ref.create_node(sel, {"type":type.valid_children[0]});
			  node_id = sel;
		  }
		  else{
			  sel = ref.create_node(sel, {"type":type.valid_children[0]});
		  }
		  if(sel) {
			  //alert(ref.get_node(sel).type);
			  if(ref.get_node(sel).type == "interfacetestcase"){
				  initype();
				  interfacetestsuite = ref.get_node(sel).text;
				  document.getElementById('testsuite_name').value = interfacetestsuite;
				  createTestSuite();
				  }
			  else if(ref.get_node(sel).type == "testcase"){
				  initype();
				  interfacetestcase = ref.get_node(sel).text;
				  document.getElementById('testcase_name').value = interfacetestcase;
				  var stname = ref.get_node(ref.get_parent(sel)).text;
				  var pre_stname = stname.replace("Ts","Tc")
				  $('#pre_stname').text(pre_stname +"_");
				  document.getElementById('casetestsuite_name').value = ref.get_node(ref.get_parent(sel)).text; 
				  createTestCase();
				  }
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
	  var testsuite_name;
	  testsuite_name = "Ts_" + $("#testsuite_name").val();
	  var tsparams = {testsuite_name:testsuite_name,sut_name:$("#sut_name").val(),testsuite_description:$("#testsuite_description").val(),isdiscard:"using",version:$("#version").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  }
					else {
				  $("#jstree").jstree("destroy");
				  datadata = root.jsonArray;
				  testtest();
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  querySutCaseInfo();
				  //alert("begin selectnode");
				  //sleepI(1);
					}
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
	if('<%=isCurrentRole%>' != "y"){
	alert("您目前权限不足，请向该项目经理去申请操作权限！")
	}
	else {
	document.getElementById('showtestsuite_name').readOnly = false;
	document.getElementById('showtestsuite_description').readOnly = false;
	document.getElementById('showversion').readOnly = false;
	document.getElementById('showisdiscardtd').style.display = "none";
	document.getElementById('showisdiscardoption').style.display = "block";
	document.getElementById('showversiontd').style.display = "none";
	document.getElementById('showversionoption').style.display = "block";	
	document.getElementById('upTestSuiteTd').style.display = "none";
	document.getElementById('saveTestSuiteTd').style.display = "block";
	}
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
	var testsuite_name = "Ts_" + $("#showtestsuite_name").val();
	var tsparams = {testsuite_name:testsuite_name,sut_name:$("#showsut_name").val(),testsuite_id:$("#showtestsuite_id").val(),testsuite_description:$("#showtestsuite_description").val(),isdiscard:isdiscard_value,version:$("#updateversion").val(),changetag:$("#showtestsuite_changetag").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  initype();
					  document.getElementById('sutCaseInfoTd').style.display = "block";
					  document.getElementById('interfacesearchTd').style.display = "none";
					  document.getElementById('showTestSuiteTd').style.display = "none";
					  document.getElementById('showTestCaseTd').style.display = "none";
					  querySutCaseInfo();
					  }
					else {
				  $("#jstree").jstree("destroy");
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
				  document.getElementById('upTestSuiteTd').style.display = "block";
				  document.getElementById('saveTestSuiteTd').style.display = "none";
				  querySutCaseInfo();
				  }
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
	  testcase_name = $("#pre_stname").text() + $("#testcase_name").val();
	  var tsparams = {testcase_name:testcase_name,sut_name:$("#casesut_name").val(),testsuite_name:$("#casetestsuite_name").val(),description:$("#description").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#casesteps").val(),testcase_approval:"待评审",project_name:$("#project").val(),version:$("#caseversion").val()};
	  $.ajax({
			  type : "POST",
			  url : "createTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  }
					else {
				  $("#jstree").jstree("destroy");
				  initree();
				  document.getElementById('sutCaseInfoTd').style.display = "block";
				  document.getElementById('interfacesearchTd').style.display = "none";
				  document.getElementById('showTestSuiteTd').style.display = "none";
				  document.getElementById('showTestCaseTd').style.display = "none";
				  querySutCaseInfo();
					}
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
		if('<%=isCurrentRole%>' != "y"){
		alert("您目前权限不足，请向该项目经理去申请操作权限！")
		}
		else {
			document.getElementById('showtestcase_name').readOnly = false;
			document.getElementById('showcaseprioritytd').style.display = "none";
			document.getElementById('showcasepriorityoption').style.display = "block";
			document.getElementById('showcasestatustd').style.display = "none";
			document.getElementById('showcasestatusoption').style.display = "block";
			document.getElementById('showcasetypetd').style.display = "none";
			document.getElementById('showcasetypeoption').style.display = "block";
			document.getElementById('showtestcase_versiontd').style.display = "none";
			document.getElementById('showtestcase_versionoption').style.display = "block";
			document.getElementById('showprojecttd').style.display = "none";
			document.getElementById('showprojectoption').style.display = "block";
			document.getElementById('showcasedescription').readOnly = false;
			document.getElementById('showcasesteps').readOnly = false;	
			document.getElementById('upTestCaseTd').style.display = "none";
			document.getElementById('saveTestCaseTd').style.display = "";
			}
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
	  var sut_name = '<%=sut_name%>';
	  var testcase_name = $('#pre_casename').text() + $("#showtestcase_name").val();
	  var tsparams = {testcase_name:testcase_name,sut_name:sut_name,testcase_id:$("#showtestcase_id").val(),testsuite_name:$("#showcasetestsuite_name").val(),description:$("#showcasedescription").val(),priority:priority_value,status:status_value,casetype:type_value,casesteps:$("#showcasesteps").val(),testcase_approval:approval_value,project_name:$("#updateproject").val(),changetag:$("#showtestcase_changetag").val(),version:$("#testcaseversion").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  initype();
					  document.getElementById('sutCaseInfoTd').style.display = "block";
					  document.getElementById('interfacesearchTd').style.display = "none";
					  document.getElementById('showTestSuiteTd').style.display = "none";
					  document.getElementById('showTestCaseTd').style.display = "none";
					  querySutCaseInfo();
					  }
					else {
				  $("#jstree").jstree("destroy");
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
				  document.getElementById('upTestCaseTd').style.display = "";
				  document.getElementById('saveTestCaseTd').style.display = "none";
				  document.getElementById('showtestcase_versiontd').style.display = "block";
				  document.getElementById('showtestcase_versionoption').style.display = "none";
					}
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	}
	};

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
		var stnameArray =  interfacetestsuite.split( "_" );
		var stprefixname = "Ts_";
		var stpostfixname = "";
		for (i=1;i< stnameArray.length ; i++){
			if ( i >=1 && i < (stnameArray.length-1) ){
			stpostfixname += stnameArray[i] + "_";
			}
			else {
			stpostfixname += stnameArray[i];
			}
			}
		document.getElementById('showtestsuite_name').value = stpostfixname;
		var testsuite_name = stprefixname + stpostfixname;
		tsparams = {testsuite_name:testsuite_name,sut_name:sut_name};
		$.ajax({
			  type : "POST",
			  url : "queryTestsuite.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  initype();
					  document.getElementById('sutCaseInfoTd').style.display = "block";
				      document.getElementById('interfacesearchTd').style.display = "none";
					  document.getElementById('showTestSuiteTd').style.display = "none";
					  document.getElementById('showTestCaseTd').style.display = "none";
					  querySutCaseInfo();
					  }
					else {
				 document.getElementById('showtestsuite_id').value = root.testsuitedto.id;
				 document.getElementById('showtestsuite_description').value = root.testsuitedto.description;
				 if (root.testsuitedto.status == "using"){
					 document.getElementById('showisdiscard').value = "正在使用";
					 }
					 else if (root.testsuitedto.status == "discard"){
						 document.getElementById('showisdiscard').value = "废弃";
						 }

				 document.getElementById('showtestsuite_changetag').value = root.changetag;
				 var obj_status = document.getElementsByName('updateisdiscard');
				  for (i=0 ; i < obj_status.length ; i++){
					  if(obj_status[i].value == root.testsuitedto.status){
						  obj_status[i].checked = true;
						  }
					  
					  };
				 document.getElementById('showversion').value = root.testsuitedto.version.versionNum;
				 document.getElementById('updateversion').value = root.testsuitedto.version.versionNum;
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
						if(root.condtestcase_quantity.priority[i].value == "P1"){
						p1 = root.condtestcase_quantity.priority[i].count;
						} 
					else if(root.condtestcase_quantity.priority[i].value == "P2"){
						p2 = root.condtestcase_quantity.priority[i].count;
						}  
					else if(root.condtestcase_quantity.priority[i].value == "P3"){
						p3 = root.condtestcase_quantity.priority[i].count;
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
						if(root.condtestcase_quantity.casetype[i].value == "正例"){
						zhengli = root.condtestcase_quantity.casetype[i].count;
						} 
					else if(root.condtestcase_quantity.casetype[i].value == "反例"){
						fanli = root.condtestcase_quantity.casetype[i].count;
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
						if(root.condtestcase_quantity.status[i].value == "自动"){
						zidong = root.condtestcase_quantity.status[i].count;
						} 
					else if(root.condtestcase_quantity.status[i].value == "手动"){
						shoudong = root.condtestcase_quantity.status[i].count;
						}  
					else if(root.condtestcase_quantity.status[i].value == "废弃"){
						feiqi = root.condtestcase_quantity.status[i].count;
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
						if(root.condtestcase_quantity.testcase_approval[i].value == "待评审"){
						daipingshen = root.condtestcase_quantity.testcase_approval[i].count;
						} 
					else if(root.condtestcase_quantity.testcase_approval[i].value == "通过"){
						tongguo = root.condtestcase_quantity.testcase_approval[i].count;
						}  
					else if(root.condtestcase_quantity.testcase_approval[i].value == "未通过"){
						butongguo = root.condtestcase_quantity.testcase_approval[i].count;
						} 
						}
					else if (root.condtestcase_quantity.testcase_approval[i] == null){
						break;
						}
				  	}
				 }
				  var queryTestSuiteResult = "";
				  queryTestSuiteResult += "<table width='100%' class='table  table-bordered'><tr><td colspan='3'>自动化实现</td><td colspan='3'>优先级</td><td colspan='3'>用例评审</td><td colspan='2'>正/反例</td></tr>";
				  queryTestSuiteResult += "<tr><td>已实现</td><td>手动</td><td>废弃</td><td>P1</td><td>P2</td><td>P3</td><td>待审批</td><td>通过</td><td>未通过</td><td>正例</td><td>反例</td></tr>";
				  queryTestSuiteResult += "<tr><td>"+ zidong+"</td><td>"+shoudong+"</td><td>"+feiqi+"</td><td>"+p1+"</td><td>"+p2+"</td><td>"+p3+"</td><td>"+daipingshen+"</td><td>"+tongguo+"</td><td>"+butongguo+"</td><td>"+zhengli+"</td><td>"+fanli+"</td></tr></table>";
				   if (document.getElementById("testsuiteInfoDiv").innerHTML.toString()==""){
				  $("#testsuiteInfoDiv").append(queryTestSuiteResult);
				   }
				}
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
		document.getElementById('sutCaseInfoTd').style.display = "none";
		document.getElementById('interfacesearchTd').style.display = "none";
		document.getElementById('showTestSuiteTd').style.display = "block";
		document.getElementById('showTestCaseTd').style.display = "none";
		}
		else if (type.type == "testcase"){
		initype();
		interfacetestcase = ref.get_node(sel).text;
		var caseprefixname = "Tc_" + (ref.get_node(ref.get_parent(sel)).text).substring(3) + "_";
		$('#pre_casename').text(caseprefixname);
		//document.getElementById('pre_casename').value = caseprefixname;
		var casepostfixname = interfacetestcase.replace(caseprefixname,"");
		document.getElementById('showtestcase_name').value = casepostfixname;
		document.getElementById('showcasetestsuite_name').value = ref.get_node(ref.get_parent(sel)).text;
		var testcase_name = caseprefixname + casepostfixname;
		tsparams = {testcase_name:testcase_name,sut_name:sut_name,testsuite_name:$("#showcasetestsuite_name").val()};
		$.ajax({
			  type : "POST",
			  url : "queryTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  if ( root.prompt != null){
					  alert(root.prompt);
					  $("#jstree").jstree("destroy");
					  initree();
					  initype();
					  document.getElementById('sutCaseInfoTd').style.display = "block";
					  document.getElementById('interfacesearchTd').style.display = "none";
					  document.getElementById('showTestSuiteTd').style.display = "none";
					  document.getElementById('showTestCaseTd').style.display = "none";
					  querySutCaseInfo();
					  }
					else {
				  isSelf =  root.isSelf;
				  document.getElementById('showtestcase_id').value = root.testcasedto.id;
				  document.getElementById('showcasepriority').value = root.testcasedto.priority;
				  document.getElementById('showtestcasecreattime').value = root.testcasedto.createTime;
				  document.getElementById('showtestcase_changetag').value = root.changetag;  
				  var creator_name = "<a href='getuserinfo.action?userid="+root.testcasedto.creator.id+"'>"+root.testcasedto.creator.displayName+"</a>";
				  if (document.getElementById("showtestcasecreator").innerHTML.toString()==""){
				  $("#showtestcasecreator").append(creator_name);
				  }
				  var obj_priority = document.getElementsByName('updatepriority');
				  for (i=0 ; i < obj_priority.length ; i++){
					  if(obj_priority[i].value == root.testcasedto.priority){
						  obj_priority[i].checked = true;
						  }
					  
					  };
				  
				  document.getElementById('showtestcase_version').value = root.testcasedto.version.versionNum;
				  var ojb_version = document.getElementById('testcaseversion');
				  for(i=0; i<ojb_version.options.length; i++){  
					    if(ojb_version.options[i].innerHTML == root.testcasedto.version.versionNum){  
					    	ojb_version.options[i].selected = true;  
					    }  
					}  
					  
					  
					  
				  document.getElementById('showcasestatus').value = root.testcasedto.status;
				  var obj_status = document.getElementsByName('updatestatus');
				  for (i=0 ; i < obj_status.length ; i++){
					  if(obj_status[i].value == root.testcasedto.status){
						  obj_status[i].checked = true;
						  }
					  
					  };
				  document.getElementById('showcasetype').value = root.testcasedto.casetype;
				  var obj_type = document.getElementsByName('updatetype');
				  for (i=0 ; i < obj_type.length ; i++){
					  if(obj_type[i].value == root.testcasedto.casetype){
						  obj_type[i].checked = true;
						  }
					  
					  };
				  document.getElementById('showapproval').value = root.testcasedto.testcase_approval;
				  var obj_approval = document.getElementsByName('updateapproval');
				  for (i=0 ; i < obj_approval.length ; i++){
					  if(obj_approval[i].value == root.testcasedto.testcase_approval){
						  obj_approval[i].checked = true;
						  }
					  
					  };
				  if (root.testcasedto.testcase_approval == "未通过"){
					  document.getElementById('approval_commentsTd').style.display = "";
					  document.getElementById('approval_comments').value = root.testcasedto.approval_comments;
					  }
				  document.getElementById('showcasedescription').value = root.testcasedto.description;
				  document.getElementById('showcasesteps').value = root.testcasedto.casesteps;
				  document.getElementById('showproject').value = root.testcasedto.testcaseproject.name;
				  document.getElementById('updateproject').value = root.testcasedto.testcaseproject.name;
				  //显示History
				  var caseChangeHistory="";
				  var historylength = root.testcasedto.caseChangeHistorys.length;
				  for (i=0 ; i< historylength ;i++){
					  caseChangeHistory += "<p><a href='#casechange"+ i +"' data-toggle='collapse'>" + root.testcasedto.caseChangeHistorys[i].update_time +"</a>&nbsp;&nbsp;By&nbsp;&nbsp;<a href='getuserinfo.action?userid="+ root.testcasedto.caseChangeHistorys[i].updator.id+"'>"+root.testcasedto.caseChangeHistorys[i].updator.displayName+"</a></p>";
				 	  caseChangeHistory += "<div id='casechange"+ i +"' class='collapse'>";
					  caseChangeHistory += "<table class='table table-striped'><tr><td>修改项</td><td>修改前</td><td>修改后</td></tr>";
					  var operationlength = root.testcasedto.caseChangeHistorys[i].caseChangeOperations.length;
					  for (j=0 ; j< operationlength ; j++){
						  var oldValue = root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].oldValue;
						  var newValue = root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].newValue;
						  if (oldValue.length > 5 || newValue.length > 5){
							  caseChangeHistory += "<tr><td>" + root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].field + "</td>";
							  caseChangeHistory += "<td><a href='#' title='"+oldValue+"'>"+oldValue.substring(0,3)+"...</a></td>";
							  caseChangeHistory += "<td><a href='#' title='"+newValue+"'>"+newValue.substring(0,3)+"...</a></td></tr>";
							  }
						  else{
							caseChangeHistory += "<tr><td>" + root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].field + "</td>";
						    caseChangeHistory += "<td>" + root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].oldValue + "</td>";
						    caseChangeHistory += "<td>" + root.testcasedto.caseChangeHistorys[i].caseChangeOperations[j].newValue + "</td></tr>"}
						  }
					  caseChangeHistory += "</table></div>";
					  }
					 if (document.getElementById("showCaseChangeHistoryDiv").innerHTML.toString() == ""){
					$("#showCaseChangeHistoryDiv").append(caseChangeHistory);
					 }
					}	  
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
				 "icon":"glyphicon glyphicon-th",
				"valid_firstchildren" : ["interfacetestsuite"],
				"valid_secondchildren" : ["stresstestsuite"]
			  },
			  "interfacetestsuite" : {
				  "icon":"glyphicon glyphicon-th-list",
				"valid_children" : ["interfacetestcase"]
			  },
			  "stresstestsuite" : {
				  "valid_children" : ["stresstestcase"]
			  },
			  "interfacetestcase" : {
				  "icon":"glyphicon glyphicon-book",
				  "valid_children": ["testcase"]
			  },
			  "stresstestcase" : {
			    "icon":"glyphicon glyphicon-book",
				"valid_children" : []
			  },
			  "testcase":{
				  "icon":"glyphicon glyphicon-file",
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
				  //sleepI(1);
				  //rootnode();
				  //alert("after select");
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
	};
	
 var flag=""
    function sleepI(n)
    {
       flag = window.setInterval("c()",1000*n); 
    }
    
    function c(){rootnode();window.clearInterval(flag);}



function initype(){
	$("#sutCaseInfoDiv").html("");
	$("#testsuiteInfoDiv").html("");
	$("#showtestcasecreator").html("");
	$("#interfaceSearchResultDiv").html("");
	$("#showCaseChangeHistoryDiv").html("");
	document.getElementById('showtestsuite_name').readOnly = true;
	document.getElementById('showtestsuite_description').readOnly = true;
	document.getElementById('showversion').readOnly = true;
	document.getElementById('showisdiscardtd').style.display = "block";
	document.getElementById('showisdiscardoption').style.display = "none";
	document.getElementById('showversiontd').style.display = "block";
	document.getElementById('showversionoption').style.display = "none";	
	document.getElementById('upTestSuiteTd').style.display = "block";
	document.getElementById('saveTestSuiteTd').style.display = "none";
	document.getElementById('showtestcase_name').readOnly = true;
	document.getElementById('showcaseprioritytd').style.display = "block";
	document.getElementById('showtestcase_versiontd').style.display = "block";
	document.getElementById('showtestcase_versionoption').style.display = "none";
	document.getElementById('showcasepriorityoption').style.display = "none";
	document.getElementById('showcasestatustd').style.display = "block";
	document.getElementById('showcasestatusoption').style.display = "none";
	document.getElementById('showcasetypetd').style.display = "block";
	document.getElementById('showcasetypeoption').style.display = "none";
	document.getElementById('showprojecttd').style.display = "block";
	document.getElementById('showprojectoption').style.display = "none";
	document.getElementById('showcasedescription').readOnly = true;
	document.getElementById('showcasesteps').readOnly = true;	
	document.getElementById('upTestCaseTd').style.display = "";
	document.getElementById('saveTestCaseTd').style.display = "none";
	document.getElementById('showapprovaltd').style.display = "block";
	document.getElementById('showaprovaloption').style.display = "none";
	document.getElementById('showapprovalupdatetd').style.display = "";
	document.getElementById('showapprovalsavetd').style.display = "none";
	document.getElementsByName('priority')[0].checked = true;
	document.getElementsByName('status')[0].checked = true;
	document.getElementsByName('type')[0].checked = true;
	document.getElementById('approval_commentsTd').style.display = "none";
	document.getElementById('approval_comments').readOnly = true;
	};



function querySutCaseInfo(){
	$.ajax({
			  type : "POST",
			  url : "querySutQuantitys.action",
			  cache : false,
			  data : {sut_name:'<%=sut_name%>'},
			  dataType : "json",
			  success : function(root) {
				 initype();
				 var p1 = "0";
				 var p2 = "0";
				 var p3 = "0";
				 if (root.condtestcase_quantity.priority != null){
				 for (i=0 ; i< 3 ;i++){
					if (root.condtestcase_quantity.priority[i] != null){
						if(root.condtestcase_quantity.priority[i].value == "P1"){
						p1 = root.condtestcase_quantity.priority[i].count;
						} 
					else if(root.condtestcase_quantity.priority[i].value == "P2"){
						p2 = root.condtestcase_quantity.priority[i].count;
						}  
					else if(root.condtestcase_quantity.priority[i].value == "P3"){
						p3 = root.condtestcase_quantity.priority[i].count;
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
						if(root.condtestcase_quantity.casetype[i].value == "正例"){
						zhengli = root.condtestcase_quantity.casetype[i].count;
						} 
					else if(root.condtestcase_quantity.casetype[i].value == "反例"){
						fanli = root.condtestcase_quantity.casetype[i].count;
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
						if(root.condtestcase_quantity.status[i].value == "自动"){
						zidong = root.condtestcase_quantity.status[i].count;
						} 
					else if(root.condtestcase_quantity.status[i].value == "手动"){
						shoudong = root.condtestcase_quantity.status[i].count;
						}  
					else if(root.condtestcase_quantity.status[i].value == "废弃"){
						feiqi = root.condtestcase_quantity.status[i].count;
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
						if(root.condtestcase_quantity.testcase_approval[i].value == "待评审"){
						daipingshen = root.condtestcase_quantity.testcase_approval[i].count;
						} 
					else if(root.condtestcase_quantity.testcase_approval[i].value == "通过"){
						tongguo = root.condtestcase_quantity.testcase_approval[i].count;
						}  
					else if(root.condtestcase_quantity.testcase_approval[i].value == "未通过"){
						butongguo = root.condtestcase_quantity.testcase_approval[i].count;
						} 
						}
					else if (root.condtestcase_quantity.testcase_approval[i] == null){
						break;
						}
				  	}
				 }
					
				  var queryTestSuiteResult = "";
				  queryTestSuiteResult += "<table class='table table-bordered' width='100%'><tr><td colspan='5'>接口总数</td><td colspan='6'>"+root.testsuite_quantity+"</td></tr>";
				  queryTestSuiteResult += "<tr><td colspan='5'>案例总数</td><td colspan='6'>"+root.testcase_quantity+"</td></tr>"
				  queryTestSuiteResult += "<tr><td colspan='3'>自动化实现</td><td colspan='3'>优先级</td><td colspan='3'>用例评审</td><td colspan='2'>正/反例</td></tr>";
				  queryTestSuiteResult += "<tr><td>已实现</td><td>手动</td><td>废弃</td><td>P1</td><td>P2</td><td>P3</td><td>待审批</td><td>通过</td><td>未通过</td><td>正例</td><td>反例</td></tr>";
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
	var queryproject = $("#queryproject").val();
	var queryversion = $("#queryversion").val();
	var queryparams = {status:querystatus,priority:querypriority,casetype:querytype,testcase_approval:queryapproval,project_name:queryproject,version:queryversion,sut_name:'<%=sut_name%>'};
	$.ajax({
			  type : "POST",
			  url : "queryCombineConditions.action",
			  data : queryparams,
			  dataType : "json",
			  success : function(root) {
				  var searchresultdata;
				  searchresultdata = "<h1>此次搜索共匹配"+ root.testcase_quantity +"条记录</h1>";
				  $("#interfaceSearchResultDiv").append(searchresultdata);
				  $("#jstree").jstree("destroy");
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
		if('<%=isCurrentRole%>' != "y"){
		alert("您目前权限不足，请向该项目经理去申请操作权限！")
		}
		else {
			document.getElementById('showapprovaltd').style.display = "none";
			document.getElementById('showaprovaloption').style.display = "block";
			document.getElementById('showapprovalupdatetd').style.display = "none";
			document.getElementById('showapprovalsavetd').style.display = "";
			document.getElementById('approval_comments').readOnly = false;
		}
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
	var testcase_name = $("#pre_casename").text() + $("#showtestcase_name").val();
	var tsparams = {testcase_name:testcase_name,sut_name:sut_name,testcase_id:$("#showtestcase_id").val(),testsuite_name:$("#showcasetestsuite_name").val(),description:$("#showcasedescription").val(),priority:$("#showcasepriority").val(),status:$("#showcasestatus").val(),casetype:$("#showcasetype").val(),casesteps:$("#showcasesteps").val(),testcase_approval:approval_value,project_name:$("#updateproject").val(),approval_comments:$("#approval_comments").val(),changetag:$("#showtestcase_changetag").val(),version:$("#testcaseversion").val()};
	  $.ajax({
			  type : "POST",
			  url : "updateTestcase.action",
			  cache : false,
			  data : tsparams,
			  dataType : "json",
			  success : function(root) {
				  $("#jstree").jstree("destroy");
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
	//$("#jstree").jstree("destroy");
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
					maxlength : 50
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
					maxlength : 50
				},
				"showcasedescription" : {
					required : true,
					maxlength : 150
				},
				"showcasesteps" : {
					required : true,
					maxlength : 1000
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
					maxlength : $.validator.format("用例步骤最大输入不超过一千个字符.")
				}
			}
		});
		
		$('button').on('click', function () {
			//alert("botton");
			// $("#jstree").jstree("destroy");
			$("#jstree").jstree("destroy");
			initree();
			//sleepI(2);
	  		//$('#jstree').jstree(true).select_node('child_node_1');
			//$.jstree._focused().select_node("#j1_2");
      		//$('#jstree').jstree('select_node', 'j1_1');
			//$('#jstree').jstree('select_node', 'j1_2');
      		//$.jstree.reference('#jstree').select_node('zhousicong');
    		});
  
});

function rootnode(){
//alert("function");
//$("#jstree").jstree("destroy");
//initree();
//sleepI(1);
$('#jstree').jstree('select_node', 'j1_1');
}

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
      <div> <br>
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
    <li><a href="resultmanagement.jsp">结果管理</a></li>
    <li><a href="sutindex.jsp">接入申请</a></li>
    <li><a href="rolemanagement.jsp">用户权限</a></li>
    <%if (session.getAttribute("isAdmin") != null){
        String UserIsAdmin = String.valueOf(session.getAttribute("isAdmin"));
        if (UserIsAdmin == "true"){%>
    <li><a href="inimanager.jsp">隐藏用户权限for Admin</a></li>
    <li><a href="inidata.jsp">隐藏创建版本for Admin</a></li>
    <%}}%>
  </ul>
  <!--
  <button>demo button</button>
  --> 
  <!--主体-->
  <table id="maintable" width="100%" align="center" class="table table-bordered">
    <tr> 
      <!--左边Tree-->
      <td style="vertical-align:top;">
      <div id="createbtn">
            <button type="button" class="btn btn-success" style="width:100px" onclick="demo_create();">新建</button>
            <button type="button" class="btn btn-info" style="width:100px" onclick="demo_refresh();">刷新</button>
       
      </div>
      <br>
      <div style="width:283px;height:397px;overflow:scroll;">
          <div id="searchDiv" align="left">
            <input type="text" id="plugins4_q" value="" class="input" style="display:block; width:210px; padding:4px; border-radius:4px; border:1px solid silver;">
          </div>
          <br>
          <div id="jstree"></div>
          <!--<div id="event_result" style="margin-top:2em; text-align:left;">hhhhh&nbsp;</div>--> 
        </div></td>
      <!--About SUT-->
      <td height="467px" id="sutCaseInfoTd" style="display:block; width:1000px" ><div id="sutCaseInfoDiv" style="text-align:center"> </div></td>
      
      <!--Interface Search-->
      <td id="interfacesearchTd" style="display:none; width:1000px" height="467px"><table id="interfaceSearchTable" style="width:100%;" class="table table-striped">
          <tr style="text-align:center">
            <td width="20%">自动化</td>
            <td width="16%">优先级</td>
            <td width="16%">正/反例</td>
            <td width="16%">用例评审</td>
            <td width="16%">项目</td>
            <td width="16%">版本</td>
          </tr>
          <tr>
            <td><select id="querystatus" style="width:100%">
                <option value="All" selected>All</option>
                <option value="自动">自动</option>
                <option value="手动">手动</option>
                <option value="废弃">废弃</option>
              </select></td>
            <td><select id="querypriority" style="width:100%" >
                <option value="All" selected>All</option>
                <option value="P1">P1</option>
                <option value="P2">P2</option>
                <option value="P3">P3</option>
              </select></td>
            <td><select id="querytype" style="width:100%">
                <option value="All" selected>All</option>
                <option value="正例">正例</option>
                <option value="反例">反例</option>
              </select></td>
            <td><select id="queryapproval" style="width:100%">
                <option value="All" selected>All</option>
                <option value="待评审">待评审</option>
                <option value="通过">通过</option>
                <option value="未通过">未通过</option>
              </select></td>
            <td><select id="queryproject" style="width:100%">
                <option value="All" selected>All</option>
                <% for (int i =0; i< testcaseprojects.size();i++ ){%>
                <option value="<%=testcaseprojects.get(i).getName()%>"><%=testcaseprojects.get(i).getName()%></option>
                <%}%>
              </select></td>
            <td><select id="queryversion" style="width:100%">
                <option value="All" selected>All</option>
                <% for (int i =0; i< versions.size();i++ ){%>
                <option value="<%=versions.get(i).getVersionNum()%>"><%=versions.get(i).getVersionNum()%></option>
                <%}%>
              </select></td>
          </tr>
          <tr>
            <td colspan="6" style="text-align:center"><input type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center" onClick="queryinterfaceac()" value="搜索"></td>
          </tr>
        </table>
        <div id="interfaceSearchResultDiv" style="text-align:center"></div></td>
      
      <!--展示、更新testsuite-->
      <td style="display:none; width:1000px" id="showTestSuiteTd" height="467px"><form id="showTestSuiteForm" name="showTestSuiteForm">
          <table width="100%" id="showTestSuiteTable">
            <tr>
              <td  align="right" width="100px">测试集  :&nbsp;&nbsp;</td>
              <td><div class="input-group"> <span class="input-group-addon">Ts_</span>
                  <input id="showtestsuite_name"  onKeyUp="quanjiao(this);" class="form-control input-sm" name="showtestsuite_name" value="" style="width:200px" readonly>
                </div>
            </tr>
            <tr style="display:none">
              <td><input id="showtestsuite_changetag" name="showtestsuite_changetag" type="text" class="form-control" readonly></td>
            </tr>
            <tr>
              <td colspan="2"><input id="showtestsuite_id" name="showtestsuite_id" value="" class="form-control input-sm" style="display:none" readonly></td>
            </tr>
            <tr>
              <td  align="right" width="100px">所属系统  :&nbsp;&nbsp;</td>
              <td><input id="showsut_name" name="showsut_name" value="<%=sut_name%>"  class="form-control input-sm" style="width:200px" readonly></td>
            </tr>
            <tr>
              <td  align="right" width="100px">起始版本  :&nbsp;&nbsp;</td>
              <td id="showversiontd" style="display:block"><input id="showversion" value="" class="form-control input-sm" style="width:200px" readonly></td>
              <td id="showversionoption" style="display:none"><div id="updateversiongroup" class="selectbox">
                  <div class="cartes">
                    <input type="text" value="" id="updateversion" name="version" class="listTxt" readonly>
                    <div class="listBtn"><b></b></div>
                    <input type="hidden" value="" class="listVal" >
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
              <td align="right" width="100px">状态  :&nbsp;&nbsp;</td>
              <td id="showisdiscardtd" style="display:block"><input id="showisdiscard" value="" class="form-control input-sm" style="width:200px" readonly></td>
              <td id="showisdiscardoption" style="display:none"><input type="radio" name="updateisdiscard" value="using" checked>
                正在使用&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateisdiscard" value="discard">
                已废弃&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
            <tr>
              <td  align="right" width="100px">描述  :&nbsp;&nbsp;</td>
              <td><textarea  rows="4" name="showtestsuite_description" class="input-xlarge form-control" readonly id="showtestsuite_description" style="max-height:100px; max-width:300px; width:300px; height:100px;"></textarea></td>
            </tr>
            <tr align="left">
              <td colspan="2" id="upTestSuiteTd" style="display:block"><button type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center" onClick="updateTestSuiteac()" id="upTestSuite" name="upTestSuite">更新</button></td>
              <td colspan="2" id="saveTestSuiteTd" style="display:none"><button type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center" onClick="saveTestSuiteac()" id="saveTestSuite" name="saveTestSuite" >保存</button></td>
            </tr>
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
          </table>
        </form>
        <div id="testsuiteInfoDiv" style="text-align:center"> </div></td>
      
      <!--展示更新testcase-->
      <td style="display:none; width:1000px; height:467px" id="showTestCaseTd"><form id="showTestCaseForm">
          <table width="100%" id="showcaseinfo">
            <tr>
              <td colspan="4" style="text-align:center"></td>
              <td style="text-align:center; width:300px">历史修改记录</td>
            </tr>
            <tr>
              <td width="90px">用例名称</td>
              <td><div class="input-group"> <span class="input-group-addon" id="pre_casename"></span>
                  <input id="showtestcase_name" class="form-control input-sm" name="showtestcase_name" value="" style="width:100px" onKeyUp="quanjiao(this);" readonly>
                </div>
                </td>
              <td width="90px">版本</td>
              <td id="showtestcase_versiontd" style="display:block"><input id="showtestcase_version" value="" class="form-control input-sm" style="width:200px" readonly></td>  
              <td id="showtestcase_versionoption" style="display:none">
              <select id="testcaseversion"  name="testcaseversion" style="width:200px">
                <option value="<%=versions.get(0).getVersionNum()%>" selected><%=versions.get(0).getVersionNum()%></option>
                <% for (int i =1; i< versions.size();i++ ){%>
                <option value="<%=versions.get(i).getVersionNum()%>"><%=versions.get(i).getVersionNum()%></option>
                <%}%>
              </select>
              
              
              </td>
              <td rowspan="10" style="vertical-align:top"><div id="showCaseChangeHistoryDiv" style="height:430px;overflow:scroll;"> </div></td>
            </tr>
            <tr>
              <td><input id="showtestcase_id" name="showtestcase_id" value="" style="display:none" readonly></td>
			  <td><input id="showtestcase_changetag" name="showtestcase_changetag" value="" style="display:none" readonly></td>
			</tr>
            <tr>
              <td  width="90px">创建者</td>
              <td><div id="showtestcasecreator"></div></td>
              <td  width="90px">创建时间</td>
              <td><input id="showtestcasecreattime" class="form-control input-sm" style="width:200px" value="" readonly></td>
            </tr>
            <tr style="display:none">
              <td>所属TestSuite</td>
              <td><input id="showcasetestsuite_name" name="showcasetestsuite_name" value="" maxlength="15" readonly></td>
            </tr>
            <tr>
              <td>项目</td>
              <td id="showprojecttd" style="display:block"><input id="showproject" class="form-control input-sm" style="width:200px" value="" readonly></td>
              <td id="showprojectoption" style="display:none; vertical-align:middle"><div id="updateprojectgroup" class="selectbox">
                  <div class="cartes">
                    <input type="text" value="<%=testcaseprojects.get(0).getName()%>" id="updateproject" name="updateproject" class="listTxt" readonly>
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
              <td>优先级</td>
              <td id="showcaseprioritytd" style="display:block"><input id="showcasepriority" value="" class="form-control input-sm" style="width:200px" readonly></td>
              <td id="showcasepriorityoption" style="display:none"><input type="radio" name="updatepriority" id="p1" value="P1" checked>
                P1&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatepriority" id="p2" value="P2">
                P2&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatepriority" id="p3" value="P3">
                P3 </td>
            </tr>
            <tr>
              <td>状态</td>
              <td id="showcasestatustd" style="display:block"><input id="showcasestatus" class="form-control input-sm" style="width:200px" value="" readonly></td>
              <td id="showcasestatusoption" style="display:none"><input type="radio" name="updatestatus" id="manul" value="手动" checked>
                手动&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatestatus" id="auto" value="自动">
                自动&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updatestatus" value="废弃" id="discard">
                废弃 </td>
              <td>正/反例</td>
              <td id="showcasetypetd" style="display:block"><input id="showcasetype" class="form-control input-sm" style="width:200px" value="" readonly></td>
              <td id="showcasetypeoption" style="display:none"><input type="radio" name="updatetype" id="zhengli" value="正例" checked>
                正例&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" id="fanli" name="updatetype" value="反例" >
                反例 </td>
            </tr>
            <tr>
              <td>描述</td>
              <td colspan="3"><textarea  rows="4" name="showcasedescription" class="form-control" id="showcasedescription" style="max-height:50px; max-width:550px; width:5500px; height:50px;" readonly></textarea></td>
            </tr>
            <tr>
              <td>步骤</td>
              <td colspan="3"><textarea  rows="4" name="showcasesteps"  class="form-control" id="showcasesteps" style="max-height:150px; max-width:550px; width:550px; height:150px;"  readonly></textarea></td>
            </tr>
            <tr align="left">
              <td colspan="4" id="upTestCaseTd" style="display:" align="center"><button type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center"  onClick="updateTestCaseac()" id="upTestCase" name="upTestCase" >更新</button></td>
              <td colspan="4" id="saveTestCaseTd" style="display:none" align="center"><button type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center" onClick="saveTestCaseac()" id="saveTestCase" name="saveTestCase" >保存</button></td>
            </tr>
            <tr>
              <td id="showapprovalupdatetd" style="display:; vertical-align:top" align="center"><input type="button"  class="btn btn-primary btn-sm" style="width:80px; text-align:center" value="开始评审" onClick="updateapprovalac()"></td>
              <td id="showapprovalsavetd" style="display:none; vertical-align:top" align="center"><input type="button" class="btn btn-primary btn-sm" style="width:80px; text-align:center" value="确认评审" onClick="saveapprovalac()"></td>
              <td id="showapprovaltd" style="display:block"><input id="showapproval" class="input-sm form-control" style="width:200px; vertical-align:top" value="" readonly></td>
              <td id="showaprovaloption" style="display:none"><input type="radio" name="updateapproval" onClick="document.getElementById('approval_commentsTd').style.display='none';document.getElementById('approval_comments').readOnly = true;" value="待评审" checked>
                待评审&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateapproval" onClick="document.getElementById('approval_commentsTd').style.display ='none';document.getElementById('approval_comments').readOnly = true;" value="通过">
                通过&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="updateapproval" onClick="document.getElementById('approval_commentsTd').style.display='';document.getElementById('approval_comments').readOnly = false;document.getElementById('approval_comments').value='请输入拒绝原因，最大输入三十个字!';" value="未通过">
                未通过&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
            <tr id="approval_commentsTd" style="display:none;">
              <td>拒绝原因</td>
              <td align="center" colspan="3"><input class="form-control input-sm" style="width:639px;"  id="approval_comments" name="approval_comments" value="请输入拒绝原因，最大输入六十个字!" readonly maxlength="60"></td>
            </tr>
          </table>
        </form></td>
    </tr>
  </table>
  <!--隐藏表单创建testsuite-->
  <div id="createTestSuite" style="display:none">
    <form>
      <table width="500px" height="200px" style="background:#FFF">
        <tr>
          <td width="100px">测试集</td>
          <td><div class="input-group"> <span class="input-group-addon">Ts_</span>
              <input id="testsuite_name" class="form-control input-sm" name="testsuite_name" value=""  style="width:200px">
            </div></td>
        </tr>
        <tr>
          <td colspan="2"><input id="sut_name" name="sut_name" style="display:none" value="<%=sut_name%>" readonly></td>
        </tr>
        <tr>
          <td>起始版本</td>
          <td>
          <select id="version"  name="version" style="width:150px;" >
                <option value="<%=versions.get(0).getVersionNum()%>" selected><%=versions.get(0).getVersionNum()%></option>
                <% for (int i =1; i< versions.size();i++ ){%>
                <option value="<%=versions.get(i).getVersionNum()%>"><%=versions.get(i).getVersionNum()%></option>
                <%}%>
              </select></td>
        </tr>
        <tr>
          <td>描述</td>
          <td><textarea  rows="4" name="testsuite_description" id="testsuite_description" style="max-height:100px; max-width:300px; width:300px; height:100px;"></textarea></td> 
        </tr>
      </table>
    </form>
  </div>
  <!--隐藏表单创建testcase-->
  <div id="createTestCase" style="display:none">
    <form>
      <table width="600px" height="500px" style="background:#FFF">
        <tr>
          <td width="100px">用例名称</td>
          <td><!--TODO-->
            
            <div class="input-group"> <span class="input-group-addon" id="pre_stname"></span>
              <input id="testcase_name" class="form-control input-sm" name="testcase_name" value="" onKeyUp="quanjiao(this);" style="width:200px">
            </div>
        </tr>
        <tr>
          <td colspan="2"><input id="casesut_name" style="display:none" name="sut_name" value="<%=sut_name%>"></td>
        </tr>
        <tr style="display:none">
          <td>测试集</td>
          <td><input id="casetestsuite_name"  class="form-control input-sm"  style="width:200px;" name="testsuite_name" value="" readonly></td>
        </tr>
        <tr>
          <td>项目</td>
          <td>
          <select id="project"  name="project" style="width:150px">
                <option value="<%=testcaseprojects.get(0).getName()%>" selected><%=testcaseprojects.get(0).getName()%></option>
                <% for (int i =1; i< testcaseprojects.size();i++ ){%>
                <option value="<%=testcaseprojects.get(i).getName()%>"><%=testcaseprojects.get(i).getName()%></option>
                <%}%>
              </select></td>
        </tr>
        <tr>
          <td>项目</td>
          <td>
          <select id="caseversion"  name="caseversion" style="width:150px">
                <option value="<%=versions.get(0).getVersionNum()%>" selected><%=versions.get(0).getVersionNum()%></option>
                <% for (int i =1; i< versions.size();i++ ){%>
                <option value="<%=versions.get(i).getVersionNum()%>"><%=versions.get(i).getVersionNum()%></option>
                <%}%>
              </select></td>
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
          <td>正例</td>
          <td><input type="radio" name="type" id="zhengli" value="正例" checked>
            正例&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" id="fanli" name="type" value="反例">
            反例</td>
        </tr>
        <tr>
          <td>描述</td>
          <td><textarea  rows="4" name="description" id="description" style="max-height:50px; max-width:400px; width:400px; height:50px;"></textarea></td>
        </tr>
        <tr>
          <td>步骤</td>
          <td><textarea  rows="4" name="casesteps" id="casesteps" style="max-height:150px; max-width:400px; width:400px; height:150px;"></textarea></td>
        </tr>
      </table>
    </form>
  </div>
  <!--网页底部-->
  <div style="background:#428bca; color:#ffffff; text-align:center; width:1319px;">
    <p> <small><b>自动化测试</b>：WebService | App | Web | Stress |
      Solution<br />
      Copyright© 2013-2016 平安付科技中心移动研发系统测试</small> </p>
  </div>
</div>
</body>
</html>