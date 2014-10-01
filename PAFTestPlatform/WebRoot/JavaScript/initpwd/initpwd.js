function changepwdac() {
	document.updatepwdform.action = "${pageContext.request.contextPath}/changepwd.action";
	if ($("#updatepwdform").valid()) {
		$("#updatepwdform").submit();
	}
}
function resendmailac() {
	document.updatepwdform.action = "${pageContext.request.contextPath}/getbakpwd.action";
	document.updatepwdform.submit();
}