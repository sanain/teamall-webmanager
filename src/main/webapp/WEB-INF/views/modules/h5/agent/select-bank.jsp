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
    <title>选择银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script src="${ctxStatic}/h5/js/jquery.cookies.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/select-bank.css">
    <script>
    var num="";
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

//            选择银行卡
            $('body').on('click','.bank-list li',function(){
                $(this).children('b').addClass('active').parent().siblings('li').children('b').removeClass('active')
               num= $(this).attr("num");
              //  $.cookie("card",num);
                
            })
        })
        
         function back(){
        	location.href="${ctxweb}/h5/agentUser/withdrawalBank?id="+num;
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>选择银行卡</span>
    </div>

    <div class="context">
        <p class="tis">到账银行卡</p>

        <ul class="bank-list">
        	<c:forEach items="${banks}" var="bank" varStatus="i">
	            <li id="cardNum" num="${bank.id}">
	                <span>${bank.bankName} (${fns:getNumOfBank(bank.account,4)})</span>
	                <c:if test="${i.index==0}"><b class="active"></b></c:if>
	                <c:if test="${i.index>0}"><b class=""></b></c:if>
	            </li>
	        </c:forEach>
        </ul>

        <a class="bank-a" href="${ctxweb}/h5/agentUser/addBank?type=1">
            <span>使用新卡提现</span>
            <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
        </a>
    </div>

</body>
</html>