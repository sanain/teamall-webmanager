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
			<script type="text/javascript">
		function divtkhide(){
			$('.divtk').hide();
		}
		function divtkshow(content,type){
			$('.divtk').show();
			$('.content-input').val(content)
			$('.type-input').val(type)
			if(type=='1'){
				$('.type-label').html("确定修改收货人名字");
			}else if(type=='2'){
				$('.type-label').html("确定修改收货人邮箱");
			}else if(type=='3'){
				$('.type-label').html("确定修改收货人电话");
			}
			
		}
		</script>
			<script type="text/javascript">
	     function statusSave(){
		   var content=$('.content-input').val();
		   var orderId=$('.orderId-input').val();
		   var type=$('.type-input').val();
			var msg = "保存成功";
			var msgerr = "操作异常，请刷新页面";
			// 提交保存
			$.ajax({
	 					url : "${ctxsys}/Order/userSave",
	 					type : 'post',
	 					data : {
	 						content : content,
	 						orderId : orderId,
	 						type : type
	 					},
	 					cache : false,
	 					success : function(data) {
	 						// 保存成功
	 						if(data=='00'){
	 							top.$.jBox.tip(msg, 'info');
	 							// 保存完成后重新查询
								divtkhide();
			if(type=='1'){
				$('.acceptName-input').html(content);
			}else if(type=='2'){
				$('.acceptEmail-input').html(content);
			}else if(type=='3'){
				$('.telphone-input').html(content);
			}
	 						} else {
	 							top.$.jBox.tip(msgerr, 'info');
	 						}
	 					}
	 				});
	    }
		</script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/Order/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a class="active" href="${ctxsys}/Order/saleorderemail?orderId=${ebOrder.orderId}">邮件联系</a></li>
          <li><a href="${ctxsys}/Order/saleorderlog?orderId=${ebOrder.orderId}">订单日志</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
      </ul>
    
	</div>
</body>
</html>