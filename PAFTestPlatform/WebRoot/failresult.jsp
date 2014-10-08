<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/queryFailedTestcases.action").forward(request,response);}
String pagenum = request.getAttribute("pages").toString();
String testpassname = request.getAttribute("testpassname").toString();
List<TestcaseResultDto> testcaserange_dtoes = (List<TestcaseResultDto>)request.getAttribute("testcaseresultdtoes");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link href="css/jqpagination.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<Script language="javascript">
function GetRequest() {
   var url = location.search; //获取url中"?"符后的字串
   var theRequest = new Object();
   if (url.indexOf("?") != -1) {
      var str = url.substr(1);
      strs = str.split("&");
      for(var i = 0; i < strs.length; i ++) {
         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
      }
   }
   return theRequest;
}

var Request = new Object();
Request = GetRequest();
var testpass_id;
testpass_id = Request['testpass_id'];

var pagentotal = <%=pagenum%>;

$(document).ready( function(){
	
	$('.pagination').jqPagination({
		link_string : '/?page={page_number}',
		max_page : pagentotal, 
		paged : function(page) {
		params = {pagenum:page,testpass_id:testpass_id};
		$.ajax({
				type : "POST",
				url : "queryFailedTestcasesByPage.action",
				data : params,
				dataType : "json",
				success : function(root) {
					$("#caseinfoTab").html("");
					var caseinfo = "";
					var Ispass = "";
					for ( i=0 ; i < root.testcaseresultdtoes.length; i++){
						if (root.testcaseresultdtoes[i].ispass == "true"){
							Ispass = "成功";
							}
							else {
								Ispass = "失败";
								}
						
					var Description = root.testcaseresultdtoes[i].testcase.description;
					if (Description != null){
					Description = Description.replace(/</g, "&lt;");
					Description = Description.replace(/>/g, "&gt;");
					Description = Description.replace(/\"/g, "&#34;");
					Description = Description.replace(/\n/g,"");
					}
					else Description ="";
					
					
					caseinfo += "<tr>";
					caseinfo += "<td>"+ root.testcaseresultdtoes[i].casename +"</td>";
					caseinfo += "<td class='redlink'><a href='caseresult.jsp?testcaseresult_id="+root.testcaseresultdtoes[i].id+"'>"+ Ispass +"</a></td>";
					caseinfo += "<td>"+ root.testcaseresultdtoes[i].testcase.casetype +"</td>";
					caseinfo += "<td>"+ Description +"</td>";
					caseinfo += "<td>"+ root.testcaseresultdtoes[i].status +"</td>";
					caseinfo += "</tr>";
						
					}
					$("#caseinfoTab").append(caseinfo);
				},

				error : function(root) {

					alert("json=" + root);

					return false;

				}
			})
		}
		});
	
	$('.pagination').jqPagination('option', 'max_page', pagentotal);
	
});
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<p>
			<h2><%=testpassname%>失败案例集合
			</h2>
			</p>

			<table class="table table-bordered">
				<thead>
					<tr>
						<td>case名称</td>
						<td>结果</td>
						<td>正例/反例</td>
						<td>描述</td>
						<td>状态</td>
					</tr>
				</thead>
				<tbody id="caseinfoTab">
				</tbody>
			</table>
			<div align="center">
				<div class="pagination">
					<a href="#" class="first" data-action="first">&laquo;</a> <a
						href="#" class="previous" data-action="previous">&lsaquo;</a> <input
						type="text" readonly="readonly" /> <a href="#" class="next"
						data-action="next">&rsaquo;</a> <a href="#" class="last"
						data-action="last">&raquo;</a>
				</div>
			</div>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>