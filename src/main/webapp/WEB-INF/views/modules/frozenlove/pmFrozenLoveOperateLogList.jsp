<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content=""/>
	<meta name="Keywords" content=""/>
	<title>冻结操作记录列表</title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/frozenLoveOperateLog");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/frozenLoveOperateLog">操作记录列表</a></li>
		<li class=""><a href="${ctxsys}/frozenLoveOperateLog/form?frozenType=1">操作记录添加</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmFrozenLoveOperateLog" action="${ctxsys}/frozenLoveOperateLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form"><%--
		 <li><label>用户名称:</label><form:input path="userNames" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户名称"/></li>
		 <li><label>用户手机:</label><form:input path="mobiles" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户手机"/></li>
		    --%><li><label>冻结类型:</label>
		       <form:select path="frozenType" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="1">所有当前数</form:option>
		         <form:option value="2">指定数</form:option>
		         <form:option value="4">指定当前比例</form:option>
		       </form:select>
		    </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><%--
		 <th>用户名称</th>--%>
		 <th>用户手机</th>
		 <th>冻结数量类型</th>
		 <th>冻结数（或比例）</th>
		 <th>操作状态</th>
		 <th>操作结果</th>
		 <th>创建时间</th>
		 <th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<%--<td>${log.userNames}</td> --%>
				<td title='${log.mobiles}'>${fns:abbr(log.mobiles,60)}</td>
			    <td>
			    	<c:if test="${log.frozenType==1}">所有当前数</c:if>
			    	<c:if test="${log.frozenType==2}">指定数</c:if>
			    	<c:if test="${log.frozenType==4}">指定当前比例</c:if>
 				</td>
			    <td>
				    <c:if test="${log.frozenType!=4}"><fmt:formatNumber type="number" value="${log.frozenLove}" pattern="0.0000" maxFractionDigits="4"/></c:if>
				    <c:if test="${log.frozenType==4}"><fmt:formatNumber type="number" value="${log.frozenLove}" pattern="0.00" maxFractionDigits="2"/>%</c:if>
			    </td>
			    <td>
			    	<c:if test="${log.operateStatus==1}">待执行</c:if>
			    	<c:if test="${log.operateStatus==2}">已执行</c:if>
			    	<c:if test="${log.operateStatus==3}">取消</c:if>
				</td>
				 <td title='${log.operateReason}'>${fns:abbr(log.operateReason,60)}</td>
				<td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			    <td>
			   	    <c:if test="${log.operateStatus==1}">
				    <a href="${ctxsys}/frozenLoveOperateLog/form?id=${log.id}">修改</a>
				    <a href="${ctxsys}/frozenLoveOperateLog/updateProcess?id=${log.id}" onclick="return confirmx('是否立刻执行？', this.href)">立刻执行</a>
				    </c:if>
				    <c:if test="${log.operateStatus!=1}">
				    <a href="${ctxsys}/frozenLoveDetail/list?frozenLoveOperateId=${log.id}">查看明细</a>
				    <a href="${ctxsys}/frozenLoveOperateLog/detail?id=${log.id}">查看操作结果 </a>
				    </c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>