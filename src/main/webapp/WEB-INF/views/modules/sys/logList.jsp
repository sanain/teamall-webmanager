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
		<li class="active"><a href="${ctxsys}/sys/log/">操作日记列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="sysLog" action="${ctxsys}/sys/log/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>创建者 ：</label><form:input path="createBy.loginName" htmlEscape="false" maxlength="50" class="input-medium"/>
		<label>IP地址 ：</label><form:input path="remoteAddr" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th>创建者</th>
		<th>IP地址</th>
		<th>操作URI</th>
		<th>操作方式</th>
		<th>提交数据</th>
		<th>用户代理信息</th>
		<th>创建时间</th>
		<th>详情</th>
		<tbody>
		<c:forEach items="${page.list}" var="sysLog">
			<tr>
				<td>${sysLog.createBy.loginName}</td>
				<td>${sysLog.remoteAddr}</td>
				<td>${sysLog.requestUri}</td>
				<td>${sysLog.method}</td>
				<td title='${sysLog.params}'>${fns:abbr(sysLog.params,35)}</td>
				<td title='${sysLog.userAgent}'>${fns:abbr(sysLog.userAgent,35)}</td>
				<td><fmt:formatDate value="${sysLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<th><a href="${ctxsys}/sys/log/detail?id=${sysLog.id}">查看详情</a></th>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>