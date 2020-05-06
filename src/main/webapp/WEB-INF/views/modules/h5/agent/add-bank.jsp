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
    <title>添加银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script src="${ctxStatic}/h5/js/bankCardCheck.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/add-bank.css">
    
    
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');


            $('.tishi-del').click(function(){
                $('.tishi').hide();
            });
        })
        function next(){
        	var account=$("#account").val();
        	var t=luhmCheck(account);
        	if(t){
        		location.href="${ctxweb}/h5/agentUser/addBank?type=2&account="+account;
        	}else{
        		$(".tishi").css("display","block");
        	}
        }
        function back(){
      	  location.href='${ctxweb}'+'/h5/agentUser/myBankcard';
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>添加银行卡</span>
    </div>

    <div class="context">
        <p class="tis">请添加持卡本人的银行卡</p>
        <ul>
            <li>
                <span>卡号</span>
                <input type="text" id="account" placeholder="输入储蓄卡卡号">
            </li>
        </ul>
    </div>
    <a class="xia" onclick="next();" >下一步</a>

    <!--提示框-->
    <div class="tishi">
        <div class="tishi-box">
            <p>提示</p>
            <span>请输入正确的银行卡号</span>
            <a class="tishi-del" href="javascript:;">确定</a>
        </div>
    </div>
</body>
</html>