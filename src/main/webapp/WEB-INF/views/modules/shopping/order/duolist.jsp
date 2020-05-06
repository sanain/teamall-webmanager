<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/Order/duolist");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/Order/list">商品订单列表</a></li>
		<li  class="active"><a href="${ctxsys}/Order/duolist">夺宝订单列表</a></li>
		<li><a href="${ctxsys}/Order/czlist">充值订单列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebOrder" action="${ctxsys}/Order/duolist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="orderNo" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入订单编号"/></li>
		     <li><form:input path="mobile" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入联系电话"/></li>
		      <li>
		      <form:select path="payStatus"  htmlEscape="false" maxlength="50" class="input-medium">
		           <option value="">请选择支付状态</option>  
                   <form:option value="0">未支付</form:option>  
                   <form:option value="1">已支付</form:option>
               </form:select>
		      </li>
		      <li>
		      <form:select path="status"  htmlEscape="false" maxlength="50"  class="input-medium">
		           <option value="">请选择订单状态</option>  
                   <form:option value="1">待付款</form:option>
                   <form:option value="2">待发货</form:option>  
                   <form:option value="3">待发货(已确定)</form:option>
                   <form:option value="4">已发货</form:option>  
                   <form:option value="5">待评价 </form:option>
                   <form:option value="6">已完成</form:option>  
                   <form:option value="7">已取消订单</form:option>
               </form:select>
		      </li>
		     <!-- <li><input id="btnSubmit" class="btn btn-primary" type="button" value="更多" onclick="dwnt()"/></li> -->
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
		</ul>
		
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		<th>编号</th>
		<th>订单类型</th>
		<th>订单编号</th>
		<th>下单用户</th>
		<th class="sort-column createTime">下单时间 </th>
		<!-- <th>收贷地址</th> -->
		<th>支付状态</th>
		<th>订单状态</th>
		<th>订单总金额</th>
		<shiro:hasPermission name="merchandise:order:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="orderlist" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>  <c:if test="${orderlist.type==1}">商品订单</c:if><c:if test="${orderlist.type==2}">夺宝订单</c:if></td>
			    <td>${orderlist.orderNo}</td>
				<td><a href="${ctxsys}/User/check?userId=${orderlist.userId}">${fns:getUserId(orderlist.userId).username}</a></td>
				<td>${orderlist.createTime}</td>
				<td> 
				      <c:if test="${orderlist.payStatus==null}">未支付</c:if>
				     <c:if test="${orderlist.payStatus==0}">未支付</c:if>
					 <c:if test="${orderlist.payStatus==1}">支付</c:if>
				</td>
				<td>         
				              <c:if test="${orderlist.payStatus==null}">未付款</c:if>
				             <c:if test="${orderlist.status==1}">待付款</c:if>
							 <c:if test="${orderlist.status==2}">待发货</c:if>
							 <c:if test="${orderlist.status==3}">待发货(已确定)</c:if>
							 <c:if test="${orderlist.status==4}">已发货</c:if>
							 <c:if test="${orderlist.status==5}">待评价</c:if>
							 <c:if test="${orderlist.status==6}">已完成 </c:if>
							 <c:if test="${orderlist.status==7}">已取消订单</c:if>
						</select>
				</td>
				<td>${orderlist.orderAmount}</td>
			   <shiro:hasPermission name="merchandise:order:edit"><td>
					<a href="${ctxsys}/Order/form?orderId=${orderlist.orderId}">修改</a>
						<c:if test="${orderlist.type==1}">
					<a href="${ctxsys}/Order/skyuform?orderId=${orderlist.orderId}">分单</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>