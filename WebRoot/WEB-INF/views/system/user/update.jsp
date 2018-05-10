<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_tags.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改账号</title>
</head>
<body>
<style>
.help-inline{
	color:red;
}
</style>
<div id="accordion" class="accordion">
	<div class="accordion-group">
		<div class="accordion-heading">
			<div class="title">系统管理&gt;账号管理&gt;修改账号</div>
		</div>
		<div id="addAccordion" class="accordion-body in">
			<div class="accordion-inner">
				<form:form action="update.do" method="post" modelAttribute="user" cssClass="form-horizontal">
					<c:set var="useridError"><form:errors path="userid"></form:errors></c:set>
					<c:set var="nicknameError"><form:errors path="nickname"></form:errors></c:set>
					<c:set var="passwordError"><form:errors path="password"></form:errors></c:set>
					<c:set var="rolesError"><form:errors path="roles"></form:errors></c:set>
					
					<div class="control-group${empty useridError?'':' error'}">
						<label class="control-label" for="userid"><span class="help-inline input_msg_style">*</span>账号名</label>
						<div class="controls">
							<form:input path="userid" maxlength="20" disabled="true"/>
						</div>
					</div>
					<div class="control-group${empty nicknameError?'':' error'}">
						<label class="control-label" for="nickname">姓名</label>
						<div class="controls">
							<form:input path="nickname"/>
							<span class="help-inline"></span>
							<%-- <span class="help-inline">${empty nicknameError?'最大长度为20个字符':nicknameError}</span> --%>
						</div>
					</div>
					<div class="role control-group${empty rolesError?'':' error'}">
						<label class="control-label"><span class="help-inline input_msg_style">*</span>角色</label>
						<div class="controls">
							<c:choose>
								<c:when test="${user.id == 55 || userInfo.id == user.id}">
									<form:select  id="rolevalue" path="roles[0].id" >
										<form:option value="">请选择</form:option>
										<c:forEach items="${roles}" var="role" varStatus="vs">
											<c:if test="${user.roles[0].id == role.id}">
												<form:option value="${role.id}">${role.name}</form:option>
											</c:if>
										</c:forEach>
									</form:select>
									<span class="help-block">${rolesError}</span>
								</c:when>
								<c:otherwise>
									<form:select  id="rolevalue" path="roles[0].id" >
										<form:option value="">请选择</form:option>
										<c:forEach items="${roles}" var="role" varStatus="vs">
											<c:choose>
												<c:when test="${user.roles[0].id == 35}">
													<c:if test="${role.id == 35}">
														<form:option value="${role.id}">${role.name}</form:option>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${role.id != 35}">								
														<form:option value="${role.id}">${role.name}</form:option>
													</c:if>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</form:select>
									<span class="help-block">${rolesError}</span>
								</c:otherwise>
							</c:choose>		
						</div>
					</div>
					<div class="role control-group">
						<label class="control-label">密码重置</label>
						<div class="controls">
							<form:select path="isreset">
								<form:option value="0">否</form:option>
								<form:option value="1">是</form:option>
							</form:select>
							<span class="help-block">${rolesError}</span>							
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="remark">备注</label>
						<div class="controls">
							<form:textarea path="remark" rows="3" cols="20" />
							<span class="help-inline"></span>
						</div>
					</div>
					<div class="form-actions">
						<form:hidden path="id"/>
						<button  class="lt_sys_commit" type="submit"
							onmouseover="this.className='lt_sys_commit2'" onmouseout="this.className='lt_sys_commit'">&nbsp;</button>
				    	<button id="btn_back" class="lt_sys_back" type="button" 
							onmouseover="this.className='lt_sys_back2'" onmouseout="this.className='lt_sys_back'">&nbsp;</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
jQuery(document).pc({province:'', city:'city', defaultProvince:'420000', defaultCity:'${user.city}'});

$('#checkall').click(function(){
	$('label.checkbox').find(':checkbox').each(function(i, ele){
		if($(ele).is(':checked')){
			$(ele).removeAttr('checked');
		}else{
			$(ele).attr('checked', 'checked')
		}
	});
});

jQuery.validator.addMethod('word', function(value, element){
	return /^[a-zA-Z0-9]+$/.test(value);
});
$('#user').validate({
	submitHandler: function(form){
		var value = $('#rolevalue').val();
		if(value==null || value == ""){
			$('#rolevalue').addClass('error');
			//$('#rolevalue').find('span').text('<spring:message code="user.roles.min"/>');
			$('#rolevalue').next().css("color","red").text('<spring:message code="user.roles.min"/>');
			return false;
		}else{
			form.submit();
		}
	},
	rules:{
		userid:"word",
		nickname: {
               maxlength: 20,		
		},
		remark:{
			maxlength:200
		}
	},
	messages:{
		userid:'<spring:message code="user.userid.invalid"/>',
		//nickname:'姓名的最大长度为5个字符'
		nickname:'最长为20个字符',
		remark:"长度不能超过200个字符"
	},
	onfocusout: function(element) {
        $(element).valid();
    },
    errorElement: 'span',
    errorPlacement: function(error, element) {
		error.appendTo(element.next());
	}
    /* errorClass: 'help-inline', */
   	/* highlight: function(element, errorClass) {
    	$(element).parents('.control-group').addClass('error');
    	$(element).next().next().html('')
  	},
  	unhighlight: function(element, errorClass, validClass) {
    	$(element).parents('.control-group').removeClass('error');
    	$(element).next().next().html('');
  	} */
});

$(function(){
	var roles = [];
	<c:forEach items="${user.roles}" var="role">
		roles.push(${role.id});
	</c:forEach>
	for(var i=0; i<roles.length; ++i){
		$('input[type=checkbox][value='+roles[i]+']').attr('checked', 'checked');
	}
});

//响应返回按钮事件
$('#btn_back').click(function(){
	window.location.href = '${returnURI}';
})

//当角色改变时取消红色提示
$('#rolevalue').change(function(){
	$('#rolevalue').next().text('');
});
</script>
</body>
</html>