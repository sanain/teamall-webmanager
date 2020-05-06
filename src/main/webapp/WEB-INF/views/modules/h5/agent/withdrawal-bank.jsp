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
    <title>提现-银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script src="${ctxStatic}/h5/js/jquery.cookies.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/withdrawal-bank.css">
    
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');
            findattr();
            
        })
        function getCardInfo(){ 
        	var cardInfo=$.cookie("cardInfo");
        	console.log(cardInfo)
        	
        	
		} 
        
        //提现
         function withdrawal(){
    		var $currentAmt=$("#currentAmt").val();
    		var $bankId=$("#bankId").text();
    		if(isEmpty($currentAmt)){
    			layer.open({content: '提现金额不可空',skin: 'msg',time: 2 });
    		}else if(isEmpty($bankId)){
    			layer.open({content: '银行卡号不可空',skin: 'msg',time: 2 });
    		}else{
    			$.ajax({
    	             type: "get",
    	             url: '${ctxweb}'+"/h5/agentUser/withdrawal",
    	             data: {bankId:$bankId, amt:$currentAmt},
    	             beforeSend:function(){
    	            	 layer.open({type: 2,content: '提现中'});
    	             },
    	             success: function(data){
    	            	 layer.closeAll();
    	            	 if(data=="00"){
    	            		 location.href='${ctxweb}'+'/h5/agentUser/withdrawalSubmit';
    	            	 }else{
    	            		 layer.open({content: data,skin: 'msg',time: 2 });
    	            	 }
    	             }
    	         });
    		}
    	}
        function changeAmt(amt){
        	if(amt<1){
        		layer.open({content: "提现金额不能小于1",skin: 'msg',time: 3 });
        		$("#shen").attr("class","shen");
        		//$("#shen").attr("disabled","true");
        	}else{
        		$("#shen").attr("class","shen active");
        	}
        }
        		
       
        function isEmpty(str){
    		if(str==""){
    			return true;
    		}
    		if(typeof(str)=="undefined"){
    			return true;
    		}
    		return false;
    	}
        
        function findattr() {
    		var p= $("#bankName").text();
    		var img=$("#image");
    		var imgstr="bank-logo5.png";
    		
    		if(p.indexOf("农业") != -1){
    			imgstr="bank-ny.png";
    		}else if(p.indexOf("邮政") != -1){
    			imgstr="bank-yz.png";
    		}else if(p.indexOf("建设") != -1){
    			imgstr="bank-js.png";
    		}else if(p.indexOf("招商") != -1){
    			imgstr="bank-zs.png";
    		}else if(p.indexOf("中国银行") != -1){
    			imgstr="bank-zg.png";
    		}else if(p.indexOf("工商") != -1){
    			imgstr="bank-gs.png";
    		}else if(p.indexOf("交通") != -1){
    			imgstr="bank-jt.png";
    		}else if(p.indexOf("中信") != -1){
    			imgstr="bank-zx.png";
    		}else if(p.indexOf("兴业") != -1){
    			imgstr="bank-xy.png";
    		}
    		img.attr("src","${ctxStatic}/h5/agent/images/"+imgstr+"");
      }
        function back(){
        	location.href="${ctxweb}/h5/agentUser/agentBalance";
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>提现</span>
        <a href="${ctxweb}/h5/agentUser/withdrawalRecord?id=${bank.id}">提现记录</a>
    </div>

    <div class="context">
        <div class="withdrawal">

            <c:if test="${empty bank}">
	            <!--没有银行卡-->
	            <a class="bank-no" href="${ctxweb}/h5/agentUser/addBank?type=1">
	                <span>请添加银行卡</span>
	                <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
	            </a>
			</c:if>
            <c:if test="${not empty bank}">
	            <!--有银行卡-->
	            <a class="bank-yes" href="${ctxweb}/h5/agentUser/selectBank">
	                <div class="ka-img">
	                    <img src="${ctxStatic}/h5/agent/images/bank-logo5.png" id="image">
	                </div>
	                <div class="ka-msg">
	                    <span style="display:none" id="bankId">${bank.id}</span>
	                    <span id="bankName">${bank.bankName}</span>
	                    <p id="account">尾号${fns:getNumOfBank(bank.account,4)}</p>
	                </div>
	                <img class="jian" src="${ctxStatic}/h5/agent/images/a-jiantou.png" alt="">
	            </a>            
            </c:if>

        </div>

        <div class="jin-e">
            <p>提现金额</p>
            <div>
                <b>¥</b>
                <input type="number" id="currentAmt" oninput="changeAmt(this.value)">
            </div>
            <span>可提现余额${currentAmt }</span>
        </div>
    </div>

    <div class="gui">
        <p>提现规则：</p>
        <p>1.提现金额必须为100的整数倍</p>
        <p>2.工作日16:00前提现申请，第二个工作日到账</p>
        <p>3.工作日16:00后及节假日提现，第二个工作日到账</p>
        <p>4.申请提现后，提现对应金额进行冻结（冻结金额表示不可重复提现，也未到用户银行卡，如果提现失败会进行冻结，退回电子钱包）</p>
    </div>

    <!--可以点击时，背景变红，加class：active-->
    <a class="shen" id="shen" href="#" onclick="withdrawal();">申请提现</a>
</body>
</html>