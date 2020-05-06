<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>品牌列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmProductTypeBrand/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>
   <c:if test="${fulte==1}">
	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/PmProductTypeBrand/list?productTypeId=${productTypeId}">品牌列表</a></li>
	<li><shiro:hasPermission name="merchandise:PmProductTypeBrand:edit"><a href="${ctxsys}/PmProductTypeBrand/from?productTypeId=${productTypeId}">品牌添加</a></shiro:hasPermission></li>
	</ul>
	</c:if>
	<c:if test="${fulte==1}">
	 <form:form id="searchForm" modelAttribute="sbProductTypeBrand" action="${ctxsys}/PmProductTypeBrand/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<form:hidden path="productTypeId" value="${productTypeId}" />
		 <ul class="ul-form">
		    <li><label>品牌名称:</label><form:input path="brandName" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入品牌名称"/></li>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul> 
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123">序号</th>
		<th class="center123">商品分类</th>
		<th class="center123">品牌名称</th>
		<th class="center123">品牌图片</th>
		<th class="center123 sort-column orderNo">序号</th>
		<th class="center123">操作</th>
		</tr>
		<c:forEach items="${page.list}" var="sbProductTypeBrandList" varStatus="status" >
			 <tr>
			    <td class="center123"><a>${status.index+1}.</a></td>
			    <td class="center123">${fns:getsbProductTypeName(sbProductTypeBrandList.productTypeId).productTypeName}</td>
			    <td class="center123">${sbProductTypeBrandList.brandName}</td>
				<td class="center123"><img alt="" src="${sbProductTypeBrandList.brandLogo}" width="30" height="30"></td>
				<td class="center123">${sbProductTypeBrandList.orderNo}</td>
			  <%--  <shiro:hasPermission name="merchandise:SbProductTypeBrand:edit"> --%>
			   	 <td class="center123">
			   	 	<a href="${ctxsys}/PmProductTypeBrand/from?id=${sbProductTypeBrandList.id}">修改</a>
					<a href="${ctxsys}/PmProductTypeBrand/delete?id=${sbProductTypeBrandList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				 </td>
				<%-- </shiro:hasPermission> --%>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	</c:if>
</body>
</html>