<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支付方式</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmOpenPayWay");
			$("#searchForm").submit();
	    	return false;
	    }
	   </script>
</head>
<body>
     <ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:PmOpenPayWay:view"><li  class="active"><a href="${ctxsys}/PmOpenPayWay">支付方式列表</a></li></shiro:hasPermission>
	   <%--  <li ><a href="${ctxsys}/PmOpenPayWay/form">支付方式<shiro:hasPermission name="merchandise:PmOpenPayWay:edit">${not empty pmOpenPayWay.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmOpenPayWay:view">查看</shiro:lacksPermission></a></li> --%>
	 </ul>
	 <form:form id="searchForm" modelAttribute="pmOpenPayWay" action="${ctxsys}/PmOpenPayWay" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="payWayName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入名称"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
    </form:form> 
	 <table  class="table table-striped table-condensed  table-bordered"> 
		    <tr>
				<th>序号</th>
				<th>支付方式编码</th>
				<th>支付方式名称</th>
				<th>支付方式备注</th>
				<!-- <th>支付方式logo</th> -->
				<th>状态</th>
				<th>创建时间</th>
				<th>修改人</th>
				<th>修改时间 </th>
				<%-- <shiro:hasPermission name="merchandise:PmOpenPayWay:edit">
				<th>操作</th>
				</shiro:hasPermission> --%>
			</tr>
		    <c:forEach items="${page.list}" var="pageList" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>${pageList.payWayCode}</td>
			    <td>${pageList.payWayName}</td>
				<td>${pageList.payRemark}</td>
				<%-- <td>${pageList.payLogoUrl}</td> --%>
				<td>
				<c:if test="${pageList.status==1}">开启</c:if><c:if test="${pageList.status==0}">关闭</c:if>|
				<c:if test="${pageList.status==0}">
				<a onclick="return confirmx('是否开启？', '${ctxsys}/PmOpenPayWay/status?id=${pageList.id}')" >开启</a></c:if>
				<c:if test="${pageList.status==1}">
				<a onclick="return confirmx('是否关闭？', '${ctxsys}/PmOpenPayWay/status?id=${pageList.id}')" >关闭</a></c:if>
				</td>
				<td>${pageList.createTime}</td>
				<td>${pageList.modifyUser}</td>
				<td>${pageList.modifyTime}</td>
				<shiro:hasPermission name="merchandise:PmOpenPayWay:edit">
				<%-- <td><a href="${ctxsys}/PmOpenPayWay/from?id=${pageList.id}">修改</a><a onclick="return confirmx('是否删除？', '${ctxsys}/PmOpenPayWay/from?id=${pageList.id}')">删除</a></td> --%>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>