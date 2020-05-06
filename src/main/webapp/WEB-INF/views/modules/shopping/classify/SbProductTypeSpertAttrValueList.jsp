<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>规格属性值列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmProductTypeSpertAttrValue/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/PmProductTypeSpertAttrValue/list?spertAttrId=${spertAttrId}">规格属性明细列表</a></li>
	<li>
		<%-- <shiro:lacksPermission name="merchandise:PmProductTypeSpertAttrValue:edit"> --%>
		   <a href="${ctxsys}/PmProductTypeSpertAttrValue/from?spertAttrId=${spertAttrId}">规格属性明细添加</a>
		<%-- </shiro:lacksPermission> --%>
	</li>
	</ul>
	 <form:form id="searchForm" modelAttribute="sbProductTypeSpertAttrValue" action="${ctxsys}/PmProductTypeSpertAttrValue/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<form:hidden path="spertAttrId" value="${spertAttrId}" />
		 <ul class="ul-form">
		    <li><label>属性/规格值:</label><form:input path="spertAttrValue" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入名称"/></li>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul> 
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th  class="center123">序号</th>
		<th  class="center123">标准值</th>
		<th  class="center123">规格/属性名</th>
		<th  class="center123">属性/规格值</th>
		<th  class="center123">规格图片</th>
		<th  class=" center123 sort-column orderNo">序号</th>
		<th  class="center123">操作</th>
		</tr>
		<c:forEach items="${page.list}" var="sbProductTypeSpertAttrValueList" varStatus="status" >
			 <tr>
			    <td  class="center123">${status.index+1}</td>
				 <td  class="center123">${sbProductTypeSpertAttrValueList.shopName}</td>
			    <td  class="center123">${fns:getSbProductTypeSpertAttr(sbProductTypeSpertAttrValueList.spertAttrId).spertAttrName}</td>
			    <td  class="center123">${sbProductTypeSpertAttrValueList.spertAttrValue}</td>
				<td  class="center123">${sbProductTypeSpertAttrValueList.spertUrl}</td>
				<td  class="center123">${sbProductTypeSpertAttrValueList.orderNo}</td>
			  <%--  <shiro:hasPermission name="merchandise:SbProductTypeBrand:edit"> --%>
			   	 <td  class="center123">
			   	 	<a href="${ctxsys}/PmProductTypeSpertAttrValue/from?id=${sbProductTypeSpertAttrValueList.id}">修改</a>
					<a href="${ctxsys}/PmProductTypeSpertAttrValue/delete?id=${sbProductTypeSpertAttrValueList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				 </td>
				<%-- </shiro:hasPermission> --%>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>