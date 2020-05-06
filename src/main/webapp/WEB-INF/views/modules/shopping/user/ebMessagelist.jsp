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
			$("#searchForm").attr("action","${ctxsys}/ebMessage/list");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/ebMessage">消息列表</a></li>
		<shiro:hasPermission name="merchandise:ebMessage:view"><li><a href="${ctxsys}/ebMessage/form">消息添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebMessage" action="${ctxsys}/ebMessage" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		   <li><form:input path="messageTitle" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入关键字"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr><th>消息编号</th><th>消息标题</th><th>消息类型</th><th>消息时间</th><th>状态</th><shiro:hasPermission name="merchandise:ebMessage:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebMessage">
			<tr>
			    <td>${ebMessage.id}</td>
				<td><a href="${ctxsys}/ebMessage/form?id=${ebMessage.id}">${ebMessage.messageTitle}</a></td>
				<td><c:if test="${ebMessage.messageType==1}">系统消息</c:if><c:if test="${ebMessage.messageType==2}">真心话消息</c:if>
				<c:if test="${ebMessage.messageType==3}">圈子消息</c:if><c:if test="${ebMessage.messageType==4}">订单消息</c:if>
				<c:if test="${ebMessage.messageType==5}">物流消息</c:if><c:if test="${ebMessage.messageType==6}">支付消息</c:if>
				</td>
				<td>${ebMessage.messageTime}</td>
				<td><c:if test="${ebMessage.messageState==1}">已读消息</c:if><c:if test="${ebMessage.messageState==2}">未读消息</c:if><c:if test="${ebMessage.messageState==3}">隐藏消息</c:if></td>
			   <shiro:hasPermission name="merchandise:ebMessage:edit"><td>
					<a href="${ctxsys}/ebMessage/form?id=${ebMessage.id}">修改</a>
					<a href="${ctxsys}/ebMessage/delete?id=${ebMessage.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>