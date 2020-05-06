<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>门店结算</title>
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
		.control-group{border-bottom:0;}
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
       table th{font-weight:normal;}
       .control-group{overflow:hidden;height:25px;margin-top:10px;padding:0;}
       .control-label{float:left;margin-right:15px;}
       .controls{float:left;}
        table{width:850px;}
          table tr th{text-align:left;font-weight:blod;}
       table tr td,table tr th{width:25%;padding-left:15px;height:35px;border-right:1px solid #e5e5e5;line-height:35px;}
          table tr td:last-child,table tr th:last-child,{border-right:0;}
           table tr td{line-height:30px;height:30px;}
	</style>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/modules/layer/default/layer.css">
    <script src="${ctxStatic}/sbShop/layui/lay/modules/layer.js"></script>
	<script>

		function hint() {
            layer.open({
                type: 2,
                title: "提现须知",
                shadeClose: true,
                shade: 0.3,
                offset: "20%",
                shadeClose : false,
                area: ['60%', '70%'],
                btn: ['关闭'],
                content: "${ctxweb}/shop/shopPmAmtLog/hint"
            });

        }
	</script>
</head>
<body>
<input type="hidden" value="${ctxweb}" id="ctxweb"/>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">资金提现</span>
	</div>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">门店结算</a></li>
		<li><a  href="${ctxweb}/shop/shopPmAmtLog/list">收支明细</a></li>
		<li><a  href="${ctxweb}/shop/shopPmAmtLog/applyToCashlist">提现记录</a></li>
	</ul>
	<div class="breadcrumb form-search">
		<div class="control-group" style="padding:0 30px;">
			<label class="control-label">门店名称:</label>
			<div class="controls">
				<label style="color: #009688;">${shopName}</label>
			</div>
		</div>
		<div class="control-group" style="padding:0 30px;">
            <label class="control-label">可提现金额:</label>
            <div class="controls">
				<label style="color: #009688;">${currentAmt}元

				</label>
				<a style="color: #F39C38;" href="${ctxweb}/shop/shopPmAmtLog/form" >申请提现</a>
            </div>
	</div>

		<div class="control-group" style="padding:0 30px;">
			<label class="control-label">已提现金额:</label>
			<div class="controls">
				<label style="color: #009688;">${cashWithdrawalAmt}元</label>
			</div>
		</div>
		<div class="control-group" style="padding:0 30px;">
			<label class="control-label">提现须知:</label>
			<a style="color: #F39C38;" href="#" onclick="hint()">【查看】</a>
		</div>

		<div class="control-group" style="height:auto;padding:0px 30px 50px 30px;">
			<table style="border:1px solid #e5e5e5;">
				<thead  style="border-bottom:1px solid #e5e5e5;">
				<tr>
					<th>总收入：${fns:getAmt(pmShopSettlement.incomeShopAmt+pmShopSettlement.incomeMiniAmt+pmShopSettlement.incomeOtherAmt)}元</th>
					<th>总退款：${fns:getAmt(pmShopSettlement.refundShopAmt+pmShopSettlement.refundMiniAmt+pmShopSettlement.refundOtherAmt)}元</th>
					<th>总成本：${fns:getAmt(pmShopSettlement.costShopAmt+pmShopSettlement.costMiniAmt+pmShopSettlement.costOtherAmt)}元</th>
					<th>总利润：${fns:getAmt(pmShopSettlement.incomeShopAmt+pmShopSettlement.incomeMiniAmt+pmShopSettlement.incomeOtherAmt-pmShopSettlement.costShopAmt-pmShopSettlement.costMiniAmt-pmShopSettlement.costOtherAmt-pmShopSettlement.refundShopAmt-pmShopSettlement.refundMiniAmt-pmShopSettlement.refundOtherAmt)}元</th>
				</tr>
				</thead>
				<tbody>
			<tr>
				    <td>收银端收入：${pmShopSettlement.incomeShopAmt}元</td>
				<td>收银端收入：${pmShopSettlement.refundShopAmt}元</td>
				<td>收银端收入：${pmShopSettlement.costShopAmt}元</td>
				<td>收银端收入：${fns:getAmt(pmShopSettlement.incomeShopAmt-pmShopSettlement.costShopAmt-pmShopSettlement.refundShopAmt)}元</td>


				</tr>
				<tr>
					<td>${fns:getProjectName()}小程序：${pmShopSettlement.incomeMiniAmt}元</td>
					 <td>${fns:getProjectName()}小程序：${pmShopSettlement.refundMiniAmt}元</td>
					<td>${fns:getProjectName()}小程序：${pmShopSettlement.costMiniAmt}元</td>
					<td>${fns:getProjectName()}小程序：${fns:getAmt(pmShopSettlement.incomeMiniAmt-pmShopSettlement.costMiniAmt-pmShopSettlement.refundMiniAmt)}元</td>

				</tr>
			    <tr>
					<td>美团等外卖平台：${pmShopSettlement.incomeOtherAmt}元</td>
					<td>美团等外卖平台：${pmShopSettlement.refundOtherAmt}元</td>
					<td>美团等外卖平台：${pmShopSettlement.costOtherAmt}元</td>
					<td>美团等外卖平台：${fns:getAmt(pmShopSettlement.incomeOtherAmt-pmShopSettlement.costOtherAmt-pmShopSettlement.refundOtherAmt)}元</td>
				 </tr>
			  </tbody>
			</table>
		</div>
        </div>
	</div>
</div>
</body>
</html>