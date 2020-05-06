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
    <title>我的银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/my-bankcard.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            findattr();
        })
        
        function findattr() {
        	 $(".card-list").find("li").each(function(){ 
        		var p= $(this).find("p").text();
        		var img= $(this).find("img");
        		var imgstr="bank-logo5.png";
        		var bg="bg4";
        		
        		if(p.indexOf("农业") != -1){
        			imgstr="bank-ny.png";
        			bg="bg3";
        		}else if(p.indexOf("邮政") != -1){
        			imgstr="bank-yz.png";
        			bg="bg3";
        		}else if(p.indexOf("建设") != -1){
        			imgstr="bank-js.png";
        			bg="bg2";
        		}else if(p.indexOf("招商") != -1){
        			imgstr="bank-zs.png";
        			bg="bg1";
        		}else if(p.indexOf("中国银行") != -1){
        			imgstr="bank-zg.png";
        			bg="bg1";
        		}else if(p.indexOf("工商") != -1){
        			imgstr="bank-gs.png";
        			bg="bg1";
        		}else if(p.indexOf("交通") != -1){
        			imgstr="bank-jt.png";
        			bg="bg2";
        		}else if(p.indexOf("中信") != -1){
        			imgstr="bank-zx.png";
        			bg="bg1";
        		}else if(p.indexOf("兴业") != -1){
        			imgstr="bank-xy.png";
        			bg="bg2";
        		}
        		img.attr("src","${ctxStatic}/h5/agent/images/"+imgstr+"");
        		$(this).attr("class",""+bg+"");
        	})
        }
        function back(){
      	  location.href='${ctxweb}'+'/h5/agentUser/agentBalance';
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>我的银行卡</span>
        <a href="${ctxweb}/h5/agentUser/addBank?type=1"><img src="${ctxStatic}/h5/agent/images/add-icon.png" style="padding-top: 26px;"></a>
    </div>

    <div class="context">
        <ul class="card-list">
        <c:forEach items="${banks}" var="pc">
            <li class="bg2">
                <a href="${ctxweb}/h5/agentUser/bankStyle?id=${pc.id}">
                    <div class="bank-top">
                        <div class="bank-logo">
                            <img src="${ctxStatic}/h5/agent/images/bank-logo5.png" alt="">
                        </div>
                        <div class="bank-name">
                            <span>${pc.bankName}</span>
                            <p>${fns:getNameOfBank(pc.account)}</p>
                        </div>
                    </div>
                    <p class="bank-num"><b>**** **** ****</b> <span>${fns:getNumOfBank(pc.account,4)}</span></p>
                </a>
            </li>
            </c:forEach>
        </ul>
    </div>

</body>
</html>