<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>测试结果</title>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/getSpecialTestsuiteResultContent.action").forward(request,response);}
Testsuite testsuite = (Testsuite)request.getAttribute("testsuite");
String ts_name = testsuite.getName().toString();
String ts_desc = testsuite.getDescription().toString();
String ts_id = testsuite.getId().toString();
List<TestcaseResult> testcase_results = (List<TestcaseResult>)request.getAttribute("testcaseresults");
%>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
	
	function inidata(){
		<%
		String caseinfo = "";
		String Ispass = "";
		String redtype = "color:#ff0000;style='font-weight:bloder;'";
		String greentype = "color:#00ff00;style='font-weight:bloder;'";
		for (int i=0 ; i < testcase_results.size(); i++){
			if (String.valueOf(testcase_results.get(i).getIspass()) == "true"){
				Ispass = "成功";
				}
				else {
					Ispass = "失败";
					}
			
		String Description = testcase_results.get(i).getTestcase().getDescription();
			Description = Description.replaceAll("<", "&lt;");
			Description = Description.replaceAll(">", "&gt;");
			Description = Description.replaceAll("\"", "&#34;");
			Description = Description.replaceAll("\n","");
			
			caseinfo += "<tr>";
			if (String.valueOf(testcase_results.get(i).getIspass()) == "true"){
			caseinfo += "<td>" + testcase_results.get(i).getCasename() + "</td><td class='redlink'><a href='caseresult.jsp?testcaseresult_id="+testcase_results.get(i).getId()+"'>" + Ispass + "</a></td><td>" + testcase_results.get(i).getTestcase().getCasetype() + "</td><td>" + Description + "</td>";}
			else {
			caseinfo += "<td>" + testcase_results.get(i).getCasename() + "</td><td class='greenlink'><a href='caseresult.jsp?testcaseresult_id="+testcase_results.get(i).getId()+"'>" + Ispass + "</a></td><td>" + testcase_results.get(i).getTestcase().getCasetype() + "</td><td>" +Description + "</td>";
				}
			caseinfo += "</tr>";}
		%>
		return "<%=caseinfo%>";
		
	}
	
	$(document).ready( function(){
		$("#caseinfoTab").html("");
		$("#caseinfoTab").append(inidata());
		});
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<p>
			<h2><%=ts_name%>测试结果
			</h2>
			</p>
			<table class="table table-bordered">
				<tr>
					<td>测试集</td>
					<td><%=ts_name%></td>
				</tr>
				<tr>
					<td>描述</td>
					<td><%=ts_desc%></td>
				</tr>
			</table>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr>
						<td>case名称</td>
						<td>结果</td>
						<td>正例/反例</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="caseinfoTab">
				</tbody>
			</table>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>