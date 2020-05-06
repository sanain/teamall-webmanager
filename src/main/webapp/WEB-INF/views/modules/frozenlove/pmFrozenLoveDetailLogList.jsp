<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="积分"/>
	<meta name="Keywords" content="积分"/>
	<title>冻结积分明细记录</title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/frozenLoveDetail");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/frozenLoveDetail">操作明细列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmFrozenLoveDetailLog" action="${ctxsys}/frozenLoveDetail" method="post" class="breadcrumb form-search ">
		<input name="frozenLoveOperateId" type="hidden" value="${pmFrozenLoveDetailLog.frozenLoveOperateId}"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		 <li><label>用户名称:</label><form:input path="userName" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户名称"/></li>
		 <li><label>用户手机:</label><form:input path="mobile" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户手机"/></li>
		    
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th>用户名称 </th>
		 <th>用户手机</th>
		 <th>冻结积分数</th>
		 <th>创建时间</th>
		</tr>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<td>${log.userName}</td>
				<td>${log.mobile}</td>
				<td><fmt:formatNumber type="number" value="${log.frozenLove}" pattern="0.0000" maxFractionDigits="4"/></td>
				<td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>