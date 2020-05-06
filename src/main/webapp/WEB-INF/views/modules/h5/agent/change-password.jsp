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
    <title>修改密码</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/change-password.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
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
                    $(this).closest('li').prepend('<input type="password" placeholder="确认密码" value="'+val+'">');
                    ty=0;
                }else {
                    var val=$(this).siblings('input').val();
                    $(this).siblings('input').remove();
                    $(this).closest('li').prepend('<input type="text" placeholder="确认密码" value="'+val+'">');
                    ty=1;
                }
            });
        })
        
         
        function changePassword(){
    		var $newPassword=$("#newPassword").val();
    		var $confirmPassword=$("#confirmPassword").val();
    		if(isEmpty($newPassword)){
    			layer.open({content: '请输入新密码',skin: 'msg',time: 2 });
    		}else if(isEmpty($confirmPassword)){
    			layer.open({content: '请输入确认密码',skin: 'msg',time: 2 });
    		}else if($newPassword!=$confirmPassword){
    			layer.open({content: '密码不一致',skin: 'msg',time: 2 });
    		}else{
    			$.ajax({
    	             type: "post",
    	             url: '${ctxweb}'+"/h5/agentUser/updatePasswd",
    	             data: {newPassword:$newPassword, confirmPassword:$confirmPassword},
    	             beforeSend:function(){
    	            	 layer.open({type: 2,content: '修改中'});
    	             },
    	             success: function(data){
    	            	 layer.closeAll();
    	            	 if(data=="00"){
    	            		 layer.open({content: '修改成功',skin: 'msg',time: 2 });
    	            	 }else{
    	            		 layer.open({content: data,skin: 'msg',time: 2 });
    	            	 }
    	             }
    	         });
    		}
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
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>修改密码</span>
    </div>

    <div class="context">
        <ul class="bank-list">
            <li>
                <input id="newPassword" placeholder="新密码">
                <img class="xxr" src="${ctxStatic}/h5/agent/images/xx-rzt.png" alt="">
            </li>
            <li>
                <input id="confirmPassword" placeholder="确认密码">
                <img class="see-pass" src="${ctxStatic}/h5/agent/images/see-password.png" alt="">
                <img class="xxr" src="${ctxStatic}/h5/agent/images/xx-rzt.png" alt="">
            </li>
        </ul>

        <!--可以点击时，背景变红，加class：active-->
        <a class="que" href="javascript:changePassword();">确定</a>
    </div>
</body>
</html>