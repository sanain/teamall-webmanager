<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>挂号限制规则管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/rule/hospitalRegRule/list");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/rule/hospitalRegRule/">挂号限制规则列表</a></li>
		<shiro:hasPermission name="rule:reg:edit"><li><a href="${ctxsys}/rule/hospitalRegRule/form">挂号限制规则添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hospitalRegRule" action="${ctxsys}/rule/hospitalRegRule/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>所在医院：</label><tags:treeselect id="hospital" name="hospital.hospitalId" value="${hospitalRegRule.hospital.hospitalId}" labelName="hospital.name" labelValue="${hospitalRegRule.hospital.name}" 
				title="医院" url="${ctxsys}/sys/department/treeDataForHospital" cssClass="input-small" allowClear="true"/></li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th>医院名称</th>
			<th>执行星期</th>
			<th>开通时间</th>
			<th>关闭时间</th>
			<th>状态</th>
			<shiro:hasPermission name="rule:reg:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="regRule">
			<tr>
				<td>${regRule.hospital.name}</td>
				<td>
					<c:choose>  
						<c:when test="${regRule.week=='1'}">星期一 </c:when>
						<c:when test="${regRule.week=='2'}">星期二</c:when>
						<c:when test="${regRule.week=='3'}">星期三 </c:when>
						<c:when test="${regRule.week=='4'}">星期四 </c:when>
						<c:when test="${regRule.week=='5'}">星期五 </c:when>
						<c:when test="${regRule.week=='6'}">星期六 </c:when>
						<c:when test="${regRule.week=='7'}">星期日 </c:when>  
					</c:choose>  
				</td>
				<td>${regRule.startTimeHour}:${regRule.startTimeMin }</td>
				<td>${regRule.endTimeHour}:${regRule.endTimeMin }</td>
				<td>${regRule.isClose == '1' ? '启用' : '关闭'}</td>
				<td>
					<c:choose>
						<c:when test="${regRule.isClose == '1' }">
							<a href="${ctxsys}/rule/hospitalRegRule/ruleClose?id=${regRule.id}" onclick="return confirmx('确认要禁用该规则吗？', this.href)">禁用</a>
						</c:when>
						<c:when test="${regRule.isClose == '0' }">
							<a href="${ctxsys}/rule/hospitalRegRule/ruleOpen?id=${regRule.id}" onclick="return confirmx('确认要启用该规则吗？', this.href)">启用</a>
						</c:when>
					</c:choose>
	    			<a href="${ctxsys}/rule/hospitalRegRule/form?id=${regRule.id}">修改</a>
					<a href="${ctxsys}/rule/hospitalRegRule/delete?id=${regRule.id}" onclick="return confirmx('确认要删除该规则吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>