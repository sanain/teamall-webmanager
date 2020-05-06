<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},${fns:getProjectName()}分场列表"/>
	<meta name="Keywords" content="${fns:getProjectName()},${fns:getProjectName()}分场列表"/>
	<title>${fns:getProjectName()}分场列表</title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/AgentShopInfo");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/AgentShopInfo">${fns:getProjectName()}分场列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmAgentShopInfo" action="AgentShopInfo" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label>分场类型:</label>
		       <form:select path="agentShopType" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="1">${fns:getProjectName()}分场</form:option>
		         <form:option value="2">商户分场</form:option>
		       </form:select>
		    </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th>代理名称</th>
		 <th>分场名称</th>
		 <th>分场简介</th>
		 <th>分场描述</th>
		 <th>创建时间</th>
		 <th>修改时间</th>
		 <th>状态</th>
		 <th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="pmAgentShopInfo">
			<tr>
			<c:if test="${!empty pmAgentShopInfo.agentId}">
				<td>${pmAgentShopInfo.sysOffice.name}</td>
			</c:if>
			<c:if test="${empty pmAgentShopInfo.agentId}">
				<td>${fns:getProjectName()}分场</td>
			</c:if>
				<td>${pmAgentShopInfo.agentShopName}</td>
			    <td>${pmAgentShopInfo.agentShopIntroduce}</td>
			    <td>${pmAgentShopInfo.agentShopDescribe}</td>
			    <td><fmt:formatDate value="${pmAgentShopInfo.createTime}" type="both"/></td>
			    <td><fmt:formatDate value="${pmAgentShopInfo.modifyTime}" type="both"/></td>
			    <td>
			    	<c:if test="${pmAgentShopInfo.isDelete==0}">显示</c:if>
			    	<c:if test="${pmAgentShopInfo.isDelete==1}">隐藏</c:if>
				    <shiro:hasPermission name="merchandise:AgentShopInfo:edit">
				    <c:if test="${pmAgentShopInfo.isDelete==0}">
				    		<a onclick="return confirmx('是否隐藏？', '${ctxsys}/AgentShopInfo/isDelete?isDelete=1&id=${pmAgentShopInfo.id}')" href="javascript:;">隐藏</a>
	 			    	</c:if>
				    	<c:if test="${pmAgentShopInfo.isDelete==1}">
				    		<a onclick="return confirmx('是否显示？', '${ctxsys}/AgentShopInfo/isDelete?isDelete=0&id=${pmAgentShopInfo.id}')" href="javascript:;">显示</a>
				    	</c:if>
				    </shiro:hasPermission>
				</td>
			    <td>
				    <shiro:hasPermission name="merchandise:AgentShopInfo:view">
						<a href="${ctxsys}/AgentShopInfo/form?id=${pmAgentShopInfo.id}">查看</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>