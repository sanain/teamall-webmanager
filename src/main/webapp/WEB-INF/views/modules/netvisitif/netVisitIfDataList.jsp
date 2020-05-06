<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>网络问诊案例数据</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/netvisitif/netvisitifdata/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/netvisitif/netvisitifdata/list">网络问诊案例数据列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="netVisitIfData" action="${ctxsys}/netvisitif/netvisitifdata/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>接诊医院：</label><form:input path="hosName" htmlEscape="false" maxlength="100" class="input-xxlarge"/></li>
			<li><label>科室：</label><form:input path="depName" htmlEscape="false" maxlength="100" class="input-xxlarge"/></li>
			<li class="clearfix"></li>
			<li><label>患者名：</label><form:input path="nameCn" htmlEscape="false" maxlength="100" class="input-medium"/></li>
			<li><label>患者电话：</label><form:input path="mphone" htmlEscape="false" maxlength="100" class="input-medium"/></li>
			<li><label>患者身份证：</label><form:input path="warrantNum" htmlEscape="false" maxlength="100" class="input-medium"/></li>
			<li class="clearfix"></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul><br>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>接诊医院</th><th>问诊医生姓名</th><th>医生所属科室</th><th>就诊病种</th><th>就诊患者名</th><th>患者性别</th><th>患者年岭</th><th>患者身份证</th><th>患者电话</th><th>就诊时间</th><th>就诊情况说明（医生主诉）</th><th>系统接收时间</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="netVisitIfData">
			<tr>
				<td>${netVisitIfData.hosName}</td>
				<td>${netVisitIfData.doctorName}</td>
				<td>${netVisitIfData.depName}</td>
				<td>${netVisitIfData.diseaseName}</td>
				<td>${netVisitIfData.nameCn}</td>
				<td>${netVisitIfData.sex}</td>
				<td>${netVisitIfData.age}</td>
				<td>${netVisitIfData.warrantNum}</td>
				<td>${netVisitIfData.mphone}</td>
				<td>${netVisitIfData.visitTime}</td>
				<td>${netVisitIfData.complaint}</td>
				<td>${netVisitIfData.param1}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>