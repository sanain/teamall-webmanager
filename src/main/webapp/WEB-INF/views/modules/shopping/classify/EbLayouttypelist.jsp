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
			$("#treeTable").treeTable({expandLevel : 5});
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbLayouttype");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbLayouttype">模板列表</a></li>
		<shiro:hasPermission name="merchandise:layouttype:edit"><li><a href="${ctxsys}/EbLayouttype/form">模板添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebLayouttype" action="${ctxsys}/EbLayouttype" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr><th>编号</th><th>模板名称</th><th>模板类型</th><th>类型</th><th>排序</th><th>状态</th><shiro:hasPermission name="merchandise:EbArticle:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="EbLayouttypelist" varStatus="status">
			<tr>
			   <td>${status.index+1}</td>
				<td>${EbLayouttypelist.moduleTitle}</td>
				<td>
				<c:if test="${EbLayouttypelist.moduleType==1}">文章宫格列表</c:if>
				<c:if test="${EbLayouttypelist.moduleType==2}">配图广告加广告列表类别1:1:1</c:if>
				<c:if test="${EbLayouttypelist.moduleType==3}">广告加商品类别</c:if>
				<c:if test="${EbLayouttypelist.moduleType==4}">商品宫格列表</c:if>
				<c:if test="${EbLayouttypelist.moduleType==5}">首页广告</c:if>
				<c:if test="${EbLayouttypelist.moduleType==6}">热点广告</c:if>
				<c:if test="${EbLayouttypelist.moduleType==7}">热门筛选</c:if>
				</td>
			    <td>
			    <c:if test="${EbLayouttypelist.type==0}">app</c:if>
				<c:if test="${EbLayouttypelist.type==1}">h5</c:if>
				</td>
			   <td>${EbLayouttypelist.objectId}</td>
				<td><c:if test="${EbLayouttypelist.status==1}">开启</c:if><c:if test="${EbLayouttypelist.status==2}">未开启</c:if></td>
			   <shiro:hasPermission name="merchandise:layouttype:edit"><td>
					<a href="${ctxsys}/EbLayouttype/form?id=${EbLayouttypelist.id}">修改</a>
					<a href="${ctxsys}/EbAdvertise/list?EbLayouttypeid=${EbLayouttypelist.id}">查看该模板广告</a>
					<a href="${ctxsys}/EbLayouttype/delete?id=${EbLayouttypelist.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>