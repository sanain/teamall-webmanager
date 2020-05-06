<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>敏感词列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmSensitiveWords");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmSensitiveWords">敏感词列表</a></li>
		<li ><a href="${ctxsys}/PmSensitiveWords/form">敏感词<shiro:hasPermission name="merchandise:PmSensitiveWords:edit">${not empty pmSensitiveWords.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmSensitiveWords:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmSensitiveWords" action="${ctxsys}/PmSensitiveWords" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><label>名称:</label><form:input path="sensitiveWords" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入"/></li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">名称</th>
		 <th class="center123">状态</th>
		 <th class="center123">最后修改人</th>
		 <th class="sort-column modifyTime center123">最后修改时间</th>
		  <shiro:hasPermission name="merchandise:PmSensitiveWords:edit">
		 <th class="center123">操作</th>
		  </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="PmSensitiveWordsList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/PmSensitiveWords/form?id=${PmSensitiveWordsList.id}">${PmSensitiveWordsList.sensitiveWords}</a></td>
				<td class="center123"><c:if test="${PmSensitiveWordsList.delFlag==0}">不显示</c:if><c:if test="${PmSensitiveWordsList.delFlag==1}">显示</c:if></td>
				<td class="center123">${PmSensitiveWordsList.modifyUser}</td>
				<td class="center123">${PmSensitiveWordsList.modifyTime}</td>
			   <shiro:hasPermission name="merchandise:PmSensitiveWords:edit">
			    <td class="center123">
					<a href="${ctxsys}/PmSensitiveWords/form?id=${PmSensitiveWordsList.id}">修改</a>
					<a href="${ctxsys}/PmSensitiveWords/delete?id=${PmSensitiveWordsList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>