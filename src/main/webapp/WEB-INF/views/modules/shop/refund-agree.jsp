<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},退款详情-商家审核"/>
	<meta name="Keywords" content="${fns:getProjectName()},退款详情-商家审核"/>
	<title>退款详情-商家审核</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-agree.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
    function deleteOb(ob,saleId){
		 var bh="${ctxweb}/shop/shopInfo/delete?view=1&saleId='"+saleId+"'&id="+ob;
		 $('.delete-yes').attr('href',bh);
		}
    $(function(){
    	var hhr=$('.submit-a').attr('href');
    	var act=0;
    	 $('.consent-a').click(function(){
    	        for(i=0;i<$('.list-body').length;i++){
    	        	if($($('.list-body')[i]).hasClass('active')){
    	        		act=1;
    	        		var shopDepotAddressid=$($('.list-body')[i]).attr('id')
    	        		$('.submit-a').attr('href',hhr+''+shopDepotAddressid)
        	        }
    	        }
    	        if(act==0){
    	        	alert("请先设置默认收货地址")
    	        }
    	        if(act==1){
    	        	$('.consent').show();
    	        }
    	    });
    	    $('.consent-del').click(function(){
    	        $('.consent').hide();
    	        $('.submit-a').attr('href',hhr)
    	    });
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
            <span>同意退款申请</span>
        </div>
        <div class="refuse">
            <p>同意退款申请</p>
            <div class="refuse-dd">退货地址（同意后将提示买家退货到您所选的地址）： <a class="new-site btn btn-primary" href="${ctxweb}/shop/shopInfo/addressList?view=1&saleId=${saleId}"  target="tager">使用新地址</a></div>
            <div class="site-list">
            <ul class="list-top">
                <li>地址</li>
                <li>联系人</li>
                <li>联系电话</li>
                <li>操作</li>
            </ul>
	            <c:forEach items="${pmShopDepotAddressList}" var="ShopDepotAddressList">
		            <ul id="${ShopDepotAddressList.id}" class="list-body <c:if test="${ShopDepotAddressList.isDefault==1}">active</c:if>">
		                <li>
		                    <span>${ShopDepotAddressList.countryName}</span><span>${ShopDepotAddressList.provinceName}</span><span>${ShopDepotAddressList.cityName}</span><span>${ShopDepotAddressList.areaName}</span><span>${ShopDepotAddressList.detailAddress}</span>
		                </li>
		                <li>${ShopDepotAddressList.contactName}</li>
		                <li>${ShopDepotAddressList.phoneNumber}</li>
		                <li>
		                    <a class="adda" href="${ctxweb}/shop/shopInfo/form?view=1&saleId=${saleId}&id=${ShopDepotAddressList.id}">编辑</a>
		                    <b>|</b>
		                    <a class="delete-a" href="javascript:;" onclick="deleteOb(${ShopDepotAddressList.id})">删除</a>
		                    <b>|</b>
		                    <c:if test="${ShopDepotAddressList.isDefault==1}">设为默认</c:if>
		                    <c:if test="${ShopDepotAddressList.isDefault==0}"><a class="mo-a" href="${ctxweb}/shop/shopInfo/saveAddress?view=1&saleId=${saleId}&id=${ShopDepotAddressList.id}&se=1">设为默认</a></c:if>
		                </li>
		            </ul>
	            </c:forEach>
        	</div>
            
            <div class="refuse-btn">
                <a class="consent-a btn btn-primary" href="javascript:;">同意申请</a>
            </div>
        </div>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
               <span>同意退款？退款金额¥<b>${ebAftersale.deposit}</b>元</span>
               <br>
               <a class="submit-a" href="${ctxweb}/shop/ReturnManagement/ReturnManagementAffirm?aftersaleid=${ebAftersale.saleId}&shopDepotAddressid=">确定</a>
               <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
</body>
</html>