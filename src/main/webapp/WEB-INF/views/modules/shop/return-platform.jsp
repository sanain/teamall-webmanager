<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},申请介入"/>
	<meta name="Keywords" content="${fns:getProjectName()},申请介入"/>
    <title>申请介入</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-refuse.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
   	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
	<script src="${ctxStatic}/sbShop/js/return-platform.js"></script>
	<style>
    	.file-div a{display:inline-block;height:30px;line-height:30px;padding:0 15px;border:1px solid #dcdcdc;border-radius:5px;color:#666;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
    	$(function(){
    		if($('#shopEvidencePicUrlPreview').children('li:nth-child(1)').text()=='无'){
    			$('#shopEvidencePicUrlPreview').children('li:nth-child(1)').text('')
    		}
    	})
    </script>
</head>
<body>
    <div class="order">
        <div class="crumbs-div">
            <span>您的位置：</span>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">首页</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">退款管理</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementForm?id=${saleId}" target="tager">退款详情</a>>
            <span>申请介入</span>
        </div>
        <div class="refuse">
         <form action="${ctxweb}/shop/ReturnManagement/returnPlatform" method="post" class="form-horizontal" name="form2">
            <input id="saleId" name="saleId" type="hidden" value="${saleId}"/>
            <p>申请介入</p>
            <ul class="area">
                <li>申请说明：</li>
                <li>
                    <textarea id="shopProblemDesc" name="shopProblemDesc" maxlength="200"></textarea>
                    <span>不超过200字</span>
                </li>
            </ul>
            <ul class="fil">
                <li>上传凭证：</li>
                <li>
                    <span>每张图片大小不超过5M,最多6张</span>
                	<div class="file-div">
        			<input type="hidden" name="shopEvidencePicUrl" id="shopEvidencePicUrl" value="" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					<span class="help-inline" id="shopEvidencePicUrl"  style="color: blue;"></span>
					<tags:ckfinder input="shopEvidencePicUrl" type="images" maxWidth="80" selectMultiple="true" uploadPath="ebSalesrecordImg"/>
               		</div>
                </li>
            </ul>
            <div class="refuse-btn">
                <a href="javascript:;" class="sub">提交申请</a>
            </div>
          </form>
        </div>
    </div>
</body>
</html>