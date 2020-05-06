<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营销活动</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#searchForm").attr("action","${ctxsys}/actor/countResult");
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/actor/list">活动结果列表</a></li>
		<li class="active"> <a href="${ctxsys}/actor/countResult">活动结果统计</a></li>
	</ul>
	
	<form:form id="searchForm" modelAttribute="ebPromotion" action="${ctxsys}/actor/countResult" method="post" class="breadcrumb form-search ">
		
		<ul class="ul-form">
		<li><label>中奖时间：</label>
			<input class="small" type="text" style=" width: 100px;" name="date" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${date}" placeholder="请输入下单开始时间"/>
		</li> 
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		</li>
			
		</ul>
	</form:form>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>奖品名称</th><th>中奖数量</th></tr></thead>
		<tbody>
		<c:forEach items="${list}" var="list1">
			<tr>
				<c:forEach items="${list1}" var="list2">
				<td>${list2 }</td>
				</c:forEach>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>