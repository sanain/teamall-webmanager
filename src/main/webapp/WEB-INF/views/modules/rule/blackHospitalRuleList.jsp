<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>医院黑名单规则管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">

	function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctxsys}/rule/blackHospitalRule/list");
		$("#searchForm").submit();
		return false;
	}
    
   
</script>
<script type="text/javascript" charset="utf-8"
	src="/jqyy-mainweb/js/datepicker/WdatePicker.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/rule/blackHospitalRule/list">医院爽约黑名单规则管理</a></li>
		<shiro:hasPermission name="rule:blackHospitalRule:edit">
		   <li>
		      <a href="${ctxsys}/rule/blackHospitalRule/form">医院爽约黑名单规则添加</a>
		   </li>
	    </shiro:hasPermission>
	</ul>
	
    <tags:message content="${message}"/>
    <form:form id="searchForm" modelAttribute="blackListHospitalRule" action="${ctxsys}/rule/blackHospitalRule/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>黑名单机构：</label>
		<tags:treeselect id="blackHospital" name="blackHospital.hospitalId" value="${blackListHospitalRule.blackHospital.hospitalId}" labelName="blackHospital.name" labelValue="${blackListHospitalRule.blackHospital.name}" 
				title="医院" url="${ctxsys}/rule/blackHospitalRule/treeDataHospital" cssClass="input-small" allowClear="true" />
        &nbsp;&nbsp;
        
	    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<tr><th>医院名</th><th>黑名单规则</th><th>录入人</th><th>备注</th><th>时间</th><shiro:hasPermission name="rule:blackHospitalRule:view"><th>操作</th></shiro:hasPermission></tr>
		<tbody>
		<c:forEach items="${page.list}" var="blackHospitalRule">
			<tr id="${blackHospitalRule.id}" >
			    <td>${blackHospitalRule.blackHospital.name}</td>
			    <td>${blackHospitalRule.month}个月内爽约${blackHospitalRule.missNumber}次</td>
			    <td>${blackHospitalRule.handle.name}</td>
				<td>${blackHospitalRule.remarks}</td>
				
				<td>${fn:substring(blackHospitalRule.updateDate,0,19)}</td>

				<shiro:hasPermission name="rule:blackHospitalRule:edit">
					<td>
	                    <a href="${ctxsys}/rule/blackHospitalRule/form?id=${blackHospitalRule.id}">修改</a>
						<a href="${ctxsys}/rule/blackHospitalRule/blackHospitalRuleDelete?id=${blackHospitalRule.id}" onclick="return confirmx('要删除该医院黑名单规则吗?', this.href)">删除</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>