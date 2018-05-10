<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_tags.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>查询用户</title>
</head>
<body>
<div id="accordion" class="accordion">
	<div class="accordion-group">
		<div class="accordion-heading">
			<div class="title">系统管理&gt;账号管理&gt;账号列表</div>
		</div>
		<div id="addAccordion" class="accordion-body in">
			<div class="accordion-inner" style="border: 0px solid red;">
				<div style="border: 0px solid red; height: 33px;">
					<form:form action="list.do" method="post" modelAttribute="user" cssClass="form-inline">
						<label>账号名/姓名
						<form:input path="name"/>
						</label>
						<label>状态</label>
						<form:select path="status" cssStyle="width:70px;">
							<form:option value="">所有</form:option>
							<c:forEach items="${operstatu}" var="item">
								<form:option value="${item.key}">${item.value}</form:option>
							</c:forEach>
						</form:select>
							<button id="search" class="lt_query" onmouseover="this.className='lt_query2'" onmouseout="this.className='lt_query'" onclick="$('#user').submit(); return false;"></button>
							<lt:img menuName="账号管理" moduleName="系统管理"></lt:img>
					</form:form>
				</div>
				<table class="table table-hover table-condensed" >
					<thead>
						<tr >
							<th width="4%"><input id="checkAll" name="checkAll" type="checkbox" style="margin-top: 0px;">全选</th>
							<th width="15%">账号名</th>
							<th width="15%">姓名</th>
							<th width="15%">账号角色</th>
							<th width="15%">上次登录时间</th>
							<th width="15%">账号状态</th>
							<th >备注</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pb.dataList}" var="user" varStatus="vs">
							<tr>
								<td>
									<%-- <c:if test="${userInfo.id != user.id && user.id != 55}"> --%>
										<input name="checkItem" type="checkbox" value="${user.id}" style="margin-top: 0px;">
									<%-- </c:if> --%>
								</td>
								<td>${user.userid}</td>
								<td>${user.nickname}</td>
								<td>
									<c:forEach items="${user.roles}" var="role" varStatus="vs2">
										[${role.name}]
									</c:forEach>
								</td>
								<td>
									<fmt:formatDate value="${user.lastLoginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<div  style="vertical-align: top;padding-top: 5px;">
										<c:choose>
											<c:when test="${userInfo.id != user.id && user.id != 55}">
												<select id="userstatu${vs.index}" style="width: 70px; vertical-align: top;">
													<c:forEach items="${operstatu}" var="item">
														<option <c:if test="${item.key==user.status}" >selected="selected"</c:if> value="${item.key}" >${item.value}</option>
													</c:forEach>
												</select>
											</c:when>
											<c:otherwise>
												<c:forEach items="${operstatu}" var="item">
													<c:if test="${item.key==user.status}" >${item.value}</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>										
										<c:if test="${userInfo.id != user.id && user.id != 55}">
											<lt:img menuName="账号管理" moduleName="系统管理" privilegeName="更新状态"
												clickMethod="changeStatus('${user.status}','${user.id}','#userstatu${vs.index}');" clickName="更新"></lt:img>
										</c:if>
									</div>									
								</td>
								<td style="word-wrap:break-word;word-break:break-all;">
								    <c:choose>
										<c:when test="${fn:length(user.remark) > 20}">
											${fn:substring(user.remark, 0, 20)} ...
										</c:when>
										<c:otherwise>
											${user.remark}
										</c:otherwise>
								</c:choose>
							</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="7" form-id="user" class="paginationPanel"><ltPage:page pageBean="${pb}" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

//修改账号状态
function changeStatus(oldid,userid,statuid)
{
	var statusId = $(statuid).val();
	if(statusId == oldid)
	{
		showSimpleMessage("请更换状态后再提交！");
		return;
	}
	window.location.href = "${path}/system/user/updateStatus.do?id="+userid+"&newStatus="+statusId;
}

</script>
</body>
</html>