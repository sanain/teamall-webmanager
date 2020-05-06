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
    <title>主页</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/home.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');


        })
    </script>
</head>
<body>
    <div class="head-nav">
        <span>${agentUser.loginName}${fns:getProjectName()}</span>
        <a href="${ctxweb}/h5/agentUser/formAccountManage"><img src="${ctxStatic}/h5/agent/images/people-icon.png" alt=""></a>
    </div>

    <div class="context">
        <img class="banner-img" src="${ctxStatic}/h5/agent/images/banner1.png" alt="">
        <ul class="list-icon">
            <li>
                <a href="${ctxweb}/h5/agentUser/businessStatistics">
                    <img src="${ctxStatic}/h5/agent/images/icon-yee.png" alt="">
                    <p>营业统计</p>
                </a>
            </li>
            <li>
                <a href="${ctxweb}/h5/agentUser/incomeStatistics">
                    <img src="${ctxStatic}/h5/agent/images/icon-shouyi.png" alt="">
                    <p>收益统计</p>
                </a>
            </li>
            <li>
                <a href="${ctxweb}/h5/agentUser/vipManagement">
                    <img src="${ctxStatic}/h5/agent/images/icon-vip.png" alt="">
                    <p>商家管理</p>
                </a>
            </li>
            <li>
                <a href="${ctxweb}/h5/agentUser/information">
                    <img src="${ctxStatic}/h5/agent/images/icon-msg.png" alt="">
                    <p>消息</p>
                </a>
            </li>
            <li>
                <a href="${ctxweb}/h5/agentUser/agentShanbao">
                    <img src="${ctxStatic}/h5/agent/images/icon-sb.png" alt="">
                    <p>我的${fns:getProjectName()}</p>
                </a>
            </li>
            <li>
                <a href="${ctxweb}/h5/agentUser/agentBalance">
                    <img src="${ctxStatic}/h5/agent/images/icon-yue.png" alt="">
                    <p>我的余额</p>
                </a>
            </li>
        </ul>
    </div>

</body>
</html>