<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
    <title>销售信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin:0px">
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a class="active" href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <%--<li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>--%>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <%--<li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>--%>
      </ul>
    
	</div>
<table width="98%" align="center" cellspacing="1" cellpadding="3" style="margin:10px">
	<tbody>
	<tr>
	  <td width="43%" align="center" valign="top">			
				<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
			<tbody>
			<tr class="table_minor">
					<td width="95"><b>下单日期</b></td>
					<td><font color="blue"><strong><fmt:formatDate value="${ebOrder.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></strong></font></td>
				</tr>
				<tr class="table_main">
					<td width="95"><b>付款时间</b></td>
					<td bgcolor="#aaf4f7"><fmt:formatDate value="${ebOrder.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			<tr class="table_minor">
					<td width="95"><b>订单类型</b></td>
					<td><font color="blue"><strong> <c:if test="${ebOrder.type==1}">商品订单</c:if>
					<c:if test="${ebOrder.type==2}">精英合伙人订单</c:if>
					<c:if test="${ebOrder.type==3}">充值订单</c:if>
					<c:if test="${ebOrder.type==4}">兑换订单</c:if>
					</strong></font></td>
				</tr>
				<tr class="table_main">
					<td width="95"><b>订单号</b></td>
					<td><a style="color:#18AEA1" href="${ctxsys}/Order/saleorderform?orderId=${ebOrder.orderId}">${ebOrder.orderNo}</a></td>
				</tr>
				<tr class="table_minor">
					<td width="95"><b>订单状态</b></td>
					<td align="center" bgcolor="#0909f7">
						<font color="#ffffff"><strong> <c:if test="${ebOrder.status==1}">等待买家付款</c:if>
					 <c:if test="${ebOrder.status==2}">等待发货</c:if>
					 <c:if test="${ebOrder.status==3}">已发货,待收货</c:if>
					 <c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
					 <c:if test="${ebOrder.status==5}">已关闭</c:if>
					<c:if test="${ebOrder.refundOrderNo != null && !''.equals(ebOrder.refundOrderNo)}">
						<c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
							已退款
						</c:if>
						<c:if test="${ebOrder.status==null||ebOrder.status!=6}">
							退款中
						</c:if>

					</c:if>
						</strong></font></td>
				</tr>
				<tr class="table_main">
					<td width="95"><strong>配送状态</strong></td>
					<td>
					<c:if test="${ebOrder.deliveryStatus==0}">未发送</c:if>
					<c:if test="${ebOrder.deliveryStatus==1}">已发送</c:if>
					<c:if test="${ebOrder.deliveryStatus==2}">部分发送</c:if>
					</td>
				</tr>
				<%--<tr class="table_minor">--%>
					<%--<td width="95"><b>运送方式</b></td>--%>
					<%--<td>--%>
					<%--<c:if test="${ebOrder.shippingMethod==1}">快递</c:if>--%>
					<%--<c:if test="${ebOrder.shippingMethod==2}">EMS</c:if>--%>
					<%--<c:if test="${ebOrder.shippingMethod==3}">平邮</c:if>--%>
					<%--</td>--%>
				<%--</tr>--%>
		 
		 <%--<c:choose>--%>
		 <%--<c:when test="${fn:length(ebOrder.ebOrderitems)>1}">--%>
		 <%--<c:forEach items="${ebOrder.ebOrderitems}" var="items" varStatus="i">--%>
		 <%--<tr class="table_main">--%>
					<%--<td width="95"><b>商品名称</b></td>--%>
					<%--<td>${items.productName}</td>--%>
				<%--</tr>--%>
				<%----%>
		  	<%--<tr class="table_main">--%>
					<%--<td width="95"><b>快递编号</b></td>--%>
					<%--<td>${items.expressNumber}</td>--%>
				<%--</tr>--%>
				<%--<tr class="table_minor">--%>
					<%--<td width="95"><b>物流公司</b></td>--%>
					<%--<td>${items.logisticsCompany}</td>--%>
				<%--</tr>--%>
		 <%--</c:forEach>--%>
		 <%--</c:when>--%>
		 <%--<c:otherwise>--%>
		 	<%--<tr class="table_main">--%>
					<%--<td width="95"><b>快递编号</b></td>--%>
					<%--<td>${ebOrder.expressNumber}</td>--%>
				<%--</tr>--%>
				<%--<tr class="table_minor">--%>
					<%--<td width="95"><b>物流公司</b></td>--%>
					<%--<td>${ebOrder.logisticsCompany}</td>--%>
				<%--</tr>--%>
		 <%--</c:otherwise>--%>
		 <%--</c:choose>--%>
			 
				 
			
				
				
			</tbody></table>
			
			
			
		</td>
		<td width="57%" align="center" valign="top">
			
			
            
			<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
				<tbody>
				<c:forEach items="${ebOrder.business.traces}" var="tracesList" varStatus="status">
				<tr class="table_minor">
					<td>${tracesList.acceptTime}</td>
					<td><font color="blue"><strong>${tracesList.acceptStation}</strong></font></td>
				</tr>
				</c:forEach>
				</tbody>
				</table>
				</td>
				</tr>
				</tbody>
	</table>
	
</body>
</html>