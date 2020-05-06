<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合伙人管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/sys/agent/list1?isAgent=1">合伙人列表</a></li>
		<shiro:hasPermission name="sys:agent:edit"><li><a href="${ctxsys}/sys/agent/form1?agentId=1&flag=add">合伙人添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<tr><th>合伙人名称</th><th>合伙人编码</th><th>代理类型</th><shiro:hasPermission name="sys:agent:edit"><th>邀请码</th><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${list}" var="agent">
			<tr id="${agent.agentId}" pId="${agent.parent.agentId ne requestScope.agent.agentId?agent.parent.agentId:'0'}">
				<td><a href="${ctxsys}/sys/agent/form1?agentId=${agent.agentId}&flag=edit">${agent.agentName}</a></td>
				<td>${agent.agentCode}</td>
				<td>${fns:getDictLabel(agent.agentType, 'sys_agent_type', '无')}</td>
				<td><c:if test="${agent.agentType eq '3'}" >${agent.agentInvitationCode }</c:if></td>
				<shiro:hasPermission name="sys:agent:edit"><td>
			<%-- 	<a href="${ctxsys}/sys/agent/form2?id=${agent.agentId}">高级操作</a> --%>
					<a href="${ctxsys}/sys/agent/form1?agentId=${agent.agentId}&flag=edit">修改</a>
					<a href="${ctxsys}/sys/agent/delete1?id=${agent.agentId}" onclick="return confirmx('要删除该合伙人及所有子合伙人吗？', this.href)">删除</a>
					<c:if test="${agent.agentType==1 or agent.agentType==2}"><a href="${ctxsys}/sys/agent/form1?agentId=${agent.agentId} &flag=add">添加下级合伙人</a> </c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
</body>
</html>