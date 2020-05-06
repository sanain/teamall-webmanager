<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},拒绝退款申请"/>
	<meta name="Keywords" content="${fns:getProjectName()},拒绝退款申请"/>
    <title>退款详情-拒绝退款申请</title>
	    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-shop.css">
	
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-refuse.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
   	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
	<script src="${ctxStatic}/sbShop/js/refund-history.js"></script>
	<style>
    	.file-div a{display:inline-block;height:30px;line-height:30px;padding:0 15px;border:1px solid #dcdcdc;border-radius:5px;color:#666;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
    	$(function(){
    		if($('#recordEvidencePicUrlPreview').children('li:nth-child(1)').text()=='无'){
    			$('#recordEvidencePicUrlPreview').children('li:nth-child(1)').text('')
    		}
    	})
    </script>
</head>
<body>
 <div class="c-context">
      <ul class="nav-ul" style="margin:0px">
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>
          <li><a class="active" style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
      </ul>
    
	</div>
    <div class="order">
        <div class="crumbs-div">
            <span>您的位置：</span>
           <a href="${ctxsys}/Order/saleorderreturngoods?orderId=${ebOrder.orderId}&saleId=${saleId}"><font color="#18AEA1">订单退货详情</font></a>>
            <span>拒绝退款申请</span>
        </div>
        <div class="refuse">
         <form action="${ctxsys}/Order/refundRefusejsp?orderId=${ebOrder.orderId}" method="post" class="form-horizontal" name="form2">
            <input id="saleId" name="saleId" type="hidden" value="${saleId}"/>
            <p>拒绝退款申请</p>
            <ul class="area">
                <li>拒绝说明：</li>
                <li>
                    <textarea id="recordContent" name="recordContent" maxlength="200"></textarea>
                    <span>不超过200字</span>
                </li>
            </ul>
            <ul class="fil">
                <li>上传凭证：</li>
                <li>
                    <span>每张图片大小不超过5M,最多6张</span>
                	<div class="file-div">
        			<input type="hidden" name="rejectRefundPicUrl" id="rejectRefundPicUrl" value="" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					<span class="help-inline" id="rejectRefundPicUrl"  style="color: blue;"></span>
					<tags:ckfinder input="rejectRefundPicUrl" type="images" maxWidth="80" selectMultiple="true" uploadPath="ebSalesrecordImg"/>
               		</div>
                </li>
            </ul>
            <div class="refuse-btn">
                <a href="javascript:;" class="sub btn btn-primary">拒绝退款申请</a>
            </div>
          </form>
        </div>
    </div>
</body>
</html>