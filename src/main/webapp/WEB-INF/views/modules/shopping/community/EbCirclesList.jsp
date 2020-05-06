<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbCircles/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbCircles/list">圈子列表</a></li>
		<shiro:hasPermission name="merchandise:community:edit"><li><a href="${ctxsys}/EbCircles/form">圈子添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ebCircles" action="${ctxsys}/EbCircles/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<li><form:input path="circlesName" placeholder="请输入名字" htmlEscape="false" maxlength="50"/></li>
		<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>圈子名称</th><th>圈子关注数</th><th>圈子状态</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="circlesList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>${circlesList.circlesName}</td>
				<td>${circlesList.attention}</td>
				<td>${circlesList.state==1?"开启":"关闭"}</td>
			   <shiro:hasPermission name="merchandise:community:edit"><td>
					<a href="${ctxsys}/EbCircles/form?id=${circlesList.id}">修改</a>
					<a href="${ctxsys}/EbCircles/delete?id=${circlesList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>