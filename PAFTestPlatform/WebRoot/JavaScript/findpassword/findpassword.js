function findpassword(){
	$(".errormsg").remove();
	if(IsStringNull($("#alias").val())){
		$("#alias").parent().after("<div class='errormsg'>用户名不能为空</div>");
		return false;
	}
	$("#findpwdForm").submit();
}