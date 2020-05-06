<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>就诊卡列表</title>
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
			<th>编号</th>
			<th>就诊人姓名</th>
			<th>就诊卡号</th>
			<th>就诊卡所属医院</th>
		</tr>
		<c:forEach items="${page.list}" var="userCard">
			<tr>
				<td>${userCard.cardid}</td>
				<td>${userCard.usercontactPeople.username}</td>
				<td>${userCard.cardNo}</td>
				<td>${userCard.hospital.name}</td>
			</tr>
		</c:forEach>
	</table>
	<div style="float:left; display:inline;" class="pagination">${page}</div>&nbsp;&nbsp;&nbsp;&nbsp;
	<div style="float:left; display:inline;margin-top: 10px;"><input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></div>
</body>
</html>