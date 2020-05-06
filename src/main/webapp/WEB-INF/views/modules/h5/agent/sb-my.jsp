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
    <title>我的积分</title>
 	<link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/sb-my.css">
    
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
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>我的积分</span>
        <a href="${ctxweb}/h5/agentUser/agentLoveDetail">查看积分明细</a>
    </div>

    <div class="context">
        <div class="lei">
            <p>今日积分指数</p>
            <span>${loveIndex }</span>
        </div>

        <div class="detailed">
            <ul>
                <li>
                    <p><fmt:formatNumber type="number" value="${sysOffice.usableLove }" pattern="0.0000" maxFractionDigits="4"/></p>
                    <span>可激励积分 (个)</span>
                    <a href="${ctxweb}/h5/agentUser/usableLoveDetail">详情</a>
                </li>
                <li>
                    <p><fmt:formatNumber type="number" value="${sysOffice.currentLove }" pattern="0.0000" maxFractionDigits="4"/></p>
                    <span>当前积分 (个)</span>
                </li>
                <li>
                    <p><fmt:formatNumber type="number" value="${loveCount }" pattern="0.0000" maxFractionDigits="4"/></p>
                    <span>今日新增 (个)</span>
                </li>
                <li>
                    <p><fmt:formatNumber type="number" value="${sysOffice.totalLove }" pattern="0.0000" maxFractionDigits="4"/></p>
                    <span>累计积分 (个)</span>
                </li>
                <li>
                    <p><fmt:formatNumber type="number" value="${sysOffice.frozenLove }" pattern="0.0000" maxFractionDigits="4"/></p>
                    <span>冻结积分 (个)</span>
                </li>
                
            </ul>

            <%--<a class="sb-mx" href="${ctxweb}/h5/agentUser/agentLoveDetail">
                查看积分明细
                <img src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
            </a>
        --%></div>
    </div>

</body>
</html>