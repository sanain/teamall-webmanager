<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>规格列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/PmProductTypeSpertAttr/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>
  <c:if test="${fulte==1}">
	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxweb}/shop/PmProductTypeSpertAttr/list?productTypeId=${productTypeId}">规格属性列表</a></li>
	<li>
	   <a href="${ctxweb}/shop/PmProductTypeSpertAttr/from?productTypeId=${productTypeId}">规格属性添加</a>
	</li>
	</ul>
	 <form:form id="searchForm" modelAttribute="sbProductTypeSpertAttr" action="${ctxweb}/shop/PmProductTypeSpertAttr/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<form:hidden path="productTypeId" value="${productTypeId}" />
		 <ul class="ul-form">
		    <li><label>属性/规格名:</label><form:input path="spertAttrName" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入名称"/></li>
			<li><label>类型：</label>
			 <form:select path="spertAttrType">
			   <form:option value="">请选择</form:option>
			   <form:option value="1">规格</form:option>
			   <form:option value="2">属性</form:option>
			 </form:select>
			</li>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul> 
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123">序号</th>
		<th class="center123">商品分类</th>
		<th class="center123">属性/规格名称</th>
		<th class="center123">类型</th>
		<th class="center123" style="display: none">显示方式</th>
		<th class="center123" style="display: none">前台显示方式</th>
		<th class="center123" style="display: none">录入类型</th>
		<th class="center123">前台搜索显示</th>
		<th class="center123">后台显示</th>
			<th class="center123">来源</th>
		<th class=" center123 sort-column orderNo">序号</th>
		<th class="center123">操作</th>
		</tr>
		<c:forEach items="${page.list}" var="sbProductTypeSpertAttrList" varStatus="status" >
			 <tr>
			    <td class="center123"><a>${status.index+1}.</a></td>
			    <td class="center123">${fns:getsbProductTypeName(sbProductTypeSpertAttrList.productTypeId).productTypeName}</td>
			    <td class="center123">${sbProductTypeSpertAttrList.spertAttrName}</td>
				<td class="center123">
					<c:if test="${sbProductTypeSpertAttrList.spertAttrType==1}">规格</c:if>
					<c:if test="${sbProductTypeSpertAttrList.spertAttrType==2}">属性</c:if>
				</td>
				<td class="center123" style="display: none">
				    <c:if test="${sbProductTypeSpertAttrList.showType==1}">平铺</c:if>
					<c:if test="${sbProductTypeSpertAttrList.showType==2}">下拉</c:if>
					<c:if test="${sbProductTypeSpertAttrList.showType==3}">多选</c:if>
				</td>
				<td class="center123" style="display: none">
				    <c:if test="${sbProductTypeSpertAttrList.frontShowType==1}">文字</c:if>
					<c:if test="${sbProductTypeSpertAttrList.frontShowType==2}">图片</c:if>
				</td>
				<td class="center123" style="display: none">
				    <c:if test="${sbProductTypeSpertAttrList.entryType==1}">手工录入</c:if>
					<c:if test="${sbProductTypeSpertAttrList.entryType==2}">列表选择</c:if>
				</td>
				<td class="center123">
				    <c:if test="${sbProductTypeSpertAttrList.isFrontShow==0}">不显示</c:if>
					<c:if test="${sbProductTypeSpertAttrList.isFrontShow==1}">显示</c:if>
				</td>
				<td class="center123">
				     <c:if test="${sbProductTypeSpertAttrList.isBackShow==0}">不显示</c:if>
					<c:if test="${sbProductTypeSpertAttrList.isBackShow==1}">显示</c:if>
				</td>
				 <td class="center123"><c:if test="${empty sbProductTypeSpertAttrList.shopId}">平台</c:if>
					 <c:if test="${not empty sbProductTypeSpertAttrList.shopId}">${sbProductTypeSpertAttrList.shopName}</c:if>
				 </td>
				<td class="center123">${sbProductTypeSpertAttrList.orderNo}</td>
			   	 <td class="center123">
			   	    <a href="${ctxweb}/shop/PmProductTypeSpertAttrValue/list?spertAttrId=${sbProductTypeSpertAttrList.id}">明细</a>
			   	 	<a href="${ctxweb}/shop/PmProductTypeSpertAttr/from?id=${sbProductTypeSpertAttrList.id}">
						<c:if test="${not empty sbProductTypeSpertAttrList.shopId&&sbProductTypeSpertAttrList.shopId==shopId}">修改
						</c:if>
						<c:if test="${empty sbProductTypeSpertAttrList.shopId||sbProductTypeSpertAttrList.shopId!=shopId}">查看
						</c:if>
					</a>
					 <c:if test="${not empty sbProductTypeSpertAttrList.shopId&&sbProductTypeSpertAttrList.shopId==shopId}">
					<a href="${ctxweb}/shop/PmProductTypeSpertAttr/delete?id=${sbProductTypeSpertAttrList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
					 </c:if>
				 </td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	</c:if>
</body>
</html>