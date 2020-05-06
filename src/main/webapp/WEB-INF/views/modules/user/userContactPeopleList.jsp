<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>联系人列表</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
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
		<li class="active"><a href="${ctxsys}/user/userContactPeople/">联系人列表</a>
		</li>
	</ul>
	<tags:message content="${message}" />
	<table id="userContactPeopleTable"
		class="table table-striped table-bordered table-condensed">
		<tr>
			<th>姓名</th>
			<th>证件号码</th>
			<th>手机号</th>
			<th>居住地</th>
			<!-- <th>操作</th> -->
		</tr>
		<c:forEach items="${page.list}" var="userContactPeople">
			<tr>
				<td>${userContactPeople.username}</td>
				<td>${userContactPeople.zjNo}</td>
				<td>${userContactPeople.mobileNo}</td>
				<td>${userContactPeople.location}</td>
				<!-- <td><a href="${ctxsys}/user/user/userContactPeople?id=${userContactPeople.peopleid}">就诊卡列表</a></td> -->
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>