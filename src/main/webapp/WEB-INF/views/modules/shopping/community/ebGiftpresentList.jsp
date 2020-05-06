<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>礼物列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbGiftpresent/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
	    <li class="active"><a href="${ctxsys}/EbGiftpresent/list">礼物列表</a></li>
		<li ><a href="${ctxsys}/EbGiftpresent/form?id=${ebGiftpresent.id}">礼物<shiro:hasPermission name="merchandise:truewords:edit">${not empty ebGiftpresent.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:truewords:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebGiftpresent" action="${ctxsys}/EbGiftpresent/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
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
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		<th>礼物名称</th>
		<th>礼物图片</th>
		<th>礼物价格</th>
		<th>状态</th>
		<shiro:hasPermission name="merchandise:truewords:edit">
		<th>操作</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="ebGiftpresentList" >
			<tr>
			 	<td>${ebGiftpresentList.name}</td>
			    <td><img alt="" src="${ebGiftpresentList.imgUrl}" style=" width: 40px; height: 40px;"></td>
				<td>${ebGiftpresentList.money}</td>
				<td><c:if test="${ebGiftpresentList.status==0}">开启</c:if><c:if test="${ebGiftpresentList.status==1 }">关闭</c:if></td>
			   <shiro:hasPermission name="merchandise:truewords:edit">
			   <td>
			   	  <a href="${ctxsys}/EbGiftpresent/form?id=${ebGiftpresentList.id}">修改</a>
				  <a href="${ctxsys}/EbGiftpresent/deleteCollect?id=${ebGiftpresentList.id}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>