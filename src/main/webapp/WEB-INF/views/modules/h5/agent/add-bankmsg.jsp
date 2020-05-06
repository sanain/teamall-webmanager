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
    <title>填写银行卡信息</title>
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/h5/js/card.js"></script>
    <script src="${ctxStatic}/h5/js/bankCardCheck.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/add-bankmsg.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.xie input[type=checkbox]').click(function(){
                if ($(this).is(':checked')){
                    $(this).siblings('label').children('i').show();
                    console.log($('input:checked'))
                }else {
                    $(this).siblings('label').children('i').hide();
                    console.log($('input:checked'))
                }
            });

            $('.tishi-del').click(function(){
                $('.tishi').hide();
            });
            $('.tip').click(function(){
                $('.tishi').show()
            });
        })
        
       
		
		
		
        
        function next(){
        	if($("#subbranchName").val()==""){
        		 layer.open({content: "请输入所属支行",skin: 'msg',time: 2 });
        		 return;
        	}
        	if($("#accountName").val()==""){
        		 layer.open({content: "请输入持卡人",skin: 'msg',time: 2 });
        		 return;
        	}
        	if(!isMobile($("#phoneNum").val())){
        		 layer.open({content: "请输入正确填写您的手机号码",skin: 'msg',time: 2 });
        		 return;
        	}
        	if(!idCardNoUtil.checkIdCardNo($("#idcard").val())){
        		 layer.open({content: "请输入正确的身份证号",skin: 'msg',time: 2 });
        		 return;
        	}
        	
        	$("#inputForm").submit();
        }
        
        function isMobile(mbile){
        	var mobile = /^1[34578]\d{9}$/;
    		return  mobile.test(mbile);
        }
	
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>填写银行卡信息</span>
    </div>
<form:form id="inputForm" modelAttribute="pmAgentBank" action="${ctxweb}/h5/agentUser/addBank?type=3" method="post" class="form-horizontal">
<form:input path="account" type="hidden"/>
<form:input path="bankName" type="hidden"/>
    <div class="context">
        <p class="tis-p">
            <span>开户行</span>
            <b>${pmAgentBank.bankName}</b>
        </p>
        <ul>
            <li>
                <span>所属支行</span>
                <form:input path="subbranchName" required="required" placeholder="请输入所属支行"  />
            </li>
            <li>
                <span>持卡人</span>
                <form:input path="accountName" required="required" placeholder="请输入银行卡名户" />
                <img class="tip ren" src="${ctxStatic}/h5/agent/images/tip-icon.png" alt="">
            </li>
            <li>
                <span>手机号</span>
                <form:input path="phoneNum" required="required" placeholder="请输入银行预留手机号码" />
                <img class="tip" src="${ctxStatic}/h5/agent/images/tip-icon.png" alt="">
            </li>
            <li>
                <span>身份证</span>
                <form:input path="idcard" required="required" placeholder="请输入身份证证件号" />
            </li>
        </ul>
        <div class="xie">
            <p class="checkbox">
                <input checked id="gou" type="checkbox" class="required">
                <label for="gou"><i></i></label>
            </p>
            <span>同意</span>
            <a href="javascript:;">《服务协议》</a>
        </div>
    </div>
      <a id="btnSubmit" class="xia" onclick="next();">下一步</a>
</form:form>
    <!--提示框-->
    <div class="tishi">
        <div class="tishi-box">
            <p>持卡人说明</p>
            <span>为了您的账户资金安全，只能绑定持卡人本人的银行卡</span>
            <a class="tishi-del" href="javascript:;">确定</a>
        </div>
    </div>
</body>
</html>