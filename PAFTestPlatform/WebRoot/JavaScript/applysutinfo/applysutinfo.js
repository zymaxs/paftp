$(document).ready(function(){
	inipermission();
	initSelect();
});

function initSelect() {
	var select_groupname = document.getElementById("groupname");
	for ( var i = 0; i < select_groupname.options.length; i++) {
		if (select_groupname.options[i].innerHTML == selected_groupname) {
			select_groupname.options[i].selected = true;
			break;
		}
	}

}

function inipermission() {
	if (alias == null) {
		alert("inside if");
		document.getElementById('approvebtn').style.display = "none";
		document.getElementById('rejectbtn').style.display = "none";
		document.getElementById('updatebtnTd').style.display = "none";
	} else {
		if (isAdmin == "y") {
			document.getElementById('approvebtn').style.display = "block";
			document.getElementById('rejectbtn').style.display = "block";
			document.getElementById('updatebtnTd').style.display = "block";
		} else {
			if (alias == applyer) {
				document.getElementById('approvebtn').style.display = "none";
				document.getElementById('rejectbtn').style.display = "none";
				document.getElementById('updatebtnTd').style.display = "block";
			} else if (alias != applyer) {
				document.getElementById('approvebtn').style.display = "none";
				document.getElementById('rejectbtn').style.display = "none";
				document.getElementById('updatebtnTd').style.display = "none";
			}

		}
	}
}
function loginac() {
	document.loginform.action = "${pageContext.request.contextPath}/login.action";
	document.loginform.submit();
}
function approveac() {
	document.sutinfoform.action = "${pageContext.request.contextPath}/approveSut.action?status=Pass";
	document.sutinfoform.submit();
}
function rejectac() {
	document.sutinfoform.action = "${pageContext.request.contextPath}/approveSut.action?status=Reject";
	document.sutinfoform.submit();
}
function updateac() {
	document.getElementById('sutname').readOnly = false;
	document.getElementById('code').readOnly = false;
	document.getElementById('description').readOnly = false;
	document.getElementById('show_groupname').style.display = "none";
	document.getElementById('groupname').style.display = "block";
	document.getElementById('updatebtnTd').style.display = "none";
	document.getElementById('savebtnTd').style.display = "block";

}

var error = {
	'inputnull' : "此处不能为空",
	'inputlength' : "输入超过最大最大字符长度(60)",
	'inputinvalid' : "输入格式不合法",
};
function saveac() {
	$(".errormsg").remove();
	if (IsStringNull($("#sutname").val())) {
		$("#sutname").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if (IsStringNull($("#code").val())) {
		$("#code").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if (IsStringNull($("#description").val())) {
		$("#description").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if (IsOutOfLength($("#description").val(), 60)) {
		$("#description").parent().after(
				"<div class='errormsg'>系统描述" + error.inputlength + "</div>");
		return false;
	}
	document.sutinfoform.action = "${pageContext.request.contextPath}/updateSut.action";
	document.sutinfoform.submit();

}