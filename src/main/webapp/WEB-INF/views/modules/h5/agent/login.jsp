<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
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
    <title>登录</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/login.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>

    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.xxr').click(function(){
                $(this).siblings('input').val('')
            });
            var ty=0;
            $('.see-pass').click(function(){
                if(ty==1){
                    var val=$(this).siblings('input').val();
                    $(this).siblings('input').remove();
                    $(this).closest('li').prepend('<input type="password" placeholder="密码" value="'+val+'">');
                    ty=0;
                }else {
                    var val=$(this).siblings('input').val();
                    $(this).siblings('input').remove();
                    $(this).closest('li').prepend('<input type="text" placeholder="密码" value="'+val+'">');
                    ty=1;
                }
            });
        })
        
        
        
        function login(){
    		var $loginName=$("#loginName").val();
    		var $password=$("#password").val();
    		if(isEmpty($loginName)){
    			layer.open({content: '账号格式不正确',skin: 'msg',time: 2 });
    		}else if(isEmpty($password)){
    			layer.open({content: '请输入密码',skin: 'msg',time: 2 });
    		}else{
    			$.ajax({
    	             type: "get",
    	             url: '${ctxweb}'+"/h5/agentUser/login",
    	             data: {loginName:$loginName, password:$password},
    	             beforeSend:function(){
    	            	 layer.open({type: 2,content: '登录中'});
    	             },
    	             success: function(data){
    	            	 layer.closeAll();
    	            	 if(data=="00"){
    	            		 location.href='${ctxweb}'+'/h5/agentUser/home';
    	            	 }else{
    	            		 layer.open({content: data,skin: 'msg',time: 2 });
    	            	 }
    	             }
    	         });
    		}
    	}
    	
    	
    	// 验证手机号
    	function isPhoneNo(phone) { 
    	 var pattern = /^1[34578]\d{9}$/; 
    	 return pattern.test(phone); 
    	}
    	
    	function isEmpty(str){
    		if(str==""){
    			return true;
    		}
    		if(typeof(str)=="undefined"){
    			return true;
    		}
    		return false;
    	}
        
        
        
        
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" alt="" onclick="jsobject.clickBack();">
    </div>
    <div class="logo">
        <img src="${ctxStatic}/h5/agent/images/logo.png" alt="">
        <p>代理中心</p>
    </div>

    <div class="context">
        <ul class="bank-list">
            <li>
                <input type="text" id="loginName" placeholder="账号">
                <img class="xxr" src="${ctxStatic}/h5/agent/images/xx-rzt.png" alt="">
            </li>
            <li>
                <input type="password" id="password" placeholder="密码">
                <img class="see-pass" src="${ctxStatic}/h5/agent/images/see-password.png" alt="">
                <img class="xxr" src="${ctxStatic}/h5/agent/images/xx-rzt.png" alt="">
            </li>
        </ul>

        <a class="que" href="javascript:login();">登录</a>
    </div>
</body>
</html>