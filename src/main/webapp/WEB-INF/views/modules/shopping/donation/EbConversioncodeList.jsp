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
			$("#searchForm").attr("action","${ctxsys}/EbConversioncode/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbConversioncode/list">积分个数列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebConversioncode" action="${ctxsys}/EbRedcontaining/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<li><form:select path="status" >
		<form:option value="">请选择</form:option>
		<form:option value="1">已领取</form:option>
		<form:option value="2">未领取</form:option>
		<form:option value="3">已使用</form:option>
		<form:option value="4">过期</form:option>
		</form:select></li>
		<li><form:input path="conversionCode"  htmlEscape="false" maxlength="50" placeholder="兑换码查询"/></li>
		<li><form:hidden path="redcontainingId" id="redcontainingId" htmlEscape="false" maxlength="50" /></li>
		<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>优惠名称</th><th>开始时间</th><th>结束时间</th><th>使用时间</th><th>领取时间</th><th>兑换码</th><th>用户</th><th>状态</th></tr>
		<c:forEach items="${page.list}" var="ebConversioncodeList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>${ebConversioncodeList.redcontainingName}</td>
				<td>${ebConversioncodeList.startTime}</td>
				<td>${ebConversioncodeList.stopTime}</td>
				<td>${ebConversioncodeList.employTime}</td>
				<td>${ebConversioncodeList.drawTime}</td>
				<td>${ebConversioncodeList.conversionCode}</td>
				<td>${ebConversioncodeList.userName}</td>
				<td><c:if test="${ebConversioncodeList.status==1}">已领取</c:if><c:if test="${ebConversioncodeList.status==2}">未领取</c:if><c:if test="${ebConversioncodeList.status==3}">已使用</c:if><c:if test="${ebConversioncodeList.status==4}">过期</c:if></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>