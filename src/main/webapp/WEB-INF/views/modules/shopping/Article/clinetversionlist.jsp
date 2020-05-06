<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
		<meta name="decorator" content="default"/>
		<link href="${ctxStatic}/common/jqsite.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript">
			function page(n,s){
				$("#pageNo").val(n);
				$("#pageSize").val(s);
				$("#searchForm").attr("action","${ctxsys}/Clinetversion");
				$("#searchForm").submit();
		    	return false;
		    }
		 
		</script>
		<style type="text/css">
		lable{
		       margin-left: 10px
		}
		</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/Clinetversion/list">版本列表</a></li>
		<shiro:hasPermission name="merchandise:Clinetversion:edit"><li><a href="${ctxsys}/Clinetversion/form">版本添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="clinetversion" action="${ctxsys}/Clinetversion" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul calss="ul-form" style=" margin: 0;overflow: hidden;">
		   <li style=" float: left;list-style: none;height: 35px;line-height: 35px;"> <lable  style=" margin-left: 10px" >请输入版本名称:</lable><form:input path="versionName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入版本名称"/> </li>
		   <li style=" float: left;list-style: none;height: 35px;line-height: 35px;"><lable  style=" margin-left: 10px">请选择类型:</lable><form:select path="versionKind"  maxlength="50" class="input-medium"><form:option value="">全部</form:option><form:option value="1">${fns:getProjectName()}</form:option></form:select> </li>
		   <li style=" float: left;list-style: none;height: 35px;line-height: 35px;"><lable  style=" margin-left: 10px"></lable> <input id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		  <th class="center123">编号</th>
		  <th class="center123">版本名称</th>
		  <th class="center123">版本编号</th>
		  <th class="center123">分类</th>
		  <th class="center123">下载路径</th>
		  <th class="center123">是否强制更新</th>
		  <shiro:hasPermission name="merchandise:Clinetversion:edit">
		  <th class="center123">操作</th>
		  </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="clinetversionlist" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/Clinetversion/form?versionId=${clinetversionlist.versionId}">${clinetversionlist.versionName}</a></td>
				<td class="center123">${clinetversionlist.versionNo }</td>
				<td class="center123"><c:if test="${clinetversionlist.versionKind==1}">${fns:getProjectName()}</c:if></td>
				<td class="center123">${ctxweb}${clinetversionlist.versionSrc}</td>
				<td class="center123"><c:if test="${clinetversionlist.versionType==0}">否</c:if><c:if test="${clinetversionlist.versionType==1}">是</c:if></td>
			   <shiro:hasPermission name="merchandise:Clinetversion:edit">
			    <td class="center123">
					<a href="${ctxsys}/Clinetversion/form?versionId=${clinetversionlist.versionId}">修改</a>
					<a href="${ctxsys}/Clinetversion/delete?versionId=${clinetversionlist.versionId}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td>
			  </shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>