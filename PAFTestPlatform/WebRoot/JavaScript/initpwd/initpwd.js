var error = {
	'inputnull' : "此处不能为空",
	'inputlength' : "密码长度6位至16位之间",
	'pwdiserror' : "两次输入密码不一致"
};

function changepwdac() {
	$(".errormsg").remove();
	if (IsStringNull($("#originpassword").val())) {
		$("#originpassword").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if (IsStringNull($("#password").val())) {
		$("#password").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if (!IsOutOfLength($("#password").val(), 5)) {
		$("#password").parent().after(
				"<div class='errormsg'>" + error.inputlength + "</div>");
		return false;
	} else if (IsOutOfLength($("#password").val(), 16)) {
		$("#password").parent().after(
				"<div class='errormsg'>" + error.inputlength + "</div>");
		return false;
	}
	
	if (IsStringNull($("#confirm_password").val())) {
		$("#confirm_password").parent().after(
				"<div class='errormsg'>" + error.inputnull + "</div>");
		return false;
	}
	if ($("#confirm_password").val() != $("#password").val()) {
		$("#confirm_password").parent().after(
				"<div class='errormsg'>" + error.pwdiserror + "</div>");
		return false;
	}

	 document.updatepwdform.action ="${pageContext.request.contextPath}/changepwd.action";
	 $("#updatepwdform").submit();
}
function resendmailac() {
	document.updatepwdform.action = "${pageContext.request.contextPath}/getbakpwd.action";
	document.updatepwdform.submit();
}