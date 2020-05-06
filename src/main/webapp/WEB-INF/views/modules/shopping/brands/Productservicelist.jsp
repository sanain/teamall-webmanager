<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>标签列表</title>
	<script type="text/javascript">
		 function page(n,s){
				if(n) $("#pageNo").val(n);
			    if(s) $("#pageSize").val(s);
			          $("#searchForm").attr("action","${ctxsys}/EbLabel");
			          $("#searchForm").submit();
			    	return false;
			    }
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbLabel/list">标签列表</a></li>
		<shiro:hasPermission name="merchandise:EbLabel:edit"><li><a href="${ctxsys}/EbLabel/form">标签添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebLabel" action="${ctxsys}/EbLabel/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	    <ul class="ul-form">
		    <li><label>名称:</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"   placeholder=""/></li>
		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
	    <th>编号</th>
		<th>名称</th>
		<th>类型</th>
		<th>创建人</th>
		<th>创建时间</th>
		<shiro:hasPermission name="merchandise:EbLabel:edit">
		<th>操作</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="ebLabel" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td>${ebLabel.name}</td>
				<td><c:if test="${ebLabel.labelType==1}">商品</c:if><c:if test="${ebLabel.labelType==2}">文章</c:if></td>
				<td>${ebLabel.createUser}</td>
				<td>${ebLabel.createTime}</td>
			   <shiro:hasPermission name="merchandise:EbLabel:edit"><td>
					<a href="${ctxsys}/EbLabel/form?id=${ebLabel.id}">修改</a>
					<a href="${ctxsys}/EbLabel/delete?id=${ebLabel.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>