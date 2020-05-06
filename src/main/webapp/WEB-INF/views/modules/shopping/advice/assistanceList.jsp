<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>意见与建议</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/assistance/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/assistance/list">帮助</a></li>
	<li class=""><a href="${ctxsys}/assistance/form?id=${ebAssistance.id}">帮助<shiro:hasPermission name="merchandise:assistance:edit">${not empty ebAssistance.id?'修改':'添加'}</shiro:hasPermission></a></li>
	
	</ul>
	 <form:form id="searchForm" modelAttribute="ebAssistance" action="${ctxsys}/assistance/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <%--  <li><form:input path="type" htmlEscape="false" maxlength="50" class="input-medium" style="width: 150px;" placeholder="类型名字"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		 --%></ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>类型名称</th>
		<shiro:hasPermission name="merchandise:assistance:edit">
		<th>删除</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="assistancelist" varStatus="status" >
			<tr>
			 <td>${status.index+1}</td>
			    <td><c:if test="${assistancelist.type==1}">新手指导</c:if><c:if test="${assistancelist.type==2}">售后说明</c:if><c:if test="${assistancelist.type==3}">支付说明</c:if><c:if test="${assistancelist.type==4}">配送方式</c:if><c:if test="${assistancelist.type==5}">客服热线</c:if><c:if test="${assistancelist.type==6}">夺宝协议</c:if><c:if test="${assistancelist.type==7}">用户协议</c:if></td>
			   <shiro:hasPermission name="merchandise:assistance:edit">
			   	 <td>
			   	 	<a href="${ctxsys}/assistance/form?id=${assistancelist.id}">修改</a>
					<a href="${ctxsys}/assistance/delete?id=${assistancelist.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				 </td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>