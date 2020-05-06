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
    <title>下载${fns:getProjectName()}</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/download.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script>
        $(function() {
            $('html').css('font-size', $('body').width() / 10 + 'px');

        })
    </script>
</head>
<body>
    <div class="download">
        <img src="${ctxStatic}/h5/images/load-bg.png" alt="">
        <div class="download-box">
            <img src="${ctxStatic}/h5/images/logo-h5.png" alt="">
            <ul>
                <li>
                    <a href="https://itunes.apple.com/cn/app/id1403740487"><img src="${ctxStatic}/h5/images/btn-ios.png" alt=""></a>
                </li>
                <li>
                    <a href="${addr}"><img src="${ctxStatic}/h5/images/btn-and.png" alt=""></a>
                </li>
            </ul>
            <p>${fns:getCompanyName()}</p>
        </div>
    </div>


    <div class="weChatHint">
        <img src="${ctxStatic}/h5/images/weixin-tishi.png"/>
    </div>

    <script>
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger') {
            document.getElementsByClassName("weChatHint")[0].style.display = "block";
        }



    </script>
</body>
</html>