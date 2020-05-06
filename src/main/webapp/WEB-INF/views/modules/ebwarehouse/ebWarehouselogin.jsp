<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>仓库登录</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/login1.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css">
    <script src="${ctxStatic}/supplyshop/js/jquery.min.js"></script>
    <style type="text/css">
    	.xcq{display:none;position:fixed;width:200px;height:150px;text-align:center;z-index:10000;background:#fff;top:50%;left:50%;margin-left:-100px;margin-top:-75px;border-radius: 5px;overflow:hidden;}
    	.xcq p{height:35px;line-height:35px;text-align:center;background:#f0f0f0;}
    	.xcq span{display:inline-block;margin:15px 0 20px 0;}
    	.xcq div{text-align:center;}
    	.xcq a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius: 5px;}
    </style>
    <script type="text/javascript">
    	$(function(){
    		$('.xcq a').click(function(){
    			$('.xcq').hide();
    		});
    		var message="";
			message=$('.message').attr('data-tid');
			if(message!=""){
				$('.xcq').show();
				
			}
			$("#captchaImg").click(function(){
				$("#captchaImg").attr("src","${ctxweb}/supplyShop/randomCode");
			});
    	});
    	
 /*    	function Loginsubmit(){
    		var account=$("#account").val();
    		var password=$("#password").val();
    		var imageCode=$("#imageCode").val();
   	     $.ajax({
			    url : "${ctxweb}/ebWarehouseItem/loginstore",   
			    type : 'post',
			    data:{
			    	account:account,
			    	password:password,
			    	imageCode:imageCode,
				 
					},
					cache : false,
			    success : function (data) {
			     if(data.code=='00'){
			     
			        window.location.href="${ctxweb}"+data.url; 
			      }else{
			       alertx(data.msg);
			      }
			    }
	         });
    	} */
    	
    </script>
       <script type="text/javascript">   
			if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
				top.location = "${ctxweb}/ebWarehouseItem/ebWarehouseLogin";
			}
	</script> 
</head>
<body>
    <div class="logo-div">
        <img src="${ctxStatic}/supplyshop/images/logo.jpg?v=1" alt="" style="width:11.5%;">
    </div>
     <form id="loginForm" class="form-signin" action="${ctxweb}/ebWarehouseItem/ebWarehouseLogin" method="POST">  
    <div class="login" style="background: url('${ctxStatic}/supplyshop/images/login_bg.jpg') no-repeat;background-size:100%">
       <input type="hidden" id="flag" name="flag" value="1">
        <div class="login-div">
            <div class="login-list">
                <p>登录</p>
                <ul>
                    <li>
                        <input  id="account" name="account" placeholder="账号" type="text">
                    </li>
                    <li>
                        <input  id="password" name="password" placeholder="密码" type="password">
                    </li>
                     <li>
                        <input placeholder="验证码" name="imageCode" type="text" id="imageCode">
                        <span><img id="captchaImg"width="75px" height="33px" src="${ctxweb}/supplyShop/randomCode" alt=""></span>
                    </li> 
                   <li><button type="submit">登录</button></li> 
                 <!--    <li><button type="button" onclick="Loginsubmit();">登录</button></li> -->
                </ul>
            </div>
        </div>
    </div>
    </form>  
   <div class="xcq">
    <p>提示</p>
	<span class="message" data-tid="${messager}">${messager}</span>
	<div>
		<a href="javascript:;">确认</a>
	</div>
   </div>
    <div class="login-bottom">
    	<p>Copyright © 2015-${fns:getConfig('copyrightYear')} ${fns:getCompanyName()} business.51trly.com 保留一切权利</p>
        <p>客服热线：4000338869（周一到周六 09:00-18:00）</p>
    </div>
</body>
</html>
