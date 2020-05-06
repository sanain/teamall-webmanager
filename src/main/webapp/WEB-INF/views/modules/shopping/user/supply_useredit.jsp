<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员信息"/>
    <title>会员信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
	    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
	<script src="${ctxStatic}/sbShop/js/admin-company-msg.js"></script>
	
	
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
	 <style>
    	.fixed-img{dispaly:none;position:fixed;width:600px;left:50%;margin-left:-300px;}
    	.fixed-img img{width:100%;max-width:auto}
    	.fit-right ul li ol li:first-child{}
    </style>
</head>
<script type="text/javascript">
	 $(function(){
		 if($('#avataraddressPreview>li').html()=='无'){
		 	$('#avataraddressPreview>li').html("");
		 }
		 	$('#avataraddressPreview').css("padding-left","0"); 
		if($('#businessCodeLogoPreview>li').html()=='无'){
			$('#businessCodeLogoPreview>li').html("");
		}
		 	$('#businessCodeLogoPreview').css("padding-left","0");
	     });
		 	</script>
<script type="text/javascript">
  //百度地图WebAPI 坐标转地址
    function showPosition(r) {
        // ak = appkey 访问次数流量有限制
        var url = 'https://api.map.baidu.com/geocoder/v2/?ak=7b788c5ea45cc4b3ac6331a4b0643d5b&callback=?&location=' + r.lat + ',' + r.lng + '&output=json&pois=1';
        $.getJSON(url, function (res) {
            console.log(res.result)
            var result=res.result;
            var addr=res.result.addressComponent;
            var detailaddr=addr.country+","+addr.province+","+addr.city+","+addr.district+","+addr.street+addr.street_number;
            detailaddr=detailaddr.replace("省","");
            $("#district").html(detailaddr);
            $("#districtName").val(detailaddr);
           document.getElementById("contactAddress").value =result.formatted_address+result.sematic_description;
        });
    }
	 function coordinatesChange(lng,lat){
			$("#longitude").val(lng);
			$("#latitude").val(lat);
		 }
	function openMap(obj){
		if(obj.value === "坐标选位"){
			var lng = $("#longitude").val();
			var lat = $("#latitude").val();
			var url = "${ctxsys}/PmShopInfo/mapBaidu";
			if(lng && lat)
				 url += "?point="+lng+","+lat;
			document.getElementById("iframe_map").src=url;
			$("#iframe_map").toggle();
			obj.value = "确定";
			//windowOpen(url,"文件管理",1000,700);
		}else{
			obj.value = "坐标选位";
			$("#iframe_map").toggle();
			document.getElementById("iframe_map").src="";
		}
	 }
	 $(function(){
	 	$('.img-btn').mouseover(function(){
	 	console.log('aa');
	 		var iii=$(this).find('ol').find('img').attr('src');
	 		$('.fixed-img').html('<img src='+iii+' />');
	 		$('.fixed-img').show();
	 		$('.fixed-img').find('img').css({'max-width':'auto','max-height':'auto'})
			console.log(iii);
	 	
	 })
	 $('.img-btn').mouseout(function(){
		 $('.fixed-img').hide()
	 });
	}) 
	</script>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin-bottom:10px">
          <li><a class="active" href="${ctxsys}/User/supplyuseredit?userId=${userId}">供应商信息</a></li>
      </ul>
      <form class="form-horizontal" style="margin:0px" action="${ctxsys}/User/userinfoedit" method="post" id="searchForm" name="form2">
        <input id="userId" name="userId" type="hidden" value="${userId}"/>
		<input id="districtName" name="districtName" class="hidden" value="${ebUser.pmShopInfoShopIdSmallB.districtName},${ebUser.pmShopInfoShopIdSmallB.shopLlAddress}"></li>
        <div class="context-box" style="padding:10px">
            <div>
              
				 <li style="display:flex;content-justify:flex-start;aglin-items:baseline;flex-wrap: wrap">
                        <div class="img-btn" style="width:260px;height:260px;position:relative;background:#e9e6e6">
                            <input type="hidden" name="avataraddress" id="avataraddress" value="${ebUser.avataraddress}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="avataraddress"  style="color: blue;"></span>
							<div style="position:absolute;bottom:5px;text-align:center;width:100%;">
							<tags:ckfinder input="avataraddress"  type="images" uploadPath="/merchandise/avataraddress"/>
							</div>
							<font color="red" style="margin:3px">*头像</font>
                        </div>
						<div>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">账号：</label><input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="mobile" name="mobile" value="${ebUser.mobile}" <c:if test="${not empty ebUser.userId}">disabled </c:if>/><font color="red"> *请填写供应商联系人手机号</font></p>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">密码：</label><input type="password" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="password" name="password"/><font color="red"> *填写时即为修改或添加密码，添加时必填</font></p>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">供应商公司：</label><input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="companyName" name="companyName" value="${ebUser.pmShopInfoShopIdSmallB.companyName}"/><font color="red" style="margin-right:10px"> *</font><label style="width:120px">供应商门店：</label><input  style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="shopName" name="shopName" value="${ebUser.pmShopInfoShopIdSmallB.shopName}"/><font color="red"> *</font></p>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">联系人：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="contactName" name="contactName" value="${ebUser.pmShopInfoShopIdSmallB.contactName}"/><font color="red" style="margin-right:10px"> *</font><label style="width:120px">联系人电话/手机：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="customerPhone" name="customerPhone" value="${ebUser.pmShopInfoShopIdSmallB.customerPhone}"/><font color="red" style="margin-right:10px"> *</font>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">所在详细地址：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="contactAddress" name="contactAddress" style="width: 408px;" value="${ebUser.pmShopInfoShopIdSmallB.contactAddress}"/><input type="button" value="坐标选位" onclick="openMap(this)" style="display: inline-block;margin-top: 5px;margin-left: 5px;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;"/><font color="red"> *请选择供应商地址</font></p>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">所在地区名称：</label> <span id="district">${ebUser.pmShopInfoShopIdSmallB.districtName},${ebUser.pmShopInfoShopIdSmallB.shopLlAddress}</span></p>
						<p style="margin-top:10px;margin-left:10px"><label>经度：<input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="longitude" name="longitude" value="${ebUser.pmShopInfoShopIdSmallB.shopLongitude}" type="text" style="width: 132px;" >   纬度：<input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="latitude" name="latitude" value="${ebUser.pmShopInfoShopIdSmallB.shopLatitude}" type="text" style="width: 132px;" ></label></p>
						<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no" style="display: none;"></iframe>
						</div>
                    </li>
                    <li style="display:flex;content-justify:flex-start;aglin-items:baseline;flex-wrap: wrap">
                        <div class="img-btn" style="width:260px;height:260px;position:relative;background:#e9e6e6">
                            <input type="hidden" name="businessCodeLogo" id="businessCodeLogo" value="${ebUser.pmShopInfoShopIdSmallB.businessCodeLogo}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="businessCodeLogo"  style="color: blue;"></span>
							<div style="position:absolute;bottom:5px;text-align:center;width:100%;">
							<tags:ckfinder input="businessCodeLogo" type="images" uploadPath="/merchandise/ShopImg"/>
							</div>
							<font color="red" style="margin:3px">*营业执照</font>
                        </div>
						<div>
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">法人代表：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="legalPerson" name="legalPerson" value="${ebUser.pmShopInfoShopIdSmallB.legalPerson}"/><font color="red" style="margin-right:10px">*</font><label style="width:120px">注册资金：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="capital" name="capital" value="${ebUser.pmShopInfoShopIdSmallB.capital}" class="input" type="text" maxlength="16" onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false"> 万元<font color="red">*</font></p>		
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">营业执照有效期：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" name="businessStartTime" value="<fmt:formatDate value="${ebUser.pmShopInfoShopIdSmallB.businessStartTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_s" readonly="readonly" class="businessStartTime" type="text">
                    <span>到</span>
                    <input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" name="businessEndTime" value="<fmt:formatDate value="${ebUser.pmShopInfoShopIdSmallB.businessEndTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_e" readonly="readonly" class="businessEndTime" type="text"><font color="red" style="margin-right:10px">*</font></p> 
					<p style="margin-top:10px;margin-left:10px"><label style="width:120px">营业执照经营范围：</label><textarea id="licenseAppScope" name="licenseAppScope" class="input" style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;outline: none;padding: 5px 10px;">${ebUser.pmShopInfoShopIdSmallB.licenseAppScope}</textarea><font color="red"> *</font></p>
					<p style="margin-top:10px;margin-left:10px;"><label style="width:120px">供应商备注：</label><textarea id="reviewReason" name="reviewReason" class="input" style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;outline: none;padding: 5px 10px;">${ebUser.pmShopInfoShopIdSmallB.reviewReason}</textarea></p>
					</div>
                    </li>
             <shiro:hasPermission name="merchandise:user:edit">
            <div class="msg-btn">
                <input  type="button" onclick="bent()" style="display: inline-block;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;" value="保存"></a>
            </div>
			</shiro:hasPermission>
        </div>
      </form>
    </div>
    <script type="text/javascript">
       function bent(){
		 var userId=$('#userId').val();
		 var districtName=$('#districtName').val();
		 var avataraddress=$('#avataraddress').val();
		 var mobile=$('#mobile').val();
		 var companyName=$('#companyName').val();
		 var shopName=$('#shopName').val();
		 var contactName=$('#contactName').val();
		 var customerPhone=$('#customerPhone').val();
		 var contactAddress=$('#contactAddress').val();
		 var contactAddress=$('#contactAddress').val();
		 var district=$('#district').val();
		 var longitude=$('#longitude').val();
		 var latitude=$('#latitude').val();
		 var businessCodeLogo=$('#businessCodeLogo').val();
		 var legalPerson=$('#legalPerson').val();
		 var capital=$('#capital').val();
		 var licenseAppScope=$('#licenseAppScope').val();
		 var reviewReason=$('#reviewReason').val();
		 var businessStartTime=$('.businessStartTime').val();
		 var businessEndTime=$('.businessEndTime').val();
		 var password=$('#password').val();
	     $.ajax({
			    url : "${ctxsys}/User/savesupplyuser",   
			    type : 'post',
			    data:{
					userId:userId,
					districtName:districtName,
					avataraddress:avataraddress,
					mobile:mobile,
					companyName:companyName,
					shopName:shopName,
					contactName:contactName,
					customerPhone:customerPhone,
					contactAddress:contactAddress,
					contactAddress:contactAddress,
					district:district,
					longitude:longitude,
					latitude:latitude,
					businessCodeLogo:businessCodeLogo,
					legalPerson:legalPerson,
					capital:capital,
					licenseAppScope:licenseAppScope,
					businessStartTime:businessStartTime,
					businessEndTime:businessEndTime,
					password:password,
					reviewReason:reviewReason
					},
					cache : false,
			    success : function (data) {
			     if(data.code=='00'){
			        alertx(data.msg);
			        window.location.href="${ctxsys}/User/supplyuseredit?userId="+data.userId; 
			      }else{
			       alertx(data.msg);
			      }
			    }
	         });
	      }
    </script>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
<div class="fixed-img">
</div>
</body>
</html>