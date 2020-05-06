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
    <title>验证银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/verify-bank.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>    
    <script>
    var accountName="${pmAgentBank.accountName}";
    var account="${pmAgentBank.account}";
    var bankName="${pmAgentBank.bankName}";
    var phoneNum="${pmAgentBank.phoneNum}";
    var subbranchName="${pmAgentBank.subbranchName}";
    var idcard="${pmAgentBank.idcard}";
    
    var bb=60;
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.yanzhen').html(bb+'s后重发');
            var timea=setInterval(function(){
                bb--;
                if (bb==0){
                    clearInterval(timea);
                    $('.yanzhen').html('获取验证码');
                    return;
                }
                $('.yanzhen').html(bb+'s后重发');
            },1000);
            
        })
        
          function yanzhen(){
       	   if(bb==0){
              sendSmsCode();
                 bb=60;
               $('.yanzhen').html(bb+'s后重发');
               var timea=setInterval(function(){
                   bb--;
                   if (bb==0){
                       clearInterval(timea);
                       $('.yanzhen').html('获取验证码');
                       return;
                   }
                   $('.yanzhen').html(bb+'s后重发');
               },1000);
       	   }
          }
        
        function saveBankInfo(){
        	$.ajax({
	             type: "post",
	             url: '${ctxweb}'+"/h5/agentUser/saveBank",
	             data: {accountName:accountName, account:account, 
	            	    bankName:bankName, phoneNum:phoneNum, 
	            	    subbranchName:subbranchName,idcard:idcard,smscode:$("#smscode").val()},
	             beforeSend:function(){
	            	 layer.open({type: 2,content: '保存中'});
	             },
	             success: function(data){
	            	 layer.closeAll();
	            	 if(data=="00"){
	            		 layer.open({type: 2,content: '添加成功'});
	            		 location.href='${ctxweb}'+'/h5/agentUser/myBankcard';
	            	 }else{
	            		 layer.open({content: data,skin: 'msg',time: 2 });
	            	 }
	             }
	         });
        }
        function sendSmsCode(){
        	$.ajax({
	             type: "get",
	             url: '${ctxweb}'+"/h5/agentUser/sendSmsCode",
	             data: {phoneNum:phoneNum},
	             beforeSend:function(){
	            	 layer.open({type: 2,content: '发送中'});
	             },
	             success: function(data){
	            	 layer.closeAll();
	            	 if(data=="00"){
	            		 layer.open({content: "发送成功",skin: 'msg',time: 2 });
	            	 }else{
	            		 layer.open({content: data,skin: 'msg',time: 2 });
	            	 }
	             }
	         });
        }
        function changeSmsCode(value){
        	if(value!=""&&value.length>5){
        		$(".xia").addClass("active");
        	}else{
        		$(".xia").removeClass("active");
        	}
        }
        function next(){
        	var smscode=$("#smscode").val();
        	if(smscode!=""&&smscode.length>5){
        		saveBankInfo();
        	}
        	
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>验证银行卡</span>
    </div>

    <div class="context">
        <p class="tis">验证码已发送至手机：<span>${pmAgentBank.phoneNum}</span>，请按提示操作。</p>
        <ul>
            <li>
                <span>输入验证码</span>
                <input type="text" id="smscode" placeholder="请输入验证码" oninput="changeSmsCode(this.value);">
                <a class="yanzhen" onclick="yanzhen();">60s后重发</a>
            </li>
        </ul>
    </div>
    <!--可以点击时，背景变红，加class：active-->
    <a class="xia" onclick="next();">下一步</a>
</body>
</html>