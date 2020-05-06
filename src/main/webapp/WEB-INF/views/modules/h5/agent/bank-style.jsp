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
    <title>银行卡</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/bank-style.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
        
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>    
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.manage-del').click(function(){
                $('.manage').hide()
            });
            $('.manage-show').click(function(){
                $('.manage').show()
            });
            
            findattr();
        })
        
        function del(id){
        	  //询问框
        	  layer.open({
        	    content: '您确定要删除吗？'
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	      layer.close(index);
        	      location.href='${ctxweb}'+'/h5/agentUser/delBank?id='+id;
        	    }
        	  });
        	    
        }
        function sel(id){
        	  //询问框
        	  layer.open({
        	    content: '您确定要设置吗？'
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	      layer.close(index);
        	      location.href='${ctxweb}'+'/h5/agentUser/setDefaultBank?id='+id;
        	    }
        	  });
        	    
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
        	  location.href='${ctxweb}'+'/h5/agentUser/myBankcard';
          }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <a class="manage-show" href="javascript:;">管理</a>
    </div>

    <div class="context">
        <div class="withdrawal">
            <div>
                <img id="image"src="${ctxStatic}/h5/agent/images/bank-logo5.png" style="padding-top: 31px;">
            </div>
            <span id="bankName">${pmAgentBank.bankName}</span>
            <p class="bank-num"><b>**** **** ****</b> <span>${fns:getNumOfBank(pmAgentBank.account,4)}</span></p>
        </div>
    </div>

    <!--管理框-->
    <div class="manage">
        <div class="manage-box">
            <div style="height: 1.28rem;background: #F2F2F2"></div>
            <ul>
                <li>
                    <a href="javascript:;" onclick="sel(${pmAgentBank.id});">设为默认</a>
                </li>
                <li>
                    <a href="javascript:;" onclick="del(${pmAgentBank.id});">删除银行卡</a>
                </li>
            </ul>
            <a class="manage-del" href="javascript:;">取消</a>
        </div>
    </div>
</body>
</html>