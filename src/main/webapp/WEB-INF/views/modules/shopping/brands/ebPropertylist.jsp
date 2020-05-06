<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">.table td i{margin:0 2px;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3});
		});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbProperty/list?productId=${productId}">商品属性列表</a></li>
		<shiro:hasPermission name="merchandise:pro:edit"><li><a href="${ctxsys}/EbProperty/form?productId=${productId}">商品属性添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-striped table-bordered table-condensed " >
			<tr><th>名称</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="merchandise:pro:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach items="${EbProperty}" var="menu">
				<tr id="${menu.id}" pId="${menu.parent.id ne '1' ? menu.parent.id : '0'}">
					<td><i class="icon-"></i><a href="${ctxsys}/EbProperty/form?id=${menu.id}&productId=${productId}">${menu.propertyName}</a></td>
					<td></td>
					<td></td>
					<td></td>
					<shiro:hasPermission name="merchandise:pro:edit"><td>
						<a href="${ctxsys}/EbProperty/form?id=${menu.id}&productId=${productId}">修改</a>
						<a href="${ctxsys}/EbProperty/delete?id=${menu.id}&productId=${productId}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>
						<a href="${ctxsys}/EbProperty/form?parent.id=${menu.id}&productId=${productId}">添加下级菜单</a> 
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
		</table>
		
	 </form>
</body>
</html>