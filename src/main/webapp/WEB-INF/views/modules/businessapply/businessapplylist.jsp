<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>商家入驻</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<style type="text/css">
.ul-form li {
	margin: 5px;
}

.operating {
	margin: 5px;
	margin-left: 20px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm")
				.attr("action", "${ctxsys}/PmShopInfo/applylist");
		$("#searchForm").submit();
		return false;
	}
	$("#treeTable").treeTable({
		expandLevel : 5
	});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmShopInfo/applylist">商家入驻申请列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmShopInfo"
		action="${ctxsys}/PmShopInfo/applylist" method="post"
		class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<li>审核状态：<form:select path="reviewStatus" class="input-medium" >
				<form:option value="">请选择</form:option>
				<form:option value="0">待审核</form:option>
				<form:option value="1">已通过</form:option>
				<form:option value="2">已拒绝</form:option>
			</form:select></li>
		 
		<li>申请人姓名：<form:input path="contactName" maxlength="30"  class="input-medium" /></li>
		<li>联系方式：<form:input path="mobilePhone" maxlength="30"  class="input-medium" /></li>
		<li>企业名称：<form:input path="companyName" maxlength="30"  class="input-medium" /></li>
		<li>
		<input id="btnSubmit" class="btn btn-primary" type="submit"
			value="查询" onclick="return page();" /></li>
		</ul>
	</form:form>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
			<th></span><span>编号</span></th>
			<th>申请人姓名</th>
			<th>联系方式</th>
			<th>企业名称</th>
			<th>经营地址</th>
			<th>经营范围</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="applylist"
			varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${applylist.contactName}</td>
				<td>${applylist.mobilePhone}</td>
				<td>${applylist.companyName}</td>
				<td>${applylist.contactAddress}</td>
				<td>${applylist.licenseAppScope}</td>
				<td>
				<c:if test="${applylist.reviewStatus==0}">待审核</c:if>
				<c:if test="${applylist.reviewStatus==1}">已同意</c:if>
				<c:if test="${applylist.reviewStatus==2}">已拒绝</c:if>
				</td>
				<td><a href="${ctxsys}/PmShopInfo/businessDetail?id=${applylist.id}">查看详细</a></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>