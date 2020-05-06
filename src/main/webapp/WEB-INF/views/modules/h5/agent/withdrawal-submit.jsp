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
    <title>提现提交</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/withdrawal-submit.css">
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');



        })
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>提现</span>
        <a href="withdrawal-record.html">提现记录</a>
    </div>

    <div class="context">
        <div class="withdrawal">
            <img src="${ctxStatic}/h5/agent/images/submit-icon.png" alt="">
            <p>您的提现申请已提交！</p>
        </div>
    </div>

</body>
</html>