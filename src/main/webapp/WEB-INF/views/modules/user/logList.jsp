<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/LogUserlogin/list">用户登录日志</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="logUserlogin" action="${ctxsys}/LogUserlogin/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>搜索 ：</label><form:input path="username" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th>登录账号</th>
		<th>姓名</th>
		<th>记录时间</th>
		<th>记录ip</th>
		<th>平台类型</th>
		<th>设备名称</th>
		<th>设备编号</th>
		<tbody>
		<c:forEach items="${page.list}" var="logUserlogin">
			<tr>
				<td><c:if test="${not empty logUserlogin.mobile}">${logUserlogin.mobile}</c:if>
				<c:if test="${empty logUserlogin.mobile}">${logUserlogin.openid}</c:if>
				</td>
				<td>${logUserlogin.username}</td>
				<td>${logUserlogin.loginTime}</td>
				<td>${logUserlogin.ip}</td>
				<td><c:if test="${logUserlogin.category==1}">安卓</c:if>
				<c:if test="${logUserlogin.category==2}">苹果</c:if>
				<c:if test="${logUserlogin.category==3}">微信端</c:if>
				<c:if test="${logUserlogin.category==4}">PC端</c:if>
				</td>
				<td>${logUserlogin.phoneType}</td>
				<td>${logUserlogin.imei}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>