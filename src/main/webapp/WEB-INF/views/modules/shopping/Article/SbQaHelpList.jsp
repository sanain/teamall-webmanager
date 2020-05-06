<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问答帮助列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmQaHelp");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmQaHelp">问答帮助列表</a></li>
		<li ><a href="${ctxsys}/PmQaHelp/form">问答帮助<shiro:hasPermission name="merchandise:PmQaHelp:edit">${not empty sbServiceProtocol.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmQaHelp:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="sbQaHelp" action="${ctxsys}/PmQaHelp" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><label>名称:</label><form:input path="name" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入名称"/></li>
			<li><label>问答类型:</label><form:select path="qaType"  class="input-medium">
		           <option value="">全部</option>
		           <form:option value="1">用户</form:option>
		           <form:option value="2">店家</form:option>
		           <%--<form:option value="3">代理</form:option>--%>
               </form:select>  
		        </li>
		        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">名称</th>
		 <th class="center123">类型</th>
		 <th class="center123">状态</th>
		 <th class="center123">最后修改人</th>
		 <th class="sort-column modifyTime center123">最后修改时间</th>
		  <shiro:hasPermission name="merchandise:SbQaHelp:edit">
		 <th class="center123">操作</th>
		  </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="SbQaHelpList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/PmQaHelp/form?id=${SbQaHelpList.id}">${SbQaHelpList.name}</a></td>
				<td class="center123"><c:if test="${SbQaHelpList.qaType==1}">用户</c:if>
					<c:if test="${SbQaHelpList.qaType==2}">店家</c:if>
					<%--<c:if test="${SbQaHelpList.qaType==3}">代理</c:if>  --%>
				</td>
				<td class="center123"><c:if test="${SbQaHelpList.delFlag==0}">不显示</c:if><c:if test="${SbQaHelpList.delFlag==1}">显示</c:if></td>
				<td class="center123">${SbQaHelpList.modifyUser}</td>
				<td class="center123">${SbQaHelpList.modifyTime}</td>
			   <shiro:hasPermission name="merchandise:SbQaHelp:edit">
			    <td class="center123">
					<a href="${ctxsys}/PmQaHelp/form?id=${SbQaHelpList.id}">修改</a>
					<a href="${ctxsys}/PmQaHelp/delete?id=${SbQaHelpList.id}" onclick="return confirmx('要删除该问答帮助吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>