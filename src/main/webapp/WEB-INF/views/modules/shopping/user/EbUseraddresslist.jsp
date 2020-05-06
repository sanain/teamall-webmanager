<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户地址管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/User/EbUseraddress");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbUseraddress/list?userId=${userId}">用户地址列表</a></li>
		<shiro:hasPermission name="merchandise:user:edit"><li><a href="${ctxsys}/EbUseraddress/form?userId=${userId}">用户地址添加</a></li></shiro:hasPermission>
	</ul>
	
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>编号</th><th>收货人</th><th>收货人手机号</th><th>地址</th><th>详细地址</th><th>状态</th><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="ebUseraddress" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td>${ebUseraddress.userName}</td>
				<td>${ebUseraddress.phone}</td>
				<td>${ebUseraddress.provinces}${ebUseraddress.municipal}${ebUseraddress.district}</td>
				<td>${ebUseraddress.detailsAddress}</td>
				<td><c:if test="${ebUseraddress.status==0}">默认</c:if><c:if test="${ebUseraddress.status==1}">不默认</c:if></td>
				<shiro:hasPermission name="merchandise:user:edit"><td>
    				<a href="${ctxsys}/EbUseraddress/form?id=${ebUseraddress.addressId}&userId=${ebUseraddress.userId}">修改</a>
					<a href="${ctxsys}/EbUseraddress/delete?id=${ebUseraddress.addressId}&userId=${ebUseraddress.userId}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>