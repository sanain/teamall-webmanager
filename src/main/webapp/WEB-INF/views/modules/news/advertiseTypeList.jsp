<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告类型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/news/advertiseType/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/news/advertiseType/list">广告类型列表</a></li>
		<shiro:hasPermission name="news:advertiseType:edit"><li><a href="${ctxsys}/news/advertiseType/form">广告类型添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="advertiseType" action="${ctxsys}/news/advertiseType/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>类型名称：</label><form:input path="adtypename" htmlEscape="false" maxlength="100" class="input-medium"/></li>
			<li><label>标签：</label><form:input path="adtypetag" htmlEscape="false" maxlength="100" class="input-medium"/></li>
			<li><label>唯一码：</label><form:input path="adtypeonlynum" htmlEscape="false" maxlength="6" class="digits input-medium"/></li>
			<li><label style="width: 150px;">是否显示：</label><form:select id="adtypeflag" path="adtypeflag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('adtypeflag')}" itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul><br>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>广告类型名称</th><th>唯一码</th><th>标签</th><th>是否显示</th><shiro:hasPermission name="news:advertiseType:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="advertiseType">
			<tr>
				<td>${advertiseType.adtypename}</td>
				<td>${advertiseType.adtypeonlynum}</td>
				<td>${advertiseType.adtypetag}</td>
				<td>${fns:getDictLabel(advertiseType.adtypeflag, 'adtypeflag', '')}</td>
				<shiro:hasPermission name="news:advertiseType:edit"><td>
    				<a href="${ctxsys}/news/advertiseType/form?adtypeid=${advertiseType.adtypeid}">修改</a>
    				<a href="${ctxsys}/news/advertiseType/delete?id=${advertiseType.adtypeid}" onclick="return confirmx('确认要删除该数据吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>