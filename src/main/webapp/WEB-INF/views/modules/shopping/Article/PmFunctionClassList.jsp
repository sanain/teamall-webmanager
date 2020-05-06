<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>功能图片列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmFunctionClass");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmFunctionClass">功能图片列表</a></li>
		<li ><a href="${ctxsys}/PmFunctionClass/form">功能图片<shiro:hasPermission name="merchandise:PmFunctionClass:edit">${not empty PmFunctionClass.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmQaHelp:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmFunctionClass" action="${ctxsys}/PmFunctionClass" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><label>关键词:</label><form:input path="functionClassCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入编码"/></li>
		        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">功能分类编码</th>
		 <th class="center123">功能分类名称</th>
		 <th class="center123">状态</th>
		 <th class="center123">功能分类图标URL</th>
		 <th class="center123">连接URL</th>
		 <th class="center123">排序</th>
		  <shiro:hasPermission name="merchandise:PmFunctionClass:edit">
		 <th class="center123">操作</th>
		  </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="PmFunctionClassList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/PmFunctionClass/form?id=${PmFunctionClassList.id}">${PmFunctionClassList.functionClassCode}</a></td>
				<td class="center123">${PmFunctionClassList.functionClassName}</td>
				<td class="center123"><c:if test="${PmFunctionClassList.status==0}">不显示</c:if><c:if test="${PmFunctionClassList.status==1}">显示</c:if></td>
				<td class="center123"><img src="${PmFunctionClassList.functionClassIconUrl}" width="40px" height="40px"/></td>
				<td class="center123">${PmFunctionClassList.linkUrl}</td>
				<td class="center123">${PmFunctionClassList.sortnum}</td>
			    <shiro:hasPermission name="merchandise:PmFunctionClass:edit">
			    <td class="center123">
					<a href="${ctxsys}/PmFunctionClass/form?id=${PmFunctionClassList.id}">修改</a>
					<a href="${ctxsys}/PmFunctionClass/delete?id=${PmFunctionClassList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>