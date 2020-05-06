<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提现申请</title>
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
    <script src="${ctxStatic}/sbShop/js/pmAmtLogForm.js?v=8"></script>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">资金提现</span>
	</div>
<input type="hidden" value="${ctxweb}" id="ctxweb"/>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li><a href="${ctxweb}/shop/shopPmAmtLog/index">门店结算</a></li>
		<li><a href="${ctxweb}/shop/shopPmAmtLog/list">收支明细</a></li>
        <li><a href="${ctxweb}/shop/shopPmAmtLog/applyToCashlist">提现记录</a></li>
		<li class="active"><a href="#">提现申请</a></li>

	</ul>
	<div class="breadcrumb form-search ">
		<div class="control-group">
			<label class="control-label">门店名称:</label>
			<div class="controls">
				<label style="color: #009688;">${shopName}</label>
			</div>
		</div>
		<div class="control-group">
            <label class="control-label">可提现金额:</label>
            <div class="controls">
				<label style="color: #009688;">${currentAmt}元</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">提现账户:</label>
            <div class="controls">
				<label style="color: #009688;">
					<select id="pmUserBanks" name="pmUserBanks">
						<c:forEach items="${pmUserBanks}" var="pmUserBank">
						<option value="${pmUserBank.id}">${pmUserBank.account}  ${pmUserBank.bankName}</option>
						</c:forEach>
					</select>
				</label>
            </div>
        </div>
		<div class="control-group">
			<label class="control-label">请输入提现金额（注：提现金额为100的整数倍）:</label>
			<div class="controls">
				<label style="color: #009688;">
				<input id="amt" name="amt" onkeyup="this.value=this.value.replace(/\D/g,'')" htmlEscape="false" maxlength="500" class="model" value=""/>
				</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请输入提现密码:</label>
			<div class="controls">
				<label style="color: #009688;">
					<input id="payPassword" name="payPassword" type="password"  autocomplete="new-password" htmlEscape="false" maxlength="500" class="model" value=""/>
				</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="submitBtn" class="btn btn-primary" style="background-image: linear-gradient(to bottom,#000000,#000000);" type="button" value="提交申请"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</div>
</div>
</body>
</html>