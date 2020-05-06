<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/news/advertise/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/news/advertise/list">广告列表</a></li>
		<shiro:hasPermission name="news:advertise:edit"><li><a href="${ctxsys}/news/advertise/form">广告添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="advertise" action="${ctxsys}/news/advertise/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>名称：</label><form:input path="advertisename" htmlEscape="false" maxlength="100" class="input-xxlarge"/></li>
			<li><label style="width: 150px;">广告类型：</label><form:select id="adtypeid.adtypeid" path="adtypeid.adtypeid" class="input-medium"><form:option value="" label=""/><form:options items="${adtypeList}" itemLabel="adtypename" itemValue="adtypeid" htmlEscape="false" /></form:select></li>
			<li class="clearfix"></li>
			<li><label>摘要：</label><form:input path="adabstract" htmlEscape="false" maxlength="100" class="input-xxlarge"/></li>
			<li><label style="width: 150px;">发布位置：</label><form:select id="targetsys" path="targetsys" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('advertise_targetsys')}" itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul><br>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>广告名称</th><th>广告类型</th><th>唯一码</th><th>发布位置</th><th>广告分类</th><th>是否默认</th><th>是否禁用</th><th>创建时间</th><shiro:hasPermission name="news:advertise:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="advertise">
			<tr>
				<td>${advertise.advertisename}</td>
				<td>${advertise.adtypeid.adtypename}</td>
				<td>${advertise.adtypeonlynum}</td>
				<td>${fns:getDictLabel(advertise.targetsys, 'advertise_targetsys', '')}</td>
				<td>${advertise.adclass}</td>
				<td>${fns:getDictLabel(advertise.addefault, 'addefault', '')}</td>
				<td>${fns:getDictLabel(advertise.adenter, 'adenter', '')}</td>
				<td><fmt:formatDate value="${advertise.adcreatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="news:advertise:edit"><td>
    				<a href="${ctxsys}/news/advertise/form?advertiseid=${advertise.advertiseid}">修改</a>
    				<a href="${ctxsys}/news/advertise/delete?id=${advertise.advertiseid}" onclick="return confirmx('确认要删除该数据吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>