<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/sys/office/list1?isAgent=1">代理机构列表</a></li>
		<shiro:hasPermission name="sys:office:edit"><li><a href="${ctxsys}/sys/office/form1">代理机构添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<tr><th>机构名称</th><th>机构编码</th><th>机构类型</th><th>备注</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${list}" var="office">
			<tr id="${office.id}" pId="${office.parent.id ne requestScope.office.id?office.parent.id:'0'}">
				<td><a href="${ctxsys}/sys/office/form1?id=${office.id}">${office.name}</a></td>
				<td>${office.code}</td>
				<td>${fns:getDictLabel(office.type, 'sys_office_type', '无')}</td>
				<td>${office.remarks}</td>
				<shiro:hasPermission name="sys:office:edit"><td>
				    <c:if test="${office.grade!=1&&office.type==1}"><a href="${ctxsys}/sys/office/form2?id=${office.id}">高级操作</a></c:if>
					<a href="${ctxsys}/sys/office/form1?id=${office.id}">修改</a>
					<a href="${ctxsys}/sys/office/delete1?id=${office.id}" onclick="return confirmx('要删除该机构及所有子机构项吗？', this.href)">删除</a>
					<c:if test="${office.type==1}"><a href="${ctxsys}/sys/office/form1?parent.id=${office.id}">添加下级机构</a> </c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
</body>
</html>