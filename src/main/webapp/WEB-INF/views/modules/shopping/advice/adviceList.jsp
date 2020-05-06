<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>意见与建议</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbAdvice/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbAdvice/list">意见与建议</a></li>
<%-- 	 <form:form id="searchForm1"  action="${ctxsys}/EbAdvice/Item" method="post" class="breadcrumb form-search ">
	<li><input id="btnSubmit1" class="btn btn-primary" type="submit" value="查询" /></li>
	</form:form>
 --%>	</ul>
	 <form:form id="searchForm" modelAttribute="ebAdvice" action="${ctxsys}/EbAdvice/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="adviceId" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入编号"/></li>
			<li><form:select path="type"  htmlEscape="false" maxlength="50"  class="input-medium;">
		           <option value="">请选择</option>  
                   <form:option value="0">未读</form:option>  
                   <form:option value="1">已读</form:option>
               </form:select>  
		        </li>
		     <li><form:input path="userId" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入用户ID"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>用户ID</th>
		<th>内容</th>
		<th class="sort-column createdate">时间</th>
		<th>类型</th>
		<shiro:hasPermission name="merchandise:advice:edit">
		<th>删除</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="adviceList" >
			<tr>
			 <td>${adviceList.adviceId}</td>
			    <td>${adviceList.userId}</td>
				<td>${adviceList.advice}</td>
				<td>${adviceList.createdate}</td>
				<td>
					<c:choose>
			      		 <c:when test="${adviceList.type==0}">未读</c:when>
			      		 <c:when test="${adviceList.type==1}">已读</c:when>
					</c:choose>
				</td>
			   <shiro:hasPermission name="merchandise:advice:edit">
			   	 <td>
			   	 	<a href="${ctxsys}/EbAdvice/form?id=${adviceList.adviceId}">修改</a>
					<a href="${ctxsys}/EbAdvice/delete?id=${adviceList.adviceId}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				 </td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>