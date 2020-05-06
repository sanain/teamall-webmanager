<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbTrialdetails/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>
<%-- 	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbTrialdetails/list">试用列表</a></li>
		<shiro:hasPermission name="merchandise:audit:edit"><li><a href="${ctxsys}/EbTrialdetails/form">审核</a></li></shiro:hasPermission>
	</ul> --%>
	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbTrialdetails/list">试用列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebTrialdetails" action="${ctxsys}/EbTrialdetails/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="productNo" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入商品编号"/></li>
			<li><form:select path="status"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
		           <option value="">请选择</option>  
                   <form:option value="0">通过</form:option>  
                   <form:option value="1">未通过</form:option>
               </form:select>  
		        </li>
		     <li><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入商品名字"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		<th>排序</th>
		<th>试用商品名</th>
		<th>用户名</th>
		<th>用户手机</th>
		<th>用户身份证</th>
		<th>申请报告</th>
		<th>审核</th>
		<shiro:hasPermission name="sys:area:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="TrialdetailsList" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>${TrialdetailsList.productName}</td>
				<td>${TrialdetailsList.userName}</td>
				<td>${TrialdetailsList.userMobile}</td>
				<td>${TrialdetailsList.userIdcard}</td>
				<td>
					<c:choose>
			      		 <c:when test="${TrialdetailsList.isSend==0}">写了</c:when>
			      		 <c:when test="${TrialdetailsList.isSend==1}">没写</c:when>
					</c:choose>
				</td>
				<td>
					<c:choose>
			     			<c:when test="${TrialdetailsList.status==0}"> 通过</c:when>
			    			<c:when test="${TrialdetailsList.status==1}">未通过</c:when>
					</c:choose>
				</td>
			   <shiro:hasPermission name="merchandise:audit:edit">
			   	 <td>
					<a href="${ctxsys}/EbTrialdetails/form?id=${TrialdetailsList.trialdetailsId}">修改</a>
					<a href="${ctxsys}/EbTrialdetails/deletepro?id=${TrialdetailsList.trialdetailsId}" onclick="return confirmx('是否删除该条用户申请？', this.href)">删除</a>
				 </td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>