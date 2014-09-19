$(document).ready(function(){
  
});

var error = {
	'inputnull' : "此处不能为空",
};


function signupFormCheck(){
	if(IsStringNull($("#regAlias").val())){
		$("#regAlias").parent().after("<div class='errormsg'>"+ error.inputnull+"</div>");
		return false;
		}

}




