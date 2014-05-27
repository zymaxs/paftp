<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/reguserinfo.action").forward(request,response);}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/jqpagination.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.jqpagination.js"></script>
<title>无标题文档</title>

</head>

<body>
	<script type="text/javascript">
		$(document).ready(function() {

			$('.pagination').jqPagination({
				link_string : '/?page={page_number}',
				max_page : 40,
				paged : function(page) {
					alert("fuck!");
				       var params = {

				    	          code : $("#xm").val(),

				    	          name : $("#sg").val()

				    	       };
					$.ajax({

						type : "POST",

						url : "initialSutsAjax.action",

						data : params,

						dataType : "text",

						success : function(json) {

							var obj = $.parseJSON(json);

							var state_value = obj.result;

							alert(state_value);

						},

						error : function(json) {

							alert("json=" + json);

							return false;

						}

					});
				}
			});

		});
	</script>
	<div class="pagination">
		<a href="#" class="first" data-action="first">&laquo;</a> <a href="#"
			class="previous" data-action="previous">&lsaquo;</a> <input
			type="text" readonly="readonly" data-max-page="40" /> <a href="#"
			class="next" data-action="next">&rsaquo;</a> <a href="#" class="last"
			data-action="last">&raquo;</a>
	</div>
</body>
</html>