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
			$("#searchForm").attr("action","${ctxsys}/EbRedcontaining/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbRedcontaining/list">优惠列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li><a href="${ctxsys}/EbRedcontaining/form">优惠添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ebRedcontaining" action="${ctxsys}/EbRedcontaining/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<li><form:input path="name" placeholder="请输入名称" htmlEscape="false" maxlength="50"/></li>
		<li><input cssClass="required"  name="stateTime" placeholder="开始时间" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebRedcontaining.stopTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" ></li> 
		<li><input cssClass="required"  name="stopTime" placeholder="结束时间" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebRedcontaining.stopTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" ></li> 
		<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>名称</th><th>开始时间</th><th>结束时间</th><th>类型</th><th>优惠类型</th><th>状态</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebRedcontainingList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>${ebRedcontainingList.name}</td>
				<td>${ebRedcontainingList.stateTime}</td>
				<td>${ebRedcontainingList.stopTime}</td>
				<td><c:if test="${ebRedcontainingList.type==1}">积分</c:if><c:if test="${ebRedcontainingList.type==2}">优惠券</c:if></td>
				<td><c:if test="${ebRedcontainingList.favorableType==0}">满减</c:if><c:if test="${ebRedcontainingList.favorableType==1}">类别优惠</c:if><c:if test="${ebRedcontainingList.favorableType==2}">满减加类别优惠</c:if><c:if test="${ebRedcontainingList.favorableType==3}">无限制</c:if></td>
				<td><c:if test="${ebRedcontainingList.status==1}">开始</c:if><c:if test="${ebRedcontainingList.status==2}">关闭</c:if></td>
			   <shiro:hasPermission name="merchandise:Donation:edit"><td>
					<a href="${ctxsys}/EbRedcontaining/form?id=${ebRedcontainingList.id}">修改</a>
					<a href="${ctxsys}/EbConversioncode/list?redcontainingId=${ebRedcontainingList.id}">查看兑换详情</a>
					<a href="${ctxsys}/EbRedcontaining/delete?id=${ebRedcontainingList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>