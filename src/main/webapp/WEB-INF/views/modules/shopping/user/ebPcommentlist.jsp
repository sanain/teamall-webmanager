<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ebPcommentContorller/list");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/ebPcommentContorller">评论列表</a></li>
		<shiro:hasPermission name="merchandise:pcomment:view"><li><a href="${ctxsys}/ebPcommentContorller/form">评论添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebProductcomment" action="${ctxsys}/ebPcommentContorller" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		   
		   <li><form:input path="productname" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名"/></li>
		    <li><form:input path="username" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入用户名"/></li>
		     <li><form:input path="point" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入分数"/></li>
			<li><form:select path="status"  htmlEscape="false" maxlength="50"  class="input-medium">
		           <option value="">请选择</option>  
                   <form:option value="0">未回复</form:option> 
                   <form:option value="1">已回复 </form:option>
               </form:select>  
		        </li>
		     <!-- <li><input id="btnSubmit" class="btn btn-primary" type="button" value="更多" onclick="dwnt()"/></li> -->
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr><th>评论编号</th><th>评论人</th><th>评论的商品</th><th class="sort-column commentTime">评论时间</th><th>评论的分数</th><th> 回复状态</th><shiro:hasPermission name="merchandise:order:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebProductcomment">
			<tr>
			    <td>${ebProductcomment.commentId}</td>
				<td><a href="${ctxsys}/ebPcommentContorller/select?id=${ebProductcomment.commentId}">${ebProductcomment.username}</a></td>
				<td>${ebProductcomment.productname}</td>
				<td>${ebProductcomment.commentTime}</td>
				<td>${ebProductcomment.point}</td>
				<td><c:if test="${ebProductcomment.status==0}">未回复</c:if>
							<c:if test="${ebProductcomment.status==1}">已回复</c:if>
				</td>
			   <shiro:hasPermission name="merchandise:pcomment:edit"><td>
					<a href="${ctxsys}/ebPcommentContorller/select?id=${ebProductcomment.commentId}">查看</a>
					<a href="${ctxsys}/ebPcommentContorller/delete?id=${ebProductcomment.commentId}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>