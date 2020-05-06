<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ebSwitch/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbSwitch/list">活动列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li><a href="${ctxsys}/EbSwitch/form">活动添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>活动类型</th><th>活动状态</th><shiro:hasPermission name="merchandise:Donation:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebSwitch" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td><c:if test="${ebSwitch.type==0}">ios内购开关</c:if></td>
				<td><c:if test="${ebSwitch.state==0}">关闭</c:if><c:if test="${ebSwitch.state==1}">开启</c:if></td>
			   <shiro:hasPermission name="merchandise:Donation:edit"><td>
				   <a href="${ctxsys}/EbSwitch/form?id=${ebSwitch.id}">修改</a>
					<a href="${ctxsys}/EbSwitch/delete?id=${ebSwitch.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>