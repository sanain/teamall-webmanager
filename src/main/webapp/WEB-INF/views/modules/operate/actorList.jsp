<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营销活动</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/actor/list");
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/actor/list">活动结果列表</a></li>
		<li> <a href="${ctxsys}/actor/countResult">活动结果统计</a></li>
	</ul>
	
	<form:form id="searchForm" modelAttribute="ebActor" action="${ctxsys}/promotion/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<li><label>奖品名称：</label><form:input path="prizeName" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
		<li><label>用户手机：</label><form:input path="mobile" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
		<li><label>中奖时间：</label>
			<input class="small" type="text" style=" width: 100px;" name="startDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${startDate}" placeholder="请输入下单开始时间"/>
		 --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入下单结束时间"/></li> 
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		</li>
			
		</ul>
	</form:form>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>奖品名称</th><th>用户手机</th><th>中奖时间</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="ebActor">
			<tr>
				<td>${ebActor.prizeName }</td>
				<td>${ebActor.mobile }</td>
				<td><fmt:formatDate value="${ebActor.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>