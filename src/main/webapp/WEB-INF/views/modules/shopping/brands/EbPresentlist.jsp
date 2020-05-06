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
		});
		
		function page(n,s){
		    var productId=$("#productId").val();
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbPresentController/list?productid="+productId);
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbPresentController/list?productid=${productId}">商品属性列表</a></li>
		<shiro:hasPermission name="merchandise:pro:edit"><li><a href="${ctxsys}/EbPresentController/form?productId=${productId}">商品属性添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr><th></span><span>编号</span></th><th>赠品名称</th><th>赠品价格</th><th>赠品数量</th><th>赠品图片</th><shiro:hasPermission name="merchandise:pro:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebPresentlist" varStatus="status">
		<input type="hidden"  id="productId" value="${productId}"/>
			<tr>
			    <td> ${status.index+1}</td>
				<td>${ebPresentlist.presentName}</td>
				<td>${ebPresentlist.presentPrice }</td>
				<td>${ebPresentlist.presentMun}</td>
				<td><img src="${ebPresentlist.presentImg}" width="50px;" height="30px;"/></td>
			   <shiro:hasPermission name="merchandise:pro:edit"><td>
					<a href="${ctxsys}/EbPresentController/form?id=${ebPresentlist.id}&productId=${productId}">修改</a>
					<a href="${ctxsys}/EbPresentController/delete?id=${ebPresentlist.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>