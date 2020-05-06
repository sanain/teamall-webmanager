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
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbDonationController/list");
			$("#searchForm").submit();
	    	return false;
	    }
			$("#treeTable").treeTable({expandLevel : 5});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbDonationController/list">活动列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li><a href="${ctxsys}/EbDonationController/form">活动添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>活动名称</th><th>活动开始时间</th><th>活动结束时间</th><th>活动类型</th><th>活动状态</th><shiro:hasPermission name="merchandise:Donation:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebDonationlist" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>${ebDonationlist.activityName}</td>
				<td>${ebDonationlist.startTime}</td>
				<td>${ebDonationlist.stopTime}</td>
				<td>
				<c:if test="${ebDonationlist.favorableType==1}">
				   满减
				 </c:if>
				 <c:if test="${ebDonationlist.favorableType==2}">
				满赠
				 </c:if>
				  <c:if test="${ebDonationlist.favorableType==3}">
				   满包邮
				 </c:if>
				  <c:if test="${ebDonationlist.favorableType==4}">
				   单品包邮
				 </c:if>
				  <c:if test="${ebDonationlist.favorableType==5}">
				赠品
				 </c:if>
				  <c:if test="${ebDonationlist.favorableType==6}">
				   充值活动
				 </c:if>
				  <c:if test="${ebDonationlist.favorableType==7}">
				 ios内购充值
				 </c:if>
				</td>
				<td>
				<c:if test="${ebDonationlist.status==0}">
				 开启
				</c:if>
				<c:if test="${ebDonationlist.status==1}">
				关闭
				</c:if>
				
				</td>
			   <shiro:hasPermission name="merchandise:Donation:edit"><td>
					<a href="${ctxsys}/EbDonationController/form?id=${ebDonationlist.id}">修改</a>
					<a href="${ctxsys}/EbDonationController/delete?id=${ebDonationlist.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>