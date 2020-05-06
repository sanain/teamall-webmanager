<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营销活动</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/promotion/list");
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/promotion/list">活动列表</a></li>
		<li> <a href="${ctxsys}/promotion/form">活动添加</a></li>
	</ul>
	
	<form:form id="searchForm" modelAttribute="ebPromotion" action="${ctxsys}/promotion/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<li><label>活动名称：</label><form:input path="promotionName" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		</li>
			
		</ul>
	</form:form>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>活动名称</th><th>活动链接</th><th>参与人数</th><th>状态</th><shiro:hasPermission name="promotion:info:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="promotion">
			<tr>
				<td>${promotion.promotionName }</td>
				<td>${promotion.url }</td>
				<td>${promotion.peopleNum }</td>
				<c:if test="${promotion.isOpen == 1 }"><td>开启</td></c:if>
				<c:if test="${promotion.isOpen == 0 }"><td>关闭</td></c:if>
				<shiro:hasPermission name="promotion:info:edit">
				<td><a href="${ctxsys}/promotion/form?promotionId=${promotion.promotionId }">修改</a></td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>