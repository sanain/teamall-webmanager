<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>人员管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">

	function page(n, s) {
		if (n) $("#pageNo").val(n);
		if (s) $("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctxweb}/shop/shop/user/list");
		$("#searchForm").submit();
		return false;
	}

	$(function() {
		if ('${isSuccess}' == '1') {
			alert("编辑成功！");
		} else if ('${isSuccess}' == '0') {
			alert("已经存在相同登录名的员工！");
		}
	})
</script>

<style type="text/css">
#searchForm, #inputForm {
	background: #fff;
}

.nav-tabs>.active>a {
	border-top: 3px solid #009688;
	color: #009688;
}

.nav-tabs>li>a {
	color: #000;
}

.pagination {
	padding-bottom: 25px;
}

.ibox-content {
	margin: 0 30px;
}

body {
	background: #f5f5f5;
}

.ibox-content {
	background: #fff;
}

.nav {
	margin-bottom: 0;
}

.form-horizontal {
	margin: 0;
}

.breadcrumb {
	background: #fff;
	padding: 0;
}

a {
	color: #009688;
}

.sort-column {
	color: #009688;
}

.p-xs {
	margin-top: 10px;
}
</style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>人员设置 - </span><span style="color:#009688;">门店人员管理</span>
	</div>

	<div class="ibox-content">

		<ul class="nav nav-tabs">
			<li class="active"><a href="">人员列表</a></li>
			<li><a href="${ctxweb}/shop/shop/user/form">添加人员</a></li>
		</ul>
		<form:form id="searchForm" modelAttribute="meduser"
			action="${ctxweb}/shop/shop/user/list" method="post"
			class="breadcrumb form-search ">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden"
				value="${page.pageSize}" />
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
				callback="page();" />
			<div class="p-xs">
				<ul class="ul-form">

					<li><label>登录名：</label>
					<form:input path="jobNumber" htmlEscape="false" maxlength="50"
							class="input-medium" /> <label>姓&nbsp;&nbsp;&nbsp;名：</label>
					<form:input path="username" htmlEscape="false" maxlength="50"
							class="input-medium" /></li>
					<li style="display:none;"><label>时间</label> <input
						class="small" type="text" style=" width: 130px;" name="statrDate"
						id="create_time_start"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						value="${statrDate}" placeholder="请输入创建开始时间" /> <input
						class="small" type="text" name="stopDate" id="stoptime"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						style=" width: 130px;" value="${stopDate}" placeholder="请输入创建结束时间" />
					</li>
					<li class="btns"><input
						style="background: #393D49;color: #ffffff " id="btnSubmit"
						class="btn btn-primary" type="submit" value="查询"
						onclick="return page();" /></li>
				</ul>
			</div>
		</form:form>
		<tags:message content="${message}" />
		<input type="hidden" id="ctxweb" value="${ctxweb}">
		<table class="table table-striped table-bordered table-hover dataTables-example">
			<thead>
				<tr>
					<th class="sort-column loginName">登录名</th>
					<th class="sort-column name">姓名</th>
					<th>手机</th>
					<th>角色</th>
					<th>状态</th>
					<th>操作</th>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="shopuser">
					<tr class="gradeX">
						<td><a href="${ctxweb}/shop/shop/user/form?id=${shopuser.shopUserId}">${shopuser.jobNumber}</a></td>
						<td>${shopuser.username}</td>
						<td>${shopuser.phoneNumber}</td>

						<c:if test="${shopuser.type==1}">
							<td>收银人员</td>
						</c:if>
						<c:if test="${shopuser.type==2}">
							<td>配送人员</td>
						</c:if>
						<td><c:if test="${shopuser.status==0}">
								<a style="color:#009688;"
									href="${ctxweb}/shop/shop/user/updateStatus?id=${shopuser.shopUserId}">启动</a>
							</c:if>
							<c:if test="${shopuser.status==1}">
								<a style="color:#8B91A0;">启动</a>
							</c:if> | <c:if test="${shopuser.status==1}">
								<a style="color:#009688;"
									href="${ctxweb}/shop/shop/user/updateStatus?id=${shopuser.shopUserId}">禁用</a>
							</c:if>
							<c:if test="${shopuser.status==0}">
								<a style="color:#8B91A0;">禁用</a>
							</c:if></td>
						<td><a style="color:#009688;"
							href="${ctxweb}/shop/shop/user/form?id=${shopuser.shopUserId}">修改</a>
							<label style="color:#009688; "
							onclick="comtit(${shopuser.shopUserId})">删除</label></td>
					</tr>
        </c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
		<script>
			var ctxweb = $("#ctxweb").val();
			function comtit(id) {
				var r = confirm("确定删除吗？");
				if (r) {
					window.location.href = ctxweb + '/shop/shop/user/delete?id=' + id;
				}
			}
		</script>
	</div>
</body>
</html>