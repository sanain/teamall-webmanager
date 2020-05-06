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
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrderLog.orderId}">订单资料</a></li>
          <li><a class="active" href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrderLog.orderId}">历史分析</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrderLog.orderId}">递送日志</a></li>
          <%--<li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrderLog.orderId}">订单退货处理</a></li>--%>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrderLog.orderId}">递送管理</a></li>
          <%--<li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrderLog.orderId}">最终批复</a></li>--%>
		   <%--<li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrderLog.orderId}">nc同步</a></li>--%>
      </ul>
    
	</div>
	<table style="width:99%;margin:10px;border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
			
				<tbody>
				<tr>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">订单号</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作记录</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">商品信息</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">订单类型</font></td>
				  <%--<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">线上线下订单</font></td>--%>
				   <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作IP</font></td>
				</tr>
			<c:forEach items="${ebOrderLoglist}" var="ebOrderLoglist" varStatus="status">
			<tr>
				  <td class="table_minor"><a href="${ctxsys}/Order/saleorderform?orderId=${ebOrderLoglist.orderId}"><font size="2px" color="#18AEA1">${ebOrderLoglist.orderNo}</font></a></td>
				  <td class="table_main"><font size="2px" color="#787777">${ebOrderLoglist.operaLog}</font></td>
				<td class="table_main"><font size="2px" color="#787777">${ebOrderLoglist.recordLog}</font></td>
				  <td class="table_minor"><font size="2px" color="#787777">${ebOrderLoglist.productLog}</font></td>
				
				
				<td class="table_main"><font size="2px" color="#787777">
				<c:if test="${ebOrderLoglist.type==1}">商品订单</c:if>
				<c:if test="${ebOrderLoglist.type==2}">精英合伙人订单</c:if>
				<c:if test="${ebOrderLoglist.type==3}">充值订单</c:if>
				<c:if test="${ebOrderLoglist.type==4}">兑换订单</c:if></font>
				</td>
				  <%--<td class="table_minor"><font size="2px" color="#787777">--%>
				  <%--<c:if test="${ebOrderLoglist.onoffLineStatus==1}">线上订单</c:if>--%>
				  <%--<c:if test="${ebOrderLoglist.onoffLineStatus==2}">线下订单</c:if>--%>
				  <%--<c:if test="${ebOrderLoglist.onoffLineStatus==3}">商家付款订单</c:if>--%>
				  <%--<c:if test="${ebOrderLoglist.onoffLineStatus==4}">兑换订单</c:if></font>--%>
				  <%--</td>--%>
				    <td class="table_minor"><font size="2px" color="#787777">${ebOrderLoglist.operaIp}</font></td>
				</tr>
			
				
				</c:forEach>
			</tbody></table>
</body>
</html>