<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员信息"/>
    <title>门店信息</title>
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
            console.log(res.result);
          var result=res.result;
           /*  var addr=res.result.addressComponent;
            var detailaddr=addr.country+","+addr.province+","+addr.city+","+addr.district+","+addr.street+addr.street_number;
            detailaddr=detailaddr.replace("省","");   */
            
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
	});
	 
	 function updatepass(){
		 $("#uppass").toggle();
	 }
	 function goback(){
		  window.location.href="${ctxsys}/psstore/storeList"; 
	 }
	</script>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin-bottom:10px">
          <li><a class="active" href="${ctxsys}/psstore/storeEdit?storeId=${storeId}">门店信息</a></li>
      </ul>
      <form class="form-horizontal" style="margin:0px" method="post" id="searchForm" name="form2">
        <input id="storeId" name="storeId" type="hidden" value="${storeId}"/>
        <div class="context-box" style="padding:10px">
            <div>
				 <li style="display:flex;content-justify:flex-start;aglin-items:baseline;flex-wrap: wrap">
                        <div class="img-btn" style="width:260px;height:260px;position:relative;background:#e9e6e6">
                            <input type="hidden" name="storeBanner" id="storeBanner" value="${ebStore.storeBanner}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="storeBanner"  style="color: blue;"></span>
							<div style="position:absolute;bottom:5px;text-align:center;width:100%;">
							<tags:ckfinder input="storeBanner"  type="images" uploadPath="/merchandise/storeBanner"/>
							</div>
							<font color="red" style="margin:3px">*门店图片</font>
                        </div>
						<div>
				 
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">登录账号：</label>
						<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="account" name="account" value="${ebStore.account}"/>
						<font color="red"> *请填写登录账号</font></p>
						
					 
					     <c:choose>
						<c:when test="${empty ebStore.password }">
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">登录密码：</label>
						<input type="password" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="password" name="password" />	<font color="red"> *请填写密码</font></p>
						</c:when>
						<c:otherwise>
						 <p style="margin-top:10px;margin-left:10px"><label style="width:120px">登录密码：</label>
						 <input type="button" value="修改密码" onclick="updatepass();" />
						</p>
						 <p id="uppass" style="margin-top:10px;margin-left:10px;display: none;"><label style="width:120px">新密码：</label>
						 <input type="password" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="password" name="password" />	<font color="red"> *请填写新密码</font> 
						</c:otherwise>
						</c:choose>
					      <p style="margin-top:10px;margin-left:10px"><label style="width:120px">门店名称：</label>
						<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="storeName" name="storeName" value="${ebStore.storeName}" />
						<font color="red"> *请填写门店名称</font></p>
						 
						
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">门店营业时间：</label>
						<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="storeBusinessTime" name="storeBusinessTime" value="${ebStore.storeBusinessTime}"/>
						<font color="red"> *请填写营业时间如08:00-18:00</font></p>
						
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">门店电话：</label>
						<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;" id="storePhone" name="storePhone" value="${ebStore.storePhone}"/>
						<font color="red"> *请填写门店电话</font></p>
						
						
						<p style="margin-top:10px;margin-left:10px"><label style="width:120px">门店所在地址：</label><input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" type="text" id="contactAddress" name="storeAddr" style="width: 408px;" value="${ebStore.storeAddr}" maxlength="150"/><input type="button" value="坐标选位" onclick="openMap(this)" style="display: inline-block;margin-top: 5px;margin-left: 5px;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;"/><font color="red"> *请选择门店地址</font></p>
						<p style="margin-top:10px;margin-left:10px"><label>经度：<input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="longitude" name="storeLongitude" value="${ebStore.storeLongitude}" type="text" style="width: 132px;" >   纬度：<input style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;border-radius: 3px;padding: 0px 10px;" id="latitude" name="storeLatitude" value="${ebStore.storeLatitude}" type="text" style="width: 132px;" ></label></p>
						<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no" style="display: none;"></iframe>
						</div>
                    </li>
                    
             <shiro:hasPermission name="merchandise:user:edit">
            <div class="msg-btn">
                <input  type="button" onclick="bent()" style="display: inline-block;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;" value="保存"></a>
                <input  type="button" onclick="goback()" style="display: inline-block;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;" value="返回"></a>
               
                
            </div>
			</shiro:hasPermission>
        </div>
      </form>
    </div>
    <script type="text/javascript">
       function bent(){
		 var storeId=$('#storeId').val();
		 var storeName=$('#storeName').val();
		 var storeBanner=$('#storeBanner').val();
		 var storeAddr=$('#contactAddress').val();
		 var storeLongitude=$('#longitude').val();
		 var storeLatitude=$('#latitude').val();
		 var storeBusinessTime=$('#storeBusinessTime').val();
		 var storePhone=$('#storePhone').val();
		 var account=$('#account').val();
		 var password=$('#password').val();
		 var integer1 = /^(0|86|17951)?(13[0-9]|15[012356789]|17[01678]|18[0-9]|14[57])[0-9]{8}$/; 
		 var integer2 = /^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
		 if(!integer1.test(storePhone)&&!integer2.test(storePhone)){
			 alertx("电话格式不正确，请输入正确的固定电话或手机号");
		         return false;
		 } 
	     $.ajax({
			    url : "${ctxsys}/psstore/savestore",   
			    type : 'post',
			    data:{
					storeId:storeId,
					storeName:storeName,
					storeBanner:storeBanner,
					storeAddr:storeAddr,
					storeLongitude:storeLongitude,
					storeLatitude:storeLatitude,
					storeBusinessTime:storeBusinessTime,
					storePhone:storePhone,
					account:account,
					password:password
					},
					cache : false,
			    success : function (data) {
			     if(data.code=='00'){
			        alertx(data.msg);
			        window.location.href="${ctxsys}/psstore/storeEdit?storeId="+data.storeId; 
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