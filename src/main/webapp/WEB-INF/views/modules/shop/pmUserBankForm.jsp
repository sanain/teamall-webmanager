<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>添加银行卡</title>
	<meta name="decorator" content="default"/>

	<style type="text/css">
		#btnSubmit{
			background: #393D49;
		}

		a{
			color: #009688;;
		}

		a:hover{
			color: #009688;;
		}
		    #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
            
	</style>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/modules/layer/default/layer.css">
    <script src="${ctxStatic}/sbShop/layui/lay/modules/layer.js"></script>
    <script src="${ctxStatic}/sbShop/js/pmUserBankForm.js?v=8"></script>
</head>
<body>
<input type="hidden" value="${ctxweb}" id="ctxweb"/>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">银行卡管理</span>
	</div>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li><a href="${ctxweb}/shop/pmUserBank/list">银行卡列表</a></li>
		<li class="active"><a href="#">添加银行卡</a></li>
	</ul>
	<div class="breadcrumb form-search ">
		<div class="control-group" style="overflow:hidden;margin-top:10px;">
			<label class="control-label" style="float:left;margin-right:20px;width:120px;text-align:right;">交易银行账号:</label>
			<div class="controls" style="float:left;">
				<input id="account" name="account"  style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;" htmlEscape="false" maxlength="500" class="model" value=""/>
			</div>
		</div>
		<div class="control-group" style="overflow:hidden;margin-top:10px;">
            <label class="control-label"  style="float:left;margin-right:20px;width:120px;text-align:right;">开户名（持卡人）:</label>
            <div class="controls" style="float:left;">
                <input id="accountName"  style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;"name="accountName" htmlEscape="false" maxlength="500" class="model" value=""/>
            </div>
        </div>
        <div class="control-group" style="overflow:hidden;margin-top:10px;">
            <label class="control-label" style="float:left;margin-right:20px;width:120px;text-align:right;">开户行:</label>
            <div class="controls" style="float:left;">
                <input id="bankName" style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;" name="bankName" htmlEscape="false" maxlength="500" class="model" value=""/>
            </div>
        </div>
		<div class="control-group" style="overflow:hidden;margin-top:10px;">
			<label class="control-label"  style="float:left;margin-right:20px;width:120px;text-align:right;">所属支行:</label>
			<div class="controls" style="float:left;">
				<input id="subbranchName" style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;" name="subbranchName" htmlEscape="false" maxlength="500" class="model" value=""/>
			</div>
		</div>
		<div class="control-group" style="overflow:hidden;margin-top:10px;">
			<label class="control-label" style="float:left;margin-right:20px;width:120px;text-align:right;">银行预留手机号:</label>
			<div class="controls" style="float:left;">
				<input id="phoneNum"  style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;"name="phoneNum" htmlEscape="false" maxlength="500" class="model" value=""/>
			</div>
		</div>
        <div class="control-group" style="overflow:hidden;margin-top:10px;">
            <label class="control-label" style="float:left;margin-right:20px;width:120px;text-align:right;">验证码:</label>
            <div class="controls" style="float:left;">
                <input id="vCode"   style="width:140px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;margin-right:5px;" name="vCode"  style="width: 95px;" onkeyup="this.value=this.value.replace(/\D/g,'')" autocomplete="new-password" htmlEscape="false" maxlength="100" class="model"/>
                <button id="sendMessageBtn" style="width:80px;height:35px;border-radius:3px;background:#495572;border:0;color:#fff;">获取验证码</button>
            </div>
        </div>
		<div class="control-group"style="overflow:hidden;margin-top:10px;">
			<label class="control-label"style="float:left;margin-right:20px;width:120px;text-align:right;">身份证号:</label>
			<div class="controls" style="float:left;">
				<input id="idcard" name="idcard" htmlEscape="false" maxlength="500" class="model" value="" style="width:230px;height:35px;padding:0;border-radius:3px;border:1px solid #eee;"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="submitBtn" class="btn btn-primary" style="background-image: linear-gradient(to bottom,#000000,#000000);width:80px;height:35px;padding:0;margin-left:150px;" type="button" value="保 存"/>
			<input id="btnCancel"  style="width:80px;height:35px;padding:0;" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</div>
</div>
</body>
</html>