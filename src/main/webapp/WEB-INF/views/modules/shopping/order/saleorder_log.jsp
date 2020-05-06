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
      <ul class="nav-ul">
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
		  <li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">nc同步</a></li>
      </ul>
		
	</div>
</body>
</html>