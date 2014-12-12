<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/getSpecialTestcaseResultContent.action").forward(request,response);}
if (request.getAttribute("commentflag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/getTRHistoryStatus.action").forward(request,response);}
String status =  request.getAttribute("status").toString();
String comment = request.getAttribute("comment").toString();
Testcase testcase = (Testcase)request.getAttribute("testcase");
List<TestcaseResultContent> testcaseresult_contents = (List<TestcaseResultContent>)request.getAttribute("testcaseresultcontents");
int size = testcaseresult_contents.size();
String case_name = testcase.getCaseName().toString();
String testcaseresult_id = request.getAttribute("testcaseresult_id").toString();
String caseresultstatus;
if (String.valueOf(request.getAttribute("ispass")) == "true"){
	caseresultstatus = "y";
}
else { caseresultstatus = "n";};
String isCurrentRole;
if (String.valueOf(request.getAttribute("isCurrentRole")) == "true"){
	isCurrentRole = "y";
}
else { isCurrentRole = "n";};
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript"> 
	
	function loginac() {
		document.loginform.action = "${pageContext.request.contextPath}/login.action";
		document.loginform.submit();
	}
	
	
	
	
	function inidata(){
		<%String caseresult = "";
		String rowtype = "";
		String rowvalue = "";
		for (int i=0 ; i < testcaseresult_contents.size(); i++){
			if (testcaseresult_contents.get(i).getResult() == null){ 
				rowtype = "";
				}
			else if (testcaseresult_contents.get(i).getResult().equals("0"))
			{
				rowtype = "style='background-color:#00ff00;font-weight:bloder;'";
				}
			else if(testcaseresult_contents.get(i).getResult().equals("1")) 
			{
				rowtype = "style='background-color:#ff0000;font-weight:bloder;'";
				}
			
			if(testcaseresult_contents.get(i).getStatus().equals("Screenshot")){
			rowvalue = testcaseresult_contents.get(i).getValue();
			caseresult += "<tr>";
			caseresult += "<td width='100px'>" + testcaseresult_contents.get(i).getStatus() + "</td>";
			caseresult += "<td "+rowtype+"><a href='"+rowvalue+"'>ScreenShot</a></td>";
			caseresult += "</tr>";
			}
			else{
			rowvalue = testcaseresult_contents.get(i).getValue();
			rowvalue = rowvalue.replaceAll("<", "&lt;");
			rowvalue = rowvalue.replaceAll(">", "&gt;");
			rowvalue = rowvalue.replaceAll("\"", "&#34;");
			rowvalue = rowvalue.replaceAll("\n","");
			//TODO
			caseresult += "<tr>";
			caseresult += "<td width='100px'>" + testcaseresult_contents.get(i).getStatus() + "</td>";
			caseresult += "<td "+rowtype+">" + rowvalue + "</td>";
			caseresult += "</tr>";
			}
			}%>
		
		
		return "<%=caseresult%>";	
		
	}
	
	
	
	function updatecommentac(){
		if('<%=session.getAttribute("user")%>' == 'null'){
		alert("请登录后再进行操作！");
	}
	else{
	if('<%=isCurrentRole%>' != "y"){
	alert("您目前权限不足，请向该项目经理去申请操作权限！")
	}
	else {
		document.getElementById('showcommentupdatetd').style.display = "none";
		document.getElementById('showcommentsavetd').style.display = "";
		document.getElementById('showcommenttd').style.display = "none";
		document.getElementById('showcommentoption').style.display = "";
		document.getElementById('comment').readOnly = false;
		}
		}
		}
	
	
	function savecommentac(){
		var status_value;
	  	status_radio = document.getElementsByName('updatecomment');
	  	for(i=0;i<status_radio.length;i++){  
	  	if(status_radio[i].checked){
	    	status_value = status_radio[i].value;
	  	}
	  	};
		var comment_value = document.getElementById('comment').value;
		
		
		$.ajax({
			  type : "POST",
			  url : "addTRHistory.action",
			  cache : false,
			  data : {testcaseresult_id:'<%=testcaseresult_id%>',status:status_value,comment:comment_value},
			  dataType : "json",
			  success : function(root) {
				  document.getElementById('showcommentupdatetd').style.display = "";
				  document.getElementById('showcommentsavetd').style.display = "none";
				  document.getElementById('showcommenttd').style.display = "";
		  		  document.getElementById('showcommentoption').style.display = "none";
				  document.getElementById('comment').readOnly = true;
				  document.getElementById('showcomment').value = status_value;
				  inihistory();
				  //alert("zhow");
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
		}
		
	
	function inihistory(){
		$.ajax({
			  type : "POST",
			  url : "listTRHistories.action",
			  cache : false,
			  data : {testcaseresult_id:'<%=testcaseresult_id%>'},
			  dataType : "json",
			  success : function(root) {
				  $("#showCaseChangeHistoryDiv").html("");
				  var caseChangeHistory="";
				  var historylength = root.analysecommenthistoryDtoes.length;
				  for (i=0 ; i< historylength ;i++){
					  caseChangeHistory += "<p><a href='#casechange"+ i +"' data-toggle='collapse'>" + root.analysecommenthistoryDtoes[i].createtime+ "</a>&nbsp;&nbsp;By&nbsp;&nbsp;<a href='getuserinfo.action?userid="+root.analysecommenthistoryDtoes[i].updator.id + "'>"+root.analysecommenthistoryDtoes[i].updator.displayName+"</a></p>";
					  caseChangeHistory += "<div id='casechange"+ i +"' class='collapse'>";
					  caseChangeHistory += "<table class='table table-striped'><tr><td>修改项</td><td>修改前</td><td>修改后</td></tr>";
					  if (root.analysecommenthistoryDtoes[i].oldstatus != null){
						  caseChangeHistory += "<tr><td>状态</td>";
						  caseChangeHistory += "<td>"+root.analysecommenthistoryDtoes[i].oldstatus+"</td>";
						  caseChangeHistory += "<td>"+root.analysecommenthistoryDtoes[i].newstatus+"</td></tr>";
						  }
					  if (root.analysecommenthistoryDtoes[i].oldcomment != null){
						  caseChangeHistory += "<tr><td>失败原因</td>";
						  caseChangeHistory += "<td>"+root.analysecommenthistoryDtoes[i].oldcomment+"</td>";
						  caseChangeHistory += "<td>"+root.analysecommenthistoryDtoes[i].newcomment+"</td></tr>";
							}
					  caseChangeHistory += "</table></div>";
					  }
					 if (document.getElementById("showCaseChangeHistoryDiv").innerHTML.toString() == ""){
					$("#showCaseChangeHistoryDiv").append(caseChangeHistory);
					 }
			  },

			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  alert(XMLHttpRequest.status);
				  alert(XMLHttpRequest.readyState);
				  alert(textStatus);
			  }
		  });
		}
	
	$(document).ready( function(){
		$("#caseinfoTab").html("");
		$("#caseinfoTab").append(inidata());
		<%if (caseresultstatus != "y"){%>
		document.getElementById('showcomment').value = '<%=status%>';
		document.getElementById('comment').value = '<%=comment%>';
		inihistory();
<%}%>
	});
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<p>
			<h2><%=case_name%>测试结果
			</h2>
			</p>
			<table class="table table-bordered" width="100%"
				style="word-wrap:break-word;word-break:break-all">
				<tbody id="caseinfoTab">
				</tbody>
			</table>
			<%
				if (caseresultstatus != "y") {
			%>
			<form id="commentForm" name="commentForm">
				<table>
					<tr>
						<td id="showcommentupdatetd" style="display:; vertical-align:top;"
							align="center"><input type="button"
							class="btn btn-primary btn-sm"
							style="width:100px; text-align:center" value="分析结果"
							onClick="updatecommentac()"></td>
						<td id="showcommentsavetd"
							style="display:none; vertical-align:top" align="center"><input
							type="button" class="btn btn-primary btn-sm"
							style="width:100px; text-align:center" value="确认"
							onClick="savecommentac()"></td>
						<td id="showcommenttd" style="display:block"><input
							id="showcomment" class="input-sm form-control"
							style="width:200px; vertical-align:top" value="" readonly>
						</td>
						<td id="showcommentoption" style="display:none"><input
							type="radio" name="updatecomment" value="缺陷" checked>
							缺陷&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
							name="updatecomment" value="其他">
							其他&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td width="100px">失败原因</td>
						<td><textarea rows="4" name="comment"
								class="input-xlarge form-control" readonly id="comment"
								style="max-height:100px; max-width:300px; width:300px; height:100px;"></textarea>
						</td>
					</tr>
				</table>
			</form>

			<div id="showCaseChangeHistoryDiv"></div>
			<%
				}
			%>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>