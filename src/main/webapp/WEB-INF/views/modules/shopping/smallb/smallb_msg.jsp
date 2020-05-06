<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>店商信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-store-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
   	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin_smalledit_msg.js"></script>
    <script>
 
	 $(function(){
	 	$('.img-btn').mouseover(function(){
	 	console.log('aa');
	 		var iii=$(this).find('ol').find('img').attr('src');
	 		$('.fixed-img').html('<img src='+iii+' />');
	 		$('.fixed-img').show();
	 		$('.fixed-img').find('img').css({'max-width':'auto','max-height':'auto'})
	 	
	 })
	 $('.img-btn').mouseout(function(){
		 $('.fixed-img').hide()
	 });
	}) 
	  
    </script>
    <style>
    	.fixed-img{dispaly:none;position:fixed;width:600px;left:50%;margin-left:-300px;}
    	.fixed-img img{width:100%;max-width:auto}
    	.fit-right ul li ol li:first-child{}
    </style>
</head>
<body>
    <div class="fitment">
      <ul class="nav-ul" style="margin-bottom: 10px;">
            <li><a class="active" href="${ctxsys}/PmShopInfo/smallBShopinfo?id=${pmShopInfo.id}">店商信息</a></li>
      </ul>
      <form class="form-horizontal" action="${ctxsys}/PmShopInfo/smallBShopinfoEdit" method="post" name="form2" style="margin:0px">
       <input type="hidden" id=id name="id" value="${pmShopInfo.id}"/>
        <input type="hidden" id="messager" name="messager" value="0"/>
        <div class="fit-box">
            <div class="fit-left">
			    <ul>
                    <li>店商代码：</li>
                    <li><a href="${ctxsys}/User/form?mobile=${pmShopInfo.shopCode}" style="width: 100px;
    text-align: right;
    line-height: 30px;">${pmShopInfo.shopCode}</a></li>
                </ul>
                <ul>
                    <li><p>*</p>申请人姓名：</li>
                    <li><input id="contactName" name="contactName" value="${pmShopInfo.contactName}" type="text"></li>
                </ul>
                <ul>
                    <li><p>*</p>联系电话：</li>
                    <li><input id="mobilePhone" name="mobilePhone" value="${pmShopInfo.mobilePhone}" type="text"></li>
                </ul>
                <ul>
                    <li>申请理由：</li>
                    <li>
                        <textarea id="describeInfo" name="describeInfo" style="paddin:5px">${pmShopInfo.describeInfo}</textarea>
                    </li>
                </ul>
                <ul>
                    <li>申请备注：</li>
                    <li>
                        <textarea id="remarkDesc" name="remarkDesc" style="paddin:5px">${pmShopInfo.remarkDesc}</textarea>
                    </li>
                </ul>
               
            </div>

            <div class="fit-right">
                <ul>
                    <li>营业执照图：</li>
                    <li style="height: 211px;">
                        <div class="img-btn">
		        			<input type="hidden" name="businessCodeLogo" id="businessCodeLogo" value="${pmShopInfo.businessCodeLogo}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="businessCodeLogo"  style="color: blue;"></span>
							<tags:ckfinder input="businessCodeLogo" type="images" uploadPath="/merchandise/ShopImg"/>
		                </div>
                    </li>
                </ul>
            </div>
            <div class="fit-btn">
	            <shiro:hasPermission name="merchandise:PmShopInfo:edit">
	            	<a class="save" href="javascript:;">保存</a>
	            </shiro:hasPermission>
            </div>
        </div>
      </form>
    </div>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>

<div class="fixed-img">
</div>
</body>
</html>