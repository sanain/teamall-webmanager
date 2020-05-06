<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户收藏列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbWhistleblowing/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbWhistleblowing/list">用户举报列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebWhistleblowing" action="${ctxsys}/EbWhistleblowing/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="userId" htmlEscape="false" maxlength="50" class="input-medium" style="width: 165px;" placeholder="请输入用户ID"/></li>
		 	<li><form:select path="status"  htmlEscape="false" maxlength="50" style="width: 150px" class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="0">未处理</form:option>  
                   <form:option value="1">已处理</form:option>
               </form:select>  
		    </li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		<th>ID</th>
		<th>用户ID</th>
		<th>举报的内容</th>
		<th>类型</th>
		<th>收藏对象</th>
		<shiro:hasPermission name="merchandise:truewords:edit">
		<th>操作</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="ebWhistleblowingList" >
			<tr>
			 	<td>${ebWhistleblowingList.id}</td>
			    <td>${ebWhistleblowingList.userId}</td>
				<td>${ebWhistleblowingList.content}</td>
				<td>
					<c:choose>
			      		 <c:when test="${ebWhistleblowingList.type==1}">商品</c:when>
			      		 <c:when test="${ebWhistleblowingList.type==2}">帖子</c:when>
			      		 <c:when test="${ebWhistleblowingList.type==3}">文章</c:when>
			      		 <c:when test="${ebWhistleblowingList.type==4}">关注用户</c:when>
					</c:choose>
				</td>
				<td> <a href="${ctxsys}/EbWhistleblowing/check?id=${ebWhistleblowingList.id}">${ebWhistleblowingList.objectId}</a></td>
			   <shiro:hasPermission name="merchandise:truewords:edit">
			   <td>
			   	  <a href="${ctxsys}/EbWhistleblowing/form?id=${ebWhistleblowingList.id}">修改</a>
				  <a href="${ctxsys}/EbWhistleblowing/deleteCollect?id=${ebWhistleblowingList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>