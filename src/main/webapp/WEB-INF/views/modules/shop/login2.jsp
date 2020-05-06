<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>${fns:getProjectName()} 商户登录</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/login1.css?v=2">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <style type="text/css">
    body,html{width:100%;height:100%;}
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
				$("#captchaImg").attr("src","${ctxweb}/randomCode");
			});
    	})
    </script>
       <script type="text/javascript">   
			if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
				top.location = "${ctxweb}/shoplogin";
			}
	</script> 
</head>
<body style="position:relative;background:url(${fns:getSysSource(14)}) no-repeat center center;background-size:100% 100%;">
<%--     <div class="logo-div"> 
        <img src="${ctxStatic}/sbShop/images/logo.jpg?v=1" alt="" style="width:11.5%;">
    </div> --%>
    <form id="loginForm" class="form-signin" action="${ctxweb}/shoplogin" method="POST" style="position:absolute;left:70%;top:30%;width:370px;height:320px;">

        <div class="login-div">
            <div class="login-list">
                <p>登录 <%-- <a href="javascript:;">立即入驻 ></a> --%></p>
                <ul>
                    <li>
                        <input  id="username" name="username" placeholder="账号" type="text">
                    </li>
                    <li>
                        <input  id="password" name="password" placeholder="密码" type="password"  autocomplete="new-password">
                    </li>
                     <li>
                        <input placeholder="验证码" name="imageCode" type="text">
                        <span><img id="captchaImg"width="75px" height="33px" src="${ctxweb}/randomCode" alt=""></span>
                    </li> 
                    
                    <li><button type="submit">登录</button></li>
                </ul>
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
    	<p>Copyright © 2015-${fns:getConfig('copyrightYear')} ${fns:getSysSource(16)}  保留一切权利</p>
        <p>${fns:getSysSource(23)}</p>
    </div>
</body>
</html>
