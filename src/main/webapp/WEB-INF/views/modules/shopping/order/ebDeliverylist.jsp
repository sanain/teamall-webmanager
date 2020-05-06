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
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbDelivery");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbDelivery">配送列表</a></li>
		<shiro:hasPermission name="merchandise:delivery:edit"><li><a href="${ctxsys}/EbDelivery/form">配送添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebDelivery" action="${ctxsys}/EbDelivery" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><form:input path="deliveryName" htmlEscape="false" maxlength="80" class="input-medium" style="width: 120px;" placeholder="请输入快递名称"/></li>
			<li><form:select path="status" style="width: 100px;" class="input-medium">
		           <option value="">请选择</option>
		           <form:option value="0"> 未开启</form:option>
					<form:option value="1">开启</form:option>
					<form:option value="9">删除</form:option>
               </form:select>  
		        </li>
		        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th>快递名称</th><th>首重重量(克)</th><th>首重价格</th><th>开启状态</th><shiro:hasPermission name="merchandise:order:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="orderlist">
			<tr>
				<td><a href="${ctxsys}/EbDelivery/form?id=${orderlist.deliveryId}">${orderlist.deliveryName}</a></td>
				<td>${orderlist.firstWeight}</td>
				<td>${orderlist.firstPrice}</td>
				<td><c:if test="${orderlist.status==1}">开启</c:if><c:if test="${orderlist.status==0}">未开启</c:if><c:if test="${orderlist.status!=1&&orderlist.status!=0}">删除</c:if></td>
			   <shiro:hasPermission name="merchandise:delivery:edit"><td>
					<a href="${ctxsys}/EbDelivery/form?id=${orderlist.deliveryId}">修改</a>
					<a href="${ctxsys}/EbDelivery/delete?id=${orderlist.deliveryId}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>