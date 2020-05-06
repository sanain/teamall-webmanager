<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbAdvertise/list?layouttypeId=${ebAdvertise.layouttypeId}");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbAdvertise/list?layouttypeId=${ebAdvertise.layouttypeId}">广告列表</a></li>
		<shiro:hasPermission name="merchandise:EbArticle:edit"><li><a href="${ctxsys}/EbAdvertise/form?layouttypeId=${ebAdvertise.layouttypeId}">广告添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebAdvertise" action="${ctxsys}/EbAdvertise" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		  <li><label>名字:</label><form:input path="advertiseName"  htmlEscape="false" maxlength="80" class="input-medium"/> </li>
		   <form:hidden path="layouttypeId"/>
		  <li><label>广告类型:</label>
		  <form:select path="advertiseType"  htmlEscape="false"  class="input-medium">
		    <form:option value="">全部</form:option>
		    <form:option value="1">类别</form:option>
		    <form:option value="2">商品</form:option>
		    <form:option value="3">链接</form:option>
		    <form:option value="4">商家</form:option>
		    <form:option value="5">文章</form:option>
		    <form:option value="6">关键词</form:option>
			<form:option value="7">专区倍数</form:option>
			<form:option value="8">邀请好友</form:option>
		  </form:select> 
		  </li>
		  <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr><th>编号</th><th>广告名称</th><th>广告类型</th><th>模板</th><th>排序</th><th>状态</th><shiro:hasPermission name="merchandise:EbArticle:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="EbAdvertiselist" varStatus="status">
			<tr>
			   <td>${status.index+1}</td>
				<td><a href="${ctxsys}/EbAdvertise/form?id=${EbAdvertiselist.id}">${EbAdvertiselist.advertiseName}</a></td>
				<td>
					<c:if test="${EbAdvertiselist.advertiseType==1}">类别</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==2}">商品</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==3}">链接</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==4}">商家</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==5}">文章</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==6}">关键词</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==7}">专区倍数</c:if>
					<c:if test="${EbAdvertiselist.advertiseType==8}">邀请好友</c:if>
				</td>
				<td>${EbAdvertiselist.layouttypeName}</td>
				<td>${EbAdvertiselist.orderNo}</td>
				<td><c:if test="${EbAdvertiselist.status==0}">开启</c:if><c:if test="${EbAdvertiselist.status==1}">隐藏</c:if><c:if test="${EbAdvertiselist.status==2}">删除</c:if></td>
			   <shiro:hasPermission name="merchandise:EbArticle:edit"><td>
					<a href="${ctxsys}/EbAdvertise/form?id=${EbAdvertiselist.id}">修改</a>
					<a href="${ctxsys}/EbAdvertise/delete?id=${EbAdvertiselist.id}" onclick="return confirmx('要删除广告项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>