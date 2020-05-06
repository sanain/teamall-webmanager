<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营销活动</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/lottery/list">奖品池列表</a></li>
		</ul>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>奖品名称</th><th>奖品池区间开始值</th><th>奖品池区间结束值</th><th>奖品池剩余数量</th><shiro:hasPermission name="lottery:info:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${ebPrizeList}" var="ebPrize">
			<tr>
				<td>${ebPrize.prizeName }</td>
				<td>${ebPrize.begin }</td>
				<td>${ebPrize.end }</td>
				<td>${ebPrize.number }</td>
				<shiro:hasPermission name="lottery:info:edit">
				<td><a href="${ctxsys}/lottery/form?ebPrizeId=${ebPrize.prizeId }">修改</a></td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>