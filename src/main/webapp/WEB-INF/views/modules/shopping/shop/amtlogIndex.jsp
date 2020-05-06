<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},余额明细"/>
	<meta name="Keywords" content="${fns:getProjectName()},余额明细"/>
    <title>余额明细</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfo.id}">门店信息</a></li>
          <li><a  href="${ctxsys}/PmShopInfo/employees?id=${pmShopInfo.id}">门店员工</a></li>
          <li><a href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">登录设备信息</a></li>
          <li><a  class="active"  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopInfo.id}">门店结算</a></li>
          <li><a href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopInfo.id}">收支明细</a></li>
      </ul>
        <div class="balance">
            <div class="balance-list" style="    margin-top: 20px;">
                <table class="table table-striped table-bordered table-hover dataTables-example">
                    <thead>
                    <tr>
                        <th>可提现金额:${currentAmt}元 &nbsp;&nbsp;&nbsp;正在提现金额:${waitingCashWithdrawalAmt}元&nbsp;&nbsp;&nbsp;已提现金额:${cashWithdrawalAmt}元</th>
                    </tr>
                    <tr>
                        <th style="color:rgb(0,135,241)">总收入：${fns:getAmt(pmShopSettlement.incomeShopAmt+pmShopSettlement.incomeMiniAmt+pmShopSettlement.incomeOtherAmt)}元</th>
                        <th style="color:#e2041a">总退款：${fns:getAmt(pmShopSettlement.refundShopAmt+pmShopSettlement.refundMiniAmt+pmShopSettlement.refundOtherAmt)}元</th>
                        <th style="color:#ff9000">总成本：${fns:getAmt(pmShopSettlement.costShopAmt+pmShopSettlement.costMiniAmt+pmShopSettlement.costOtherAmt)}元</th>
                        <th style="color:#3aad4a">总利润：${fns:getAmt((pmShopSettlement.incomeShopAmt+pmShopSettlement.incomeMiniAmt+pmShopSettlement.incomeOtherAmt)-(pmShopSettlement.costShopAmt+pmShopSettlement.costMiniAmt+pmShopSettlement.costOtherAmt)-(pmShopSettlement.refundShopAmt+pmShopSettlement.refundMiniAmt+pmShopSettlement.refundOtherAmt))}元</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th style="color:rgb(0,135,241)">
                            收银端收入：${pmShopSettlement.incomeShopAmt}元<br/>
                            御可小程序：${pmShopSettlement.incomeMiniAmt}元<br/>
                            美团等外卖平台：${pmShopSettlement.incomeOtherAmt}元
                        </th>
                        <th style="color:#e2041a">
                            收银端收入：${pmShopSettlement.refundShopAmt}元<br/>
                            御可小程序：${pmShopSettlement.refundMiniAmt}元<br/>
                            美团等外卖平台：${pmShopSettlement.refundOtherAmt}元
                        </th>
                        <th style="color:#ff9000">
                            收银端收入：${pmShopSettlement.costShopAmt}元<br/>
                            御可小程序：${pmShopSettlement.costMiniAmt}元<br/>
                            美团等外卖平台：${pmShopSettlement.costOtherAmt}元
                        </th>
                        <th  style="color:#3aad4a">
                            收银端收入：${fns:getAmt(pmShopSettlement.incomeShopAmt-pmShopSettlement.costShopAmt-pmShopSettlement.refundShopAmt)}元<br/>
                            御可小程序：${fns:getAmt(pmShopSettlement.incomeMiniAmt-pmShopSettlement.costMiniAmt-pmShopSettlement.refundMiniAmt)}元<br/>
                            美团等外卖平台：${fns:getAmt(pmShopSettlement.incomeOtherAmt-pmShopSettlement.costOtherAmt-pmShopSettlement.refundOtherAmt)}元
                        </th>

                    </tr>

                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</body>

</html>