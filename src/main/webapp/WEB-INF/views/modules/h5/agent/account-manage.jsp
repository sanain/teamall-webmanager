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
    <title>账号管理</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/account-manage.css">
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

        })
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>账号管理</span>
    </div>

    <div class="context">
        <ul class="bank-list">
            <li>
                <span>代理账户</span>
                <b>${agentUser.company.code}</b>
            </li>
        </ul>

        <a class="bank-a" href="${ctxweb}/h5/agentUser/formChangePassword">
            <span>修改密码</span>
            <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
        </a>
    </div>
    <a class="xia" href="${ctxweb}/h5/agentUser/logout">退出登录</a>
</body>
</html>