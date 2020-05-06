<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/sys/user/info">用户信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="#" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">归属公司:</label>
			<div class="controls">
				<input type="text" name="company" value="${user.company.name}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属部门:</label>
			<div class="controls">
				<input type="text" name="office" value="${user.office.name}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工号:</label>
			<div class="controls">
				<input type="text" name="no" value="${user.no}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<form:input path="loginName" htmlEscape="false" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户类型:</label>
			<div class="controls">
				<select name="userType" disabled="disabled">
					<option value="" label="请选择" />
					<c:forEach items="${fns:getDictList('sys_user_type')}" var="type">
						<option value="${type.value }" label="${type.label }" selected="${user.userType==type.value?'selected':'' }"/>
					</c:forEach>
				</select>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls">
				<c:forEach items="${allRoles}" var="role">
					<input type="checkbox" name="userType" value="${role.id }" disabled="disabled" ${user.roleIdList.contains(role.id)?'checked':'' }>${role.name }
				</c:forEach>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" readonly="true"/>
				<tags:ckeditor replace="remarks" uploadPath="/news/advertise" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间:</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最后登陆:</label>
			<div class="controls">
				<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</div>
</body>
</html>