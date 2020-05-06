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
    <title>我的余额</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/my-balance.css">
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');



        })
         function back(){
        	  location.href='${ctxweb}'+'/h5/agentUser/home';
          }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui-1.png" onclick="back();">
        <span>我的余额</span>
    </div>

    <div class="context">
        <div class="lei">
            <p>可用余额 (元)</p>
            <span>${sysOffice.currentAmt }</span>
            <div>
                冻结余额：${freezeAmt }元
            </div>
        </div>

        <div class="detailed">
            <ul>
                <li>
                    <a href="${ctxweb}/h5/agentUser/agentAmtDetail">
                        已激励金额：<b>${changeAmt }</b>元
                        <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
                        <span>查看明细</span>
                    </a>
                </li>
                <li>
                    <a href="${ctxweb}/h5/agentUser/withdrawalBank">
                        <img class="tixian" src="${ctxStatic}/h5/agent/images/tixian.png" alt="">
                        提现
                        <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
                    </a>
                </li>
                <li>
                    <a href="${ctxweb}/h5/agentUser/myBankcard">
                        <img class="tixian" src="${ctxStatic}/h5/agent/images/ying-code.png" alt="">
                        我的银行卡
                        <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
                        <span>${pBankCount }张</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

</body>
</html>