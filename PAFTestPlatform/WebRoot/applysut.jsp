<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/applysutgroup.action").forward(request,response);}
List<String> sutgroup = (List<String>)request.getAttribute("sutgroupnames");
%>
<script type="text/javascript">
	var sessionUser = '<%=session.getAttribute("user")%>';
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>系统申请</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script src="JavaScript/applysut/applysut.js"></script>

</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>
	<div id="main-wrap">
		<div id="container">
			<form id="applysutform" name="applysutform" class="form-horizontal"
				method="post" action="">
				<fieldset>
					<legend>
						接入系统申请 <small>(带*号标志为必输项)</small>
					</legend>
					<table>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon">* 系统名 :</span> <input
										type="text" class="form-control" id="sutname" name="sutname"
										onKeyUp="quanjiao(this);" maxlength="20"/>
								</div></td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon">* 系统所属平台 :</span> <select
										class="form-control" id="groupname" name="groupname">
										<option value="<%=sutgroup.get(0)%>" selected><%=sutgroup.get(0)%></option>
										<%
											for (int i = 1; i < sutgroup.size(); i++) {
										%>
										<option value="<%=sutgroup.get(i)%>"><%=sutgroup.get(i)%></option>
										<%
											}
										%>
									</select>
								</div></td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon">* 系统中文名 :</span> <input
										type="text" class="form-control" id="code" name="code" maxlength="30" />
								</div></td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon">* 系统描述 :</span>
									<textarea class="form-control" id="description"
										name="description"
										style=" width:100px; max-height:100px; width:200px; max-width:200px"></textarea>
								</div></td>
						</tr>
						<tr>
							<td><input type="button" class="btn btn-primary"
								style="width:80px; text-align:center" name="apsut" id="apsut"
								onClick="applysutac()" value="提交申请"></td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>