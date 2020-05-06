<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>第三方用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/user/otherUser/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/user/otherUser/list">第三方用户列表</a></li>
		<shiro:hasPermission name="operate:otherUser:edit"><li><a href="${ctxsys}/user/otherUser/form">添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="otherUser" action="${ctxsys}/user/otherUser/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			
			<li><label style="width: 100px;">名称：</label><form:input path="realname" htmlEscape="false" maxlength="50" class="input-xxlarge"/></li>
			<li class="clearfix"></li>
			<li><label style="width: 100px;">账户是否异常：</label><form:select path="state" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('OtherUserState')}" itemLabel="label" itemValue="value"  htmlEscape="false" /></form:select></li>
			<li><label>是否开放：</label><form:select path="isopen" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('OtherUserIsopen')}" itemLabel="label" itemValue="value"  htmlEscape="false" /></form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul><br>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>第三方名称</th><th>用户名</th><th>账户是否异常</th><th>是否开放</th><shiro:hasPermission name="operate:otherUser:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="otherUser">
			<tr>
				<td>${otherUser.realname}</td>
				<td>${otherUser.name}</td>
				<td>${fns:getDictLabel(otherUser.state, 'OtherUserState', '')}</td>
				<td>${fns:getDictLabel(otherUser.isopen, 'OtherUserIsopen', '')}</td>
				<shiro:hasPermission name="operate:otherUser:edit"><td>
    				<a href="${ctxsys}/user/otherUser/form?otherid=${otherUser.otherid}">修改</a>
    				<a href="${ctxsys}/user/otherUser/delete?otherid=${otherUser.otherid}" onclick="return confirmx('确认要删除该数据吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>