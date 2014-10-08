<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<%
	if (session.getAttribute("user") == null) {
%>
<Meta http-equiv="refresh" content="0;url='index_1.jsp'; ">
<%
	}
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/sutinitialAddRelationship.action").forward(request,response);}
String isAdmin = String.valueOf(request.getAttribute("isAdmin"));
String isManager = String.valueOf(request.getAttribute("isManager"));
List<User> managers = (List<User>)request.getAttribute("managers");
List<User> workers = (List<User>)request.getAttribute("workers");
List<User> freeusers = (List<User>)request.getAttribute("freeusers");
List<User> nonmanagers = (List<User>)request.getAttribute("nonmanagers");
String sut_id = (String)request.getAttribute("sut_id");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>授权用户</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script type="text/javascript">
	function updateroleac(){
		document.getElementById('managerstring').value = finmanager();
		document.getElementById('workerstring').value = finworker();
		document.userroleForm.action = "${pageContext.request.contextPath}/sutaddRelationship.action";
		document.userroleForm.submit();
		};
	
	
	function finfreeuser(){
		var finalfreeuser = "";
		for (i = 0; i < document.getElementById('freeuser').length ; i++ ){
			finalfreeuser += document.getElementById('freeuser').options[i].value + ";";
			}
		return finalfreeuser;
	};
	
	function finmanager(){
		var finalmanager = "";
		for (i = 0; i < document.getElementById('manage').length ; i++ ){
			finalmanager += document.getElementById('manage').options[i].value + ";";
			}
		return finalmanager;
	};
	
	function finworker(){
		var finalworker = "";
		for (i = 0; i < document.getElementById('worker').length ; i++ ){
			finalworker += document.getElementById('worker').options[i].value + ";";
			}
		return finalworker;
	};
	
	function ini(){
		if ('<%=isAdmin%>' == "true" && '<%=isManager%>' != "true"){
			document.getElementById('freeuserselect').style.display = "none";
			
			document.getElementById('sutworkerselect').style.display = "";
			
			document.getElementById('manageselect').style.display = "";
			
			document.getElementById('workerselect').style.display = "none";
			
			document.getElementById('workerstring').disabled = "true";
			}
		else if ('<%=isAdmin%>' != "true" && '<%=isManager%>' == "true"){
			document.getElementById('freeuserselect').style.display = "";
			
			document.getElementById('sutworkerselect').style.display = "none";
			
			document.getElementById('manageselect').style.display = "none";
			
			document.getElementById('workerselect').style.display = "";
			
			document.getElementById('managerstring').disabled = "true";
		}
		};
		
	function inifreeuserdata(){
		<%String freeuserdata = "";
		for (int i = 0; i < freeusers.size(); i++ ){
			freeuserdata += "<option>" + freeusers.get(i).getAlias() +"</option>";
		}%>
		return '<%=freeuserdata%>';
		};
	
	function iniworkerdata(){
		<%String workerdata = "";
		for (int i = 0; i < workers.size(); i++ ){
			workerdata += "<option>" + workers.get(i).getAlias() +"</option>";
		}%>
		return '<%=workerdata%>';
		};
	
	function inimanagerdata(){
		<%String managerdata = "";
		for (int i = 0; i < managers.size(); i++ ){
			managerdata += "<option>" + managers.get(i).getAlias() +"</option>";
		}%>
		return '<%=managerdata%>';
	};

	$(document).ready(function() {
		ini();
		$("#freeuser").append(inifreeuserdata());
		$("#manage").append(inimanagerdata());
		$("#worker").append(iniworkerdata());
		$("#sutworker").append(iniworkerdata());
		//移到右边
		$('#add').click(function() {
			//获取选中的选项，删除并追加给对方
			if (document.getElementById('manageselect').style.display == "") {
				$('#sutworker option:selected').appendTo('#manage');
			} else {
				$('#freeuser option:selected').appendTo('#worker');
			}
		});
		//移到左边
		$('#remove').click(function() {
			if (document.getElementById('manageselect').style.display == "") {
				$('#manage option:selected').appendTo('#sutworker');
			} else {
				$('#worker option:selected').appendTo('#freeuser');
			}
		});
		//全部移到右边
		$('#add_all').click(function() {
			//获取全部的选项,删除并追加给对方
			if (document.getElementById('manageselect').style.display == "") {
				$('#sutworker option').appendTo('#manage');
			} else {
				$('#freeuser option').appendTo('#worker');
			}
		});
		//全部移到左边
		$('#remove_all').click(function() {
			if (document.getElementById('manageselect').style.display == "") {
				$('#manage option').appendTo('#sutworker');
			} else {
				$('#worker option').appendTo('#freeuser');
			}
		});
	});
</script>
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<form id="userroleForm" name="userroleForm" action="">
				<fieldset>
					<legend>用户权限变更</legend>
					<div align="center">
						<table style="text-align:center">
							<tr>
								<td>未授权用户</td>
								<td></td>
								<td>已授权用户</td>
							</tr>
							<tr>
								<td id="freeuserselect"><select multiple="multiple"
									id="freeuser" style="height:300px; width:200px">
								</select>
								</td>
								<td id="sutworkerselect"><select multiple="multiple"
									id="sutworker" style="height:300px; width:200px">
								</select>
								</td>
								<td><table>
										<tr>
											<td><input class="btn" style="width:60px" id="add"
												value=">">
											</td>
										</tr>
										<tr>
											<td><input class="btn " style="width:60px" id="add_all"
												value=">>">
											</td>
										</tr>
										<tr>
											<td><input class="btn" style="width:60px" id="remove"
												value="<">
											</td>
										</tr>
										<tr>
											<td><input class="btn" style="width:60px"
												id="remove_all" value="<<">
											</td>
										</tr>
									</table>
								</td>
								<td id="manageselect"><select multiple="multiple"
									id="manage" style="height:300px; width:200px">
								</select>
								</td>
								<td id="workerselect"><select multiple="multiple"
									id="worker" style="height:300px; width:200px">
								</select>
								</td>
								<td><input style="display:none" id="managerstring"
									name="managerstring" value="managerstring">
								</td>
								<td><input style="display:none" id="workerstring"
									name="workerstring" value="workerstring">
								</td>
								<td><input style="display:none" id="sut_id" name="sut_id"
									value="<%=sut_id%>">
								</td>
							</tr>
							<tr style="text-align:center">
								<td colspan="3"><input type="button"
									class="btn btn-primary" style="width:80px;"
									onClick="updateroleac()" value="更新">
								</td>
							</tr>
						</table>
					</div>
				</fieldset>
			</form>
		</div>
		<!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>