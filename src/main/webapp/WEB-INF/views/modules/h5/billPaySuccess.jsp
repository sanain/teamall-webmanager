<%@page contentType="text/html; charset=utf-8" language="java"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
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
		<title>快钱支付结果</title>
		<link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
		<link rel="stylesheet" href="${ctxStatic}/h5/css/findPass.css">
	    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
	    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
	</head>
	<script type="text/javascript">
	    $(function(){
			$('html').css('font-size',$('html').width()/10+'px');
        })
	function callJsConfirm(){
		var u = navigator.userAgent;
	    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
	    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
	    if(isAndroid){
	     billPay.clickBack();
	    }
	    if(isiOS){
		    // document.getElementById('dealId').innerHTML= 'iosiosiosiosiosiosiosios';
	      if (confirm('confirm', 'Objective-C call js to show confirm')) {
                document.getElementById('jsParamFuncSpan').innerHTML
                = 'true';
            } else {
                document.getElementById('jsParamFuncSpan').innerHTML
                = 'false';
            }
	    }
	}
	</script>
<BODY>
<div class="head-nav">
    <span>银行卡支付三</span>
</div>

    <div class="context">
        <p>快钱支付结果</p>
        <ul>
            <li>快钱交易号：</li>
            <li id="dealId">${dealId}</li>
        </ul>
        <ul>
            <li>订单号：</li>
            <li>${orderId}</li>
        </ul>
        <ul>
            <li>订单金额：</li>
            <li>${orderAmount/100}</li>
        </ul>
        <ul>
            <li>下单时间：</li>
            <li>${orderTime}</li>
        </ul>
        <ul>
            <li>处理结果：</li>
            <li>${msg}</li>
        </ul>
    </div>
    <div class="reg-a">
        <a href="javascript:;" onclick="callJsConfirm();">关闭</a>
    </div>

</BODY>
</HTML>