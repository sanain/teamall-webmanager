<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},协商历史"/>
	<meta name="Keywords" content="${fns:getProjectName()},协商历史"/>
    <title>协商历史</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-history.css">
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

        a{
            color: #009688;
        }
        a:hover{
            color: #009688;
        }

        .sub:hover{
            color: rgb(120,120,120);
        }

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
    <div class="order">
        <div class="crumbs-div">
            <span>您的位置：</span>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">首页</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">退款管理</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementForm?id=${saleId}" target="tager">退款详情</a>>
            <span>协商历史</span>
        </div>
        <!--给卖家留言-->
        <div class="refuse">
        <form action="${ctxweb}/shop/ReturnManagement/addRecordContent" method="post" class="form-horizontal" name="form2">
           <input id="saleId" name="saleId" type="hidden" value="${saleId}"/>
           <p class="refuse-p">给买家留言</p>
           <ul class="area">
                <li>留言内容：</li>
                <li>
                    <textarea id="recordContent" name="recordContent" maxlength="200"></textarea>
                    <span>不超过200字</span>
                </li>
           </ul>
           <ul class="fil">
                <li>上传图片：</li>
                <li>
                    <span>每张图片大小不超过5M,最多6张</span>
                	<div class="file-div">
        			<input type="hidden" name="recordEvidencePicUrl" id="recordEvidencePicUrl" value="${shopInfo.shopBanner}"  htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					<span class="help-inline" id="recordEvidencePicUrl"  style="color: blue;"></span>
					<tags:ckfinder input="recordEvidencePicUrl" type="images" maxWidth="80" selectMultiple="true" uploadPath="/ebSalesrecordImg"/>
               		</div>
                </li>
           </ul>
           <div class="refuse-btn">
                <a href="javascript:;" class="sub" style="background-color: #393D49;">提交</a>
           </div>
        </form>
        </div>
        <div class="history">
          <p>协商详情</p>
          <div class="history-box">
            <c:forEach items="${salesrecords}" var="salesrecord" varStatus="status">
                <div class="history-list">
                    <div class="list-top">
	                    <c:choose>
	                    	<c:when test="${salesrecord.recordObjType==3}">
		                    	<p><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></p>
		                        <span>${fns:getProjectName()}平台</span>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<p><img src="${salesrecord.recordObjImg}" alt=""></p>
	                        	<span>${salesrecord.recordObjName}</span>
	                    	</c:otherwise>
	                    </c:choose>
                        <br><span><fmt:formatDate value="${salesrecord.recordDate}" type="both"/></span>
                    </div>
                    <ul class="liu-ul">
                        <li>${salesrecord.recordName}</li>
                        <li>${salesrecord.recordContent}</li>
                    </ul>
                    <c:if test="${!empty salesrecord.imgList}">
	                    <ul class="shop-img">
	                    	<c:forEach items="${salesrecord.imgList}" var="img">
				                <li><img src="${img}" alt=""></li>
				            </c:forEach>
	                    </ul>
                    </c:if>
                </div>
			</c:forEach>
          </div>
        </div>
        
    </div>
</body>
</html>