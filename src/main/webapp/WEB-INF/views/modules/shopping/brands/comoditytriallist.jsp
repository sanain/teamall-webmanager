<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	<script type="text/javascript">
		$(document).ready(function() { 
				function page(n,s){
				if(n) $("#pageNo").val(n);
			    if(s) $("#pageSize").val(s);
			          $("#searchForm1").attr("action","${ctxsys}/EbCommoditytria");
			          $("#searchForm1").submit();
			    	return false;
			    }
			});
	   
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbCommoditytria/list">优惠商品列表</a></li>
	</ul>
	 <form:form id="searchForm1" modelAttribute="ebCommoditytrial" action="${ctxsys}/EbCommoditytria" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<%-- <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/> --%>
		<ul class="ul-form">
		    <li><form:input path="productNo" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入商品编号"/></li>
			<li><form:select path="status"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
		           <option value="">请选择状态</option>  
                   <form:option value="0">生效</form:option>  
                   <form:option value="1">已完成</form:option>
                    <form:option value="2">确定名单中</form:option>
               </form:select>  
		        </li>
		        <li><form:select path="type"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
		           <option value="">请选择类型</option>  
                   <form:option value="0">免费试用</form:option>  
                   <form:option value="1">摇一摇</form:option>
                   <form:option value="2">限时抢购</form:option>
                   <form:option value="3">一元夺宝</form:option>
                   <form:option value="4">h5一元夺宝</form:option>
               </form:select>  
		        </li>
		      <%--   <li><input class="small" type="text" style=" width: 80px;" name="statePrice" id="create_time_start"  value="${statePrice}" placeholder="请输入最低价格"/>--
				<input class="small" type="text" name="stopPrice" id="stopPrice"  style=" width: 80px;" value="${stopPrice}" placeholder="请输入最高价格"/></li> --%>
		     <li><form:input path="produtName" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入商品名字"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed" border="1">
		<tr><th><span>编号</span></th><th>商品名称</th><th>优惠类型</th><th>开始时间</th><th>结束时间</th><th>优惠价</th><th>数量</th><th>状态</th><shiro:hasPermission name="merchandise:sales:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="Commoditytrialist" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td><a href="${ctxsys}/EbCommoditytria/form?id=${Commoditytrialist.commoditytrialId}">${Commoditytrialist.produtName}</a></td>
				<td><c:if test="${Commoditytrialist.type==0}">免费使用</c:if><c:if test="${Commoditytrialist.type==1}">摇一摇</c:if><c:if test="${Commoditytrialist.type==2}">限时抢购</c:if><c:if test="${Commoditytrialist.type==3}">一元夺宝</c:if><c:if test="${Commoditytrialist.type==4}">h5一元夺宝</c:if></td>
				<td>${Commoditytrialist.startTime}</td>
				<td>${Commoditytrialist.stopTime}</td>
				<td>${Commoditytrialist.salePrice}</td>
				<td>${Commoditytrialist.num}</td>
				<td><c:if test="${Commoditytrialist.status==0}">生效</c:if><c:if test="${Commoditytrialist.status==2}">确定名单中</c:if><c:if test="${Commoditytrialist.status==1}">失效</c:if></td>
			  <td> <shiro:hasPermission name="merchandise:sales:edit">
					<a href="${ctxsys}/EbCommoditytria/form?id=${Commoditytrialist.commoditytrialId}">修改</a>
					<a href="${ctxsys}/EbCommoditytria/delete?id=${Commoditytrialist.commoditytrialId}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				  </shiro:hasPermission>
				  <c:if test="${Commoditytrialist.type==3}">
				  <shiro:hasPermission name="merchandise:sales:edit">
				  <a href="${ctxsys}/EbIndianarecord/list?objectId=${Commoditytrialist.commoditytrialId}">查看记录</a>
				  </shiro:hasPermission>
				  </c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div >
		<div class="pagination">${page}</div>
		</div>
</body>
</html>