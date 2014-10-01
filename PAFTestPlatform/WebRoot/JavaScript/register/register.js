var error = {
	'inputnull' : "此处不能为空",
	'inputlength' : "输入超过最大最大字符长度",
	'inputinvalid' : "输入格式不合法",
};


function signupFormCheck(){
	$(".errormsg").remove();
	if(IsStringNull($("#regAlias").val())){
		$("#regAlias").parent().after("<div class='errormsg'>"+ error.inputnull+"</div>");
		return false;
		}
	if(IsStringNull($("#regDisplayName").val())){
		$("#regDisplayName").parent().after("<div class='errormsg'>"+ error.inputnull+"</div>");
		return false;
		}
	if(IsOutOfLength($("#telephone").val(),20)){
		$("#telephone").parent().parent().parent().after("<div class='errormsg'>联系电话"+ error.inputlength+"</div>");
		return false;
		}
	if(IsOutOfLength($("#mobile").val(),20)){
		$("#mobile").parent().parent().parent().after("<div class='errormsg'>移动电话"+ error.inputlength+"</div>");
		return false;
		}
	if(!IsNumeric($("#telephone").val())){
		$("#telephone").parent().parent().parent().after("<div class='errormsg'>联系电话"+ error.inputinvalid+"</div>");
		return false;
		}
	if(!IsNumeric($("#mobile").val())){
		$("#mobile").parent().parent().parent().after("<div class='errormsg'>移动电话"+ error.inputinvalid+"</div>");
		return false;
		}
	if(!IsValidateEmail($("#othermail").val())){
		$("#othermail").parent().after("<div class='errormsg'>邮件"+ error.inputinvalid+"</div>");
		return false;
		}
	if(IsOutOfLength($("#otherinfo").val(),60)){
		$("#otherinfo").parent().after("<div class='errormsg'>用户备注"+ error.inputlength+"</div>");
		return false;
		}
	$("#signupForm").submit();

}




