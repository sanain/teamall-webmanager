<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,minimal-ui" name="viewport">
    <meta name="format-detection" content="telephone=no">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta name="x5-page-mode" content="app">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <title>领取优惠券</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
	 <link rel="stylesheet" href="${ctxStatic}/h5/css/commodity-details.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
	   
     <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />

</head>
<body>
  <form action="" id="formid" style="margin-top:45%">
             <input  type="hidden" id="certificateId" name="certificateId" value="${certificateId}">
    <div class="context">
        <ul>
            <li>
                <input placeholder="领取用户" type="text" id="userId" name="userId">
              </li>
        <a class="reg-a" href="javascript:;" onclick="validate()" style="background: #3BC969;">领取</a>
    </div>
    <div class="tis">
        <div class="tis-box">
            <p class="active1" style="display:none"></p>
            <span></span>
        </div>
    </div>
    </form>
    <div class="loading-fixed" style="display:none">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
    <script language="javascript" type="text/javascript">
        
        
        
        function validate() {
        	if($("#userId").val()==''||$("#userId").val()==null||$("#userId").val()==undefined){
             //验证码不能为空
                $('.tis span').text('领取人不能为空')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else{
              $.ajax({
	             type: "POST",
	             url: "${ctxweb}/EbCertificateHtml/ebCertificateUser",
	             data:{
	            	 certificateId:$("#certificateId").val(),
	            	 userId:$("#userId").val()
	             },
	             beforeSend:function(){
	   		     $(".loading-fixed").show();
	   	         },success: function(data){
	   	          $(".loading-fixed").hide();
	   	            $('.tis span').text(data.msg)
	   	            $('.tis p').addClass('active1').removeClass('active2');
	             	$('.tis').show()
	             	setTimeout(function(){$('.tis').hide();},2000);
	   	           
	             }
	         });
             }
           
        }    
     </script>
</body>
</html>