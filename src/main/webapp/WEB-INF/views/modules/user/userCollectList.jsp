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
			$("#searchForm").attr("action","${ctxsys}/EbCollect/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbCollect/list">用户收藏列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebCollect" action="${ctxsys}/EbCollect/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="id" htmlEscape="false" maxlength="50" class="input-medium" style="width: 115px;" placeholder="请输入ID"/></li>
		    <li><form:input path="userId" htmlEscape="false" maxlength="50" class="input-medium" style="width: 165px;" placeholder="请输入用户ID"/></li>
			<li><form:select path="userType"  htmlEscape="false" maxlength="50" style="width: 165px" class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="1">商品</form:option>  
                   <form:option value="2">帖子</form:option>
                   <form:option value="3">文章</form:option>  
                   <form:option value="4">关注用户</form:option>
               </form:select>  
		    </li>
		 	<li><form:select path="state"  htmlEscape="false" maxlength="50" style="width: 150px" class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="1">显示</form:option>  
                   <form:option value="2">隐藏</form:option>
                   <form:option value="3">删除</form:option>
               </form:select>  
		    </li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		<th>ID</th>
		<th>用户ID</th>
		<th>用户名</th>
		<th>类型</th>
		<th>收藏对象</th>
		<th>状态</th>
		<shiro:hasPermission name="merchandise:collect:edit">
		<th>删除</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="collectList" >
			<tr>
			 	<td>${collectList.id}</td>
			    <td>${collectList.userId}</td>
				<td>${collectList.userName}</td>
				<td>
					<c:choose>
			      		 <c:when test="${collectList.userType==1}">商品</c:when>
			      		 <c:when test="${collectList.userType==2}">帖子</c:when>
			      		 <c:when test="${collectList.userType==3}">文章</c:when>
			      		 <c:when test="${collectList.userType==4}">关注用户</c:when>
					</c:choose>
				</td>
				<td>${collectList.objectId}</td>
				<td>
					<c:choose>
			      		<c:when test="${collectList.state==1}">显示</c:when>
			      		<c:when test="${collectList.state==2}">隐藏</c:when>
						<c:when test="${collectList.state==3}">删除</c:when>
					</c:choose>
				</td>
			   <shiro:hasPermission name="merchandise:collect:edit">
			   <td>
			   	  <a href="${ctxsys}/EbCollect/form?id=${collectList.id}">修改</a>
				  <a href="${ctxsys}/EbCollect/deleteCollect?id=${collectList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>