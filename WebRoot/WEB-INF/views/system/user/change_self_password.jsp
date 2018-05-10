<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_tags.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改密码</title>
</head>
<body>
<style type="text/css">
	.help-inline{
		color:red;
	}
</style>
<link rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/bootstrap-tagsinput.css">
<link id="skinUri" rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/${ cookie['skin'] != null ? cookie['skin'].value:'main'}.css">
<link rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/buttonstyle.css" />
<link rel="stylesheet" type="text/css" href="/SecurityLoginDemo/resources/css/privilege.imgbutton.css" />

<!-- validate的js库文件引入顺序也要注意，jquery-1.8.3.js要放在第一位，jquery.validate.min.js第二位，否则会报错 -->
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/additional-methods.js"></script>
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/messages_cn.js"></script>


<div id="accordion" class="accordion">
	<div class="accordion-group">
		<div class="accordion-heading">
			<div class="title">系统管理&gt;账号管理&gt;修改密码</div>
		</div>
		<div id="addAccordion" class="accordion-body in">
			<div class="accordion-inner">
				<form:form action="change_self_password.do" modelAttribute="user" method="post" cssClass="form-horizontal">
					<c:set var="oldPasswordError"><form:errors path="oldPassword"></form:errors></c:set>
					<c:set var="newPasswordError"><form:errors path="newPassword"></form:errors></c:set>
					<div class="control-group${empty oldPasswordError?'':' error'}">
						<label class="control-label" for="oldPassword"><span class="help-inline input_msg_style">*</span>旧密码</label>
						<div class="controls">
							<form:password path="oldPassword" maxlength="20"/>
							<span class="help-inline">${oldPasswordError}</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="newPassword"><span class="help-inline input_msg_style">*</span>新密码</label>
						<div class="controls">
							<form:password path="newPassword" maxlength="20"/>
							<span class="help-inline">${newPasswordError}</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="newPassword2"><span class="help-inline input_msg_style">*</span>新密码确认</label>
						<div class="controls">
							<form:password path="newPassword2" maxlength="20"/>
							<span class="help-inline"></span>
						</div>
					</div>
					<div class="form-actions">
						<form:hidden path="userid"/>
						<button class="lt_sys_commit" type="submit" 
									onmouseover="this.className='lt_sys_commit2'" onmouseout="this.className='lt_sys_commit'">&nbsp;</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
<!-- 头部登陆者信息 -->
		<div style="margin-top: 62px;height:22px;position: absolute;border: 0px solid red;width: 100%;" align="right">
			<a href="#" id="cps_logout" onclick="showSure('1');" style="text-decoration: none;padding-right: 10px;">注销</a>
		</div>
	<!-- 确定弹出框 -->
<div id="system_out_sure" style="position:absolute;top:0px;left:0px;">
	<div class="system_out_top">
		<div>提示框</div>
		<div class="delete" onclick="cancle('#system_out_sure')"></div>
	</div>
	<div class="system_out_center">
		<div id="sure_font" style="position:absolute;top:60px;left:80px;color:#9A9A9A;letter-spacing:1px;">
			
		</div>
	</div>
	<div class="system_out_bottom">
		<input type="hidden" id="outtype" name="outtype">
		<div class="sure_btn" onclick="logout()"></div>
		<div class="cancle" onclick="cancle('#system_out_sure')" ></div>
	</div>
</div>
<script type="text/javascript">
//弹出退出确认框
function showSure(type)
{
	$('#outtype').val(type);
	if(type == 1){
		$('#sure_font').html("确定要注销当前账号？");
	}else{
		$('#sure_font').html("确定要退出系统？");
	}
	$("#system_out_sure").show();
}	
//注销账号或退出系统
function logout()
{
	var type = $('#outtype').val();
	window.location.href = "${path}/system/logout.do?outType="+type;
}

$('#user').validate({
	
	rules:{
		oldPassword: 'required',  
		newPassword:{  
            required: true,  
            regexPassword: true,  
            rangelength: [8, 15], 
            same: true,  
            compare: true
        },  
        newPassword2: { 
        	required: true, 
        	equalTo: "#newPassword" 
        }  
        
        
	},
	messages:{
		oldPassword: '<spring:message code="user.oldpassword.required"/>',  
		newPassword:  
        {  
            required: '<spring:message code="user.newpassword.required"/>',  
            regexPassword: '<spring:message code="user.newpassword.regex"/>',  
            rangelength: '<spring:message code="user.newpassword.length"/>', 
            same:'<spring:message code="user.newpassword.norepeat"/>',
            compare:'<spring:message code="user.newpassword.repeatToAccount"/>'
        },  
        newPassword2: {  
             required: '<spring:message code="user.newpassword2.required"/>',  
             equalTo: '<spring:message code="user.newpassword2.mismatch"/>'  
         }  


	},
	onfocusout: function(element) {
        $(element).valid();
    },
  	errorElement:"span", 
	errorPlacement: function(error, element) {
		error.appendTo(element.next());
	}
});

jQuery.validator.addMethod("same", function(value, element) {  
    return this.optional(element) || same(value);  
}, '<spring:message code="user.newpassword.norepeat"/>'); 
 
jQuery.validator.addMethod("regexPassword", function(value, element) {  
//    return this.optional(element) || /^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/.test(value);  
    return this.optional(element) || /^(?=.*[0-9]{1,})(?=.*[a-zA-Z]{1,})(?=.*[^a-zA-Z0-9]{1,}).{8,15}$/.test(value);  
}, '<spring:message code="user.newpassword.regex" />');  

jQuery.validator.addMethod("compare", function(value, element) { 
	//debugger;
	var newPassword = $("#newPassword").val();
    var userid = $("#userid").val();
    var count = getSameChar(newPassword,userid); 
    if(count>=3)
    {
    	return false;
    }
    else
    {
    	return true;
    }
   // return this.optional(element) || same(value);  
}, '<spring:message code="user.newpassword.repeatToAccount"/>'); 

function same(pwd) {  
    var oldPwd = $("#oldPassword").val();  
    if (oldPwd == pwd)  
        return false;  
    else  
        return true;  
} 
//账号和密码出现相同的，只算一次
function getSameChar(s1, s2) 
{
	var c;// 相同字符
	var samenum = s1.split(""); // 数组same用于控制：如果s1字符串中有相同的字符，则只输出一次
	// 如s1为aabc s2为a 则只输出1次a 而不是两次
	var count = 0, j;// 与数组same相关的变量
	var i, k;// 循环变量
	
	console.info(s1 + "与" + s2 + "相同的字符有");
	for (i = 0; i < s1.length; i++) 
	{
		c = s1.charAt(i);
		out:for (k = 0; k < s2.length; k++) 
		{
			if (c == (s2.charAt(k))) 
			{
				for (j = 0; j < count; j++) 
				{
					// 如果字符c已经被打印过，则直接跳出循环，查找下一个
					if (c == samenum[j])
						break out;// 跳出被out标记的循环
				} 
				// 如果字符c是第一次出现，则把它添加进数组same
				samenum[count] = c;
				count++;
				if (c == ' ') {
					break;
				}

				break;
			}
		}
	}
	
	return count;
}

</script>
</body>
</html>