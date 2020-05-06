<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	 <meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctxsys}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/sys/user/daililist?office.isAgent=1&company.isAgent=1");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
<div class="ibox-content">
		<%-- <div id="importBox" class="hide">
			<form id="importForm" action="${ctxsys}/sys/user/import" method="post" enctype="multipart/form-data"
				class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
				<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
				<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
				<a href="${ctxsys}/sys/user/import/template">下载模板</a>
			</form>
		</div> --%>
				<ul class="nav nav-tabs">
					<li class="active"><a href="">用户列表</a></li>
					<shiro:hasPermission name="sys:user:edit"><li><a href="${ctxsys}/sys/user/form1">用户添加</a></li></shiro:hasPermission>
				</ul>
					<form:form id="searchForm"  modelAttribute="sysUser" action="${ctxsys}/sys/user/list1" method="post" class="breadcrumb form-search ">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
					<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
					<div class="p-xs">
						<ul class="ul-form">
							<li><label>归属公司：</label><tags:treeselect id="company" name="company.id" value="${sysUser.company.id}" labelName="company.name" labelValue="${sysUser.company.name}" 
								title="公司" url="${ctxsys}/sys/office/treeData?type=1&isAgent=1" cssClass="input-small" allowClear="true" /></li>
							<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
							<li class="clearfix"></li>
							<li><label>归属部门：</label><tags:treeselect id="office" name="office.id" value="${sysUser.office.id}" labelName="office.name" labelValue="${sysUser.office.name}" 
								title="部门" url="${ctxsys}/sys/office/treeData?type=2&isAgent=1" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
							<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
							<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
								<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
								<input id="btnImport" class="btn btn-primary" type="button" value="导入"/> -->
							</li>
						</ul>
					</div>
					</form:form>
	                 <tags:message content="${message}"/>
                        <table class="table table-striped table-bordered table-hover dataTables-example" >
                           	<thead><tr><th>归属公司</th><th>归属部门</th><th class="sort-column loginName">登录名</th><th class="sort-column name">姓名</th><th>电话</th><th>手机</th><th>角色</th><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
                            <tbody>
                            <c:forEach items="${page.list}" var="user">
								<tr class="gradeX">
									<td>${user.company.name}</td>
									<td>${user.office.name}</td>
									<td><a href="${ctxsys}/sys/user/form1?id=${user.id}">${user.loginName}</a></td>
									<td>${user.name}</td>
									<td>${user.phone}</td>
									<td>${user.mobile}</td>
									<td>${user.roleNames}</td>
									<shiro:hasPermission name="sys:user:edit"><td>
					    				<a href="${ctxsys}/sys/user/form1?id=${user.id}">修改</a>
										<a href="${ctxsys}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
									</td></shiro:hasPermission>
								</tr>
							</c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">${page}</div>
                        </div>
</body>
</html>