$(document).ready(function(){
	initSelect();
});

var error = {
		'inputnull' : "此处不能为空",
		'inputlength' : "输入超过最大最大字符长度",
		'inputinvalid' : "输入格式不合法",
		'pwdiserror' : "两次输入密码不一致",
		'inputpwdlength' : "密码长度6位至16位之间",
	};


function updateUserInfo() {
	$(".errormsg").remove();
	if(IsStringNull($("#displayname").val())){
		$("#displayname").parent().after("<div class='errormsg'>"+ error.inputnull+"</div>");
		return false;
		}
	if(IsOutOfLength($("#telephone").val(),20)){
		$("#telephone").parent().after("<div class='errormsg'>联系电话"+ error.inputlength+"</div>");
		return false;
		}
	if(IsOutOfLength($("#mobile").val(),20)){
		$("#mobile").parent().after("<div class='errormsg'>移动电话"+ error.inputlength+"</div>");
		return false;
		}
	if(!IsNumeric($("#telephone").val())){
		$("#telephone").parent().after("<div class='errormsg'>联系电话"+ error.inputinvalid+"</div>");
		return false;
		}
	if(!IsNumeric($("#mobile").val())){
		$("#mobile").parent().after("<div class='errormsg'>移动电话"+ error.inputinvalid+"</div>");
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
	$("#updateinfoForm").submit();
	
};


function updateUserPwd(){
	$(".errormsg").remove();
	if (IsStringNull($("#orignpassword").val())) {
		$("#orignpassword").parent().after(
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
				"<div class='errormsg'>" + error.inputpwdlength + "</div>");
		return false;
	} else if (IsOutOfLength($("#password").val(), 16)) {
		$("#password").parent().after(
				"<div class='errormsg'>" + error.inputpwdlength + "</div>");
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
	
	$("#updatepwdForm").submit();
}