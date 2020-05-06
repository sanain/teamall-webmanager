<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctxStatic}/h5/css/wxh5-style.css">
<title>微信H5支付结果</title>
</head>

<body>
<div class="pay_su">
	<div class="tipDiv">
    	<img style="width: 100%;"src="${ctxStatic}/h5/images/success.png">
        <p class="t">支付成功</p>
        <a type="button" style="width: 17%;position: absolute;left: 46%"class="btn btn-success"  id="finished">完成</a>
    </div>
</div>

<script src="${ctxStatic}/h5/js/jquery.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
wx.config({
    debug: false,
    
    jsApiList: [
      // 所有要调用的 API 都要加到这个列表中
      'closeWindow',
      'callJsConfirm',
    ]
  });
  $(document).ready(function(){
	  wx.ready(function () {
	    // 在这里调用 API
	    $("#finished").click(function(){
	    	    window.close();
	    	    callJsConfirm();
	        	wx.closeWindow();
	        });
	    });
  });
  
function callJsConfirm(){
	var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if(isAndroid){
    	window.close();
    	//window.location =  androidSchema; //Androind App 协议
    // billPay.clickBack();
    }
    if(isiOS){
    	window.location = "IOSShanBaoShare://"; //IOS App 协议
     /* if (confirm('confirm', 'Objective-C call js to show confirm')) {
            document.getElementById('jsParamFuncSpan').innerHTML
            = 'true';
        } else {
            document.getElementById('jsParamFuncSpan').innerHTML
            = 'false';
        }*/
    }
}

</script>
</body>
</html>
