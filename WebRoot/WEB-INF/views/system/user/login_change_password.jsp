<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/common_tags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>ITV广告管理系统</title>
<link rel="stylesheet" type="text/css"
	href="/SecurityLoginDemo/resources/css/bootstrap.min.css">
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background: #448ab8;
}

#wrapper {
	position: relative;
	left: 50%;
	margin-left: -512px;
	width: 1024px;
	height: 600px;
	background: url(/SecurityLoginDemo/resources/img/login.jpg) no-repeat;
}

#userid {
	position: absolute;
	width: 147px; 
	height: 18px;
	left: 680px;
	top: 229px;
}

#password {
	position: absolute;
	width: 147px; 
	height: 18px;
	left: 680px;
	top: 262px;
}

#verifyCode {
	position: absolute;
	width: 72px; 
	height: 18px;
	left: 680px;
	top: 296px;
}

#verifyCodeIMG {
	position: absolute;
	width: 70px; 
	height: 28px;
	left: 770px;
	top: 296px;
}

#btnLogin {
	background: none repeat scroll 0 0 transparent;
    border: none;
    cursor: pointer;
    height: 27px;
    left: 701px;
    position: absolute;
    top: 347px;
    width: 90px;
}

.loginError {
	color: red;
	position: absolute;
	left:685px; 
	top:380px;
	font-size: 12px;
}

/**确定按钮		 默认*/
.lt_user_sure {
	background-image: url('/SecurityLoginDemo/resources/img/sure_before.png');
	border-style: none;
	width: 54px;
	height: 26px;
	background-repeat: no-repeat;
}

/**确定按钮		聚焦*/
.lt_user_sure2 {
	background-image: url('/SecurityLoginDemo/resources/img/sure_focus.png');
	border-style: none;
	width: 54px;
	height: 26px;
	background-repeat: no-repeat;
}

</style>
<link rel="stylesheet" type="text/css"
	href="/SecurityLoginDemo/resources/css/bootstrap-responsive.min.css">
<script type="text/javascript" src="/SecurityLoginDemo/resources/js/jquery.min.js"></script>
<script type="text/javascript"
	src="/SecurityLoginDemo/resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
	if (self != top) {
		top.location = self.location;
	}
	window.history.forward();
	function noBack() {
		window.history.forward();
	}
</script>
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();"
	onunload="">
	<div id="wrapper">
		<form action="user/change_self_password.do" id="change_self_password" method="get">
			<input type="hidden" name="userid" id="userid" value="${userid}" />
		</form>
	</div>
	
	<!-- 强行登陆提示框 -->
<div id="forcetips" class="modal hide fade" style="width: 365px; height: 160px;">
	<div class="modal-header" style="height: 28px;line-height: 28px;">
	  	&nbsp;&nbsp;<b>提示框</b>
 	</div>
	<div id="cont" class="modal-body" align="center" style="height: 60px;">
	  	<p>登陆成功，您的密码不符合规范:【${info}】，请立即进行修改</p>
	</div>
    <div class="modal-footer" style="height: 23px;">
    	<button class="lt_user_sure" type="button" onclick="submitForm()"
			onmouseover="this.className='lt_user_sure2'" onmouseout="this.className='lt_user_sure'">&nbsp;</button>
    </div>
</div>
	
	<script type="text/javascript">
		$('#forcetips').modal();
		function submitForm()
		{
			$('#change_self_password').submit();
		}
	</script>
</body>
</html>