<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbAftersale/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbAftersale/list">申请列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebAftersale" action="${ctxsys}/EbAftersale/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="saleId" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入编号"/></li>
		    <li><form:input path="orderId" htmlEscape="false" maxlength="50" class="input-medium" placeholder="请输入订单编号"/></li>
			<li><form:select path="applicationType"  htmlEscape="false" maxlength="50"  class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="1">退货</form:option>  
                   <form:option value="2">换货</form:option>
               </form:select>  
		    </li>
		 	<li><form:select path="status"  htmlEscape="false" maxlength="50"  class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="1">成功</form:option>  
                   <form:option value="2">正在处理</form:option>
                   <form:option value="3">失败</form:option>
               </form:select>  
		    </li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>商品名称</th>
		<th>类型</th>
		<th>总金额</th>
		<th class="sort-column applicationTime">时间</th>
		<th>状态</th>
		<shiro:hasPermission name="merchandise:aftersale:edit">
		<th>删除</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="aftersaleList" >
			<tr>
			 	<td>${aftersaleList.saleNo}</td>
			    <td>${aftersaleList.productName}</td>
				<td>
					<c:choose>
					 <c:when test="${aftersaleList.applicationType==0}">退货退款</c:when>
			      		 <c:when test="${aftersaleList.applicationType==1}">退货</c:when>
			      		 <c:when test="${aftersaleList.applicationType==2}">换货</c:when>
					</c:choose>
				</td>
				<td>${aftersaleList.deposit}</td>
				<td>${aftersaleList.applicationTime}</td>
				<td>
					<c:choose>
			      		<c:when test="${aftersaleList.status==0}">创建服务单</c:when>
			      		<c:when test="${aftersaleList.status==1}">审核中</c:when>
						<c:when test="${aftersaleList.status==2}">审核通过</c:when>
						<c:when test="${aftersaleList.status==3}">退款</c:when>
						<c:when test="${aftersaleList.status==4}">换货</c:when>
						<c:when test="${aftersaleList.status==5}">退款中</c:when>
						<c:when test="${aftersaleList.status==6}">换货已完成</c:when>
						<c:when test="${aftersaleList.status==7}">完成售后</c:when>
						<c:when test="${aftersaleList.status==8}">审核不通过</c:when>
						<c:when test="${aftersaleList.status==9}">商家已确定收货</c:when>
					</c:choose>
				</td>
			   <shiro:hasPermission name="merchandise:aftersale:edit">
			   <td>
			   	 	<a href="${ctxsys}/EbAftersale/form?saleId=${aftersaleList.saleId}">修改</a>
					<a href="${ctxsys}/EbAftersale/deleteAftersale?saleId=${aftersaleList.saleId}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>