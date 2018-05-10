<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/common_tags.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body >
  	<script type="text/javascript">
  		$(document).ready(function(){
  			var h = $(window).height();
  			var w = $(window).width();
			$('#welcome').height(h-101);
			$('#wbgmg').css("margin-left",w-1028-235);
			$('#wcimg').css("margin-top",-(h/2+104));
  		})
  	</script>
  	<table id="welcome" style="width: 100%;height: 100%;" bgcolor="green" align="center">
  		<tr>
  			<td bgcolor="#e9fbff"></td>
  			<td bgcolor="#e9fbff"></td>
  		</tr>
  		<tr >
  			<td bgcolor="#e9fbff"></td>
  			<td width="1007px" height="628px" >
  				<img src="${path}/resources/img/welcome_bg.jpg" style="margin-left: -1px;margin-top: -1px;width: 1007px;height: 628px;">
  			</td>
  		</tr>  		
  	</table>
  	<img id="wcimg" src="${path}/resources/img/welcome.png" style="margin-left: 228px;margin-top: -534px;position: absolute;">
  	</body>
</html>
