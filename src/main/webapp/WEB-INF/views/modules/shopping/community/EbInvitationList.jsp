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
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbInvitation/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbInvitation/list?CirclesId=${CirclesId}">帖子列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebInvitation" action="${ctxsys}/EbInvitation/list" method="post" class="breadcrumb form-search ">
		<input id="CirclesId" name="CirclesId" type="hidden" value="${CirclesId}"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<li><form:input path="invitationTitle" placeholder="请输入关键字" htmlEscape="false" maxlength="50"/></li>
		<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>帖子标题</th><th>发帖人</th><th>发帖时间</th><th>品论数</th><th>打赏数</th><th>状态</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebInvitationList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>${ebInvitationList.invitationTitle}</td>
				<td>${ebInvitationList.ebUser.username}</td>
				<td>${ebInvitationList.time}</td>
				<td>${ebInvitationList.commentNum}</td>
				<td>${ebInvitationList.tipNum}</td>
				<td><c:if test="${ebInvitationList.state==1}">审核通过</c:if><c:if test="${ebInvitationList.state==2}">待审核</c:if><c:if test="${ebInvitationList.state==3}">删除</c:if><c:if test="${ebInvitationList.state==4}">审核不通过</c:if></td>
			   <shiro:hasPermission name="merchandise:community:edit"><td>
					<a href="${ctxsys}/EbInvitation/form?id=${ebInvitationList.id}">修改</a>
					<a href="${ctxsys}/EbInvitation/delete?id=${ebInvitationList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>