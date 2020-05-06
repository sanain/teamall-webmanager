<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>列表</title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/pmLoveImprestLog");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmLoveImprestLog">备用金记录列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmLoveImprestLog" action="${ctxsys}/pmLoveImprestLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
               <li><label>来源类型:</label>
		       <form:select path="loveType" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="1">积分分配不满</form:option>
		         <form:option value="2">补充零级积分</form:option>
		       </form:select>
		    </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th>来源类型</th>
		 <th>状态</th>
		 <%-- <th>积分数</th>
		 <th>今日积分指数</th>--%>
		 <th>备用金</th>
		 <th>备注 </th>
		 <th>是否分配</th>
		 <th>创建人 </th>
		 <th>创建时间</th>
		</tr>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<td>
			    	<c:if test="${log.loveType==1}">积分分配不满</c:if>
			    	<c:if test="${log.loveType==2}">补充零级积分</c:if>
 				</td>
			    <td>
			    	<c:if test="${log.loveStatus==1}">增加</c:if>
			    	<c:if test="${log.loveStatus==2}">减少</c:if>
 				</td>
			  <%--<td><fmt:formatNumber type="number" value="${log.love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>${log.exponential}</td>--%>
			    <td><fmt:formatNumber type="number" value="${log.totalAmt}" pattern="0.00" maxFractionDigits="2"/></td>
			    <td>${log.remark}</td>
			    <td><c:if test="${log.isAllot==1}">已分配</c:if><c:if test="${log.isAllot!=1}">未分配</c:if></td>
			    <td>${log.createUser}</td>
				<td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>