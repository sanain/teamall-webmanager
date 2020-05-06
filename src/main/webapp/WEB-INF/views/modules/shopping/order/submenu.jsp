<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分单</title>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
		$(document).ready(function() {
					});
	 	</script>
</head>
<body>
     <ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pro:view"><li><a href="${ctxsys}/Order">订单列表</a></li></shiro:hasPermission>
	    <li class="active"><a href="${ctxsys}/Order/form?orderId=${eborder.orderId}">订单<shiro:hasPermission name="merchandise:pro:edit">${not empty eborder.orderId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:pro:view">查看</shiro:lacksPermission></a></li>
	</ul>
		<form:form  modelAttribute="eborder"  action="${ctxsys}/Order/ebOrderitemids" method="post" class=" form-search "> 
			 <form:hidden path="orderId"/>
			 <form:hidden path="orderNo"/>
			 <table  class="table table-striped table-condensed"> 
				<tr><th>序号</th><th>商品名称</th><th>商品属性名称</th><th>商品原价</th><th>实付金额</th><th>商品数量</th><th>重量</th><th>是否已发货 </th></tr>
				<c:forEach items="${ebOrderitems}" var="EbOrderitem" varStatus="status">
					<tr>
					    <td><input type="checkbox" name="ids" value="${EbOrderitem.orderitemId}"/></td>
					    <td>${EbOrderitem.productName}</td>
					    <td>${EbOrderitem.propertyName}</td>
						<td>${EbOrderitem.goodsPrice}</td>
						<td>${EbOrderitem.realPrice}</td>
						<td>${EbOrderitem.goodsNums}<%-- <input name="count" value="${EbOrderitem.goodsNums}"/> --%></td>
						<td>${EbOrderitem.goodsWeight}</td>
						<td>
							 <c:if test="${EbOrderitem.isSend==0}">未发货</c:if>
							 <c:if test="${EbOrderitem.isSend==1}">已发货</c:if>
							 <c:if test="${EbOrderitem.isSend==2}">已经退货</c:if>
							 <c:if test="${EbOrderitem.isSend==3}">退货中</c:if>
							</td>
					</tr>
				</c:forEach>
			</table>
	    <table class="form_table">
						<tr align="center">
						<td width="600px"><shiro:hasPermission name="merchandise:pro:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission></td>
						<td width="600px"><input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/></td>
						</tr>
					</table>
<!-- 	</div> -->
	</form:form> 

</body>
</html>