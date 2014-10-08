var error = {
	'inputnull' : "此处不能为空",
	'inputlength' : "输入超过最大最大字符长度(60)",
	'inputinvalid' : "输入格式不合法",
};

function applysutac() {
	if (sessionUser != "null") {
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
			$("#description").parent()
					.after(
							"<div class='errormsg'>系统描述" + error.inputlength
									+ "</div>");
			return false;
		}
		document.applysutform.action = "${pageContext.request.contextPath}/applySut.action";
		$("#applysutform").submit();
	} else {
		alert("请登录后再提交表单!");
	}
}