function loginac(){
	document.loginForm.action = "${pageContext.request.contextPath}/login.action";
	document.loginForm.submit();
}
//全角判断
function quanjiao(obj)
{
    var str=obj.value;
    if (str.length>0)
    {
        for (i = str.length-1; i >= 0; i--)
        {
            unicode=str.charCodeAt(i);
            if (unicode>65280 && unicode<65375)
            {
                alert("不能输入全角字符，请输入半角字符");
				 obj.value=str.substr(0,i);
            }
        }
		 
    }
}
//Email地址判断
function IsEmail( str ){ 
var myReg = /^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/;
if(myReg.test(str)) return true;
return false;
}

function IsValidateEmail(str) {
    //如果为空，则通过校验
    if (str == "" || str.length == 0) {
        return false;
    }

    //正则表达式
    //var pattern = /^\w{1,}@[\.,\w]{1,}$/;
    var pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
    if (!pattern.test(str)) {
        return false;
    }
    return true;
} 



//是否为空判断
function IsStringNull(str) {
    if (str == null)
        return true;
    var trimStr = $.trim(str);
    if (trimStr.length == 0)
        return true;
    return false;
}
//判断是否超出字符
function IsOutOfLength(str, len) {
    var strLength = 0;
    for (var i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) > 256) {
            strLength++;
        }
        strLength++;
        if (strLength > len) {
            return true;
        }
    }
    return false;
} 
//判断字符是否为数字
function IsNumeric(strNumber) {
    if (strNumber.length == 0) {
        return false;
    }
    return (strNumber.search(/^(-|\+)?\d+(\.\d+)?$/) != -1);
}

//判断是否是手机号
function IsValidateMobile(str) {
    var pattern = /^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$/;
    if (str == '' || str.length == 0) {
        return false;
    }
    if (!pattern.test(str)) {
        return false;
    }
    return true;
} 

//判断是否是电话号码
function IsValidatePhone(str) {
    var pattern = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
    if (str == '' || str.length == 0) {
        return false;
    }
    if (!pattern.test(str)) {
        return false;
    }
    return true;
} 

