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
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ncMessageTable.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ncMessageTable.orderId}">历史分析</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ncMessageTable.orderId}">递送日志</a></li>
          <li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ncMessageTable.orderId}">订单退货处理</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ncMessageTable.orderId}">递送管理</a></li>
          <li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ncMessageTable.orderId}">最终批复</a></li>
		   <li><a class="active" href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ncMessageTable.orderId}">nc同步</a></li>
      </ul>
    
	</div>
	  <c:if test="${ebOrder.type==3}">
	<input type="button" value="重新同步下单" onclick="To_resynchronize()" style="margin:10px;display:none"/>
	</c:if>
	<table style="width:99%;margin:10px;border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3" id="aa">
			
				<tbody>
				<tr>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">action</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">单据标识</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作时间</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">状态</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作信息</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">请求入参</font></td>
				</tr>
			<c:forEach items="${ncMessageTablelist}" var="ncMessageTablelist" varStatus="status">
			<tr>
				  <td class="table_main"><font size="2px" color="#787777">${ncMessageTablelist.action}</font></td>
				<td class="table_main"><font size="2px" color="#787777">${ncMessageTablelist.billid}</font></td>
				  <td class="table_minor"><font size="2px" color="#787777">${ncMessageTablelist.maketime}</font></td>
				
				
				<td class="table_main"><font size="2px" color="#787777">
				<c:if test="${ncMessageTablelist.stauts==0}">成功</c:if>
				<c:if test="${ncMessageTablelist.stauts==1}">失败</c:if>
				<c:if test="${ncMessageTablelist.stauts==2}">异常</c:if>
				</font>
				</td>
				  <td class="table_minor"><font size="2px" color="#787777">
				  <c:if test="${ncMessageTablelist.stauts==0}">${ncMessageTablelist.description}</c:if>
				<c:if test="${ncMessageTablelist.stauts==1}">${ncMessageTablelist.message}</c:if>
				<c:if test="${ncMessageTablelist.stauts==2}">${ncMessageTablelist.message}</c:if>
				
				</font>
				  </td>
				    <td class="table_minor" ><xmp style="display:none">${ncMessageTablelist.startStr}</xmp><input type="button" value="复制" class="bb"/></td>
				</tr>
			
				
				</c:forEach>
			</tbody></table>
			
</body>

<script>

$(function(){
	$(".bb").on("click",function(){
	alert($(this).prev().text());
		
	})
	
})
function To_resynchronize(){
	var msg = "同步成功";
	$.ajax({
	 					url : "${ctxsys}/NcMessageTable/saleordernc_reset?orderId=${ncMessageTable.orderId}",
	 					type : 'post',
	 					data : {
	 					},
	 					cache : false,
	 					success : function(data) {
							console.log(data);
	 						// 保存成功
	 						if(data.code=='00'){
	 							top.$.jBox.tip(msg, 'info');
								window.location.href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ncMessageTable.orderId}"
	 						} else {
	 							top.$.jBox.tip(data.msg, 'info');
	 						}
	 					}
	 				});
	    }

	</script>

</html>