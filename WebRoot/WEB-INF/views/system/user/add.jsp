<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_tags.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>新增用户</title>
</head>
<body>
<div id="accordion" class="accordion">
	<div class="accordion-group">
		<div class="accordion-heading">
			<div class="title">系统管理 &gt;账号管理&gt;新增账号</div>
		</div>
		<div id="addAccordion" class="accordion-body in">
			<div class="accordion-inner" style="border: 0px solid red;">
				<form:form id="user" action="${path}/system/user/add.do" method="post" modelAttribute="user" cssClass="form-horizontal">
					<div class="control-group${empty useridError?'':' error'}" style="border: 0px solid red;">
						<label class="control-label" for="userid"><span class="help-inline input_msg_style">*</span>账号名</label>
						<div class="controls">
							<form:input id="userid" path="userid"/>
							<span style="color:red" class="help-inline"></span>
							<%-- <span class="help-inline">${empty useridError?'':useridError}</span> --%>
						</div>
					</div>
					
					<div class="control-group${empty nicknameError?'':' error'}">
						<label class="control-label" for="nickname">姓名</label>
						<div class="controls">
							<form:input path="nickname"/>
							<span style="color:red" class="help-inline"></span>
							<%-- <span class="help-inline">${empty nicknameError?'最大长度为20个字符':nicknameError}</span> --%>
						</div>
					</div>		
												
					<div class="role control-group${empty rolesError?'':' error'}">
						<label class="control-label"><span class="help-inline input_msg_style">*</span>角色</label>
						<div class="controls">
							<form:select id="rolevalue" path="roles[0].id" cssStyle="width:220px;">
								<form:option value="">请选择</form:option>
								<c:forEach items="${roles}" var="role" varStatus="vs">
									<c:if test="${role.id != 35}">
										<form:option value="${role.id}">${role.name}</form:option>
									</c:if>
								</c:forEach>
							</form:select>
							<span class="help-block">${rolesError}</span>							
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="remark">备注</label>
						<div class="controls">
							<form:textarea path="remark" rows="3" cols="20"/>
							<span style="color:red" class="help-inline"></span>
						</div>
					</div>
					<div class="form-actions">
						<button class="lt_sys_commit" type="submit" 
							onmouseover="this.className='lt_sys_commit2'" onmouseout="this.className='lt_sys_commit'">&nbsp;</button>
				    	<button id="btn_back" class="lt_sys_back" type="button" 
							onmouseover="this.className='lt_sys_back2'" onmouseout="this.className='lt_sys_back'">&nbsp;</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="SecurityLoginDemo/resources/js/pc.js"></script>
<script type="text/javascript">
	var flag = false;
	jQuery(document).pc({province:'', city:'city', defaultProvince:'420000', defaultCity:'${user.city}'});
	
	jQuery.validator.addMethod('word', function(value, element, param){
		return /^[a-zA-Z0-9]+$/.test(value);
	});
	$('#user').validate({
		rules:{
			userid:{
				required:true,
				maxlength:20,
				word:true,
				remote:{
					type:'post',
			        url: "${path}/system/user/checkUser.do",
			        data:{
			        	userId: function() 
	                    {
	                        return $("#userid").val();
	                    }
			        }
				}
			},
			nickname: {
                maxlength:20				
			},
			remark:{
				maxlength:200,
			}
		},
		messages:{
			userid:{
				required:"请输入登录账号",
				maxlength:"最长为20个字符",
				word:"只能输入英文、数字",
				remote:"登录名称已存在"
			},
			nickname:{
				maxlength:'最长为20个字符',	
			},
			remark:{
				maxlength:"长度不能超过200个字符",
			}
		},
		onfocusout: function(element) {
	        $(element).valid();
	    },
	    submitHandler: function(form){
			var value = $('#rolevalue').val();
			if(value==null || value==""){
				$('#rolevalue').addClass('error');
				$('#rolevalue').next().css("color","red").text('<spring:message code="user.roles.min"/>');
				return false;
			} 
			form.submit();
		},
	    errorElement: 'span',
	    errorPlacement: function(error, element) {
			error.appendTo(element.next());
		}
	});

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