<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},公司信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},公司信息"/>
    <title>公司信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-company-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-company-msg.js"></script>

    <style type="text/css">

    </style>
</head>
<body>
<form id="inputForm" action="${ctxsys}/PmShopInfo/save" method="post" class="form-horizontal">
    <input type="hidden" id="id" name="id" value="${pmShopInfo.id}"/>
    <div class="company">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfo.id}">门店信息</a></li>
            <li><a class="active" href="${ctxsys}/PmShopInfo/form?id=${pmShopInfo.id}">企业信息</a></li>
            <li><a href="${ctxsys}/PmShopInfo/employees?id=${pmShopInfo.id}">门店人员</a></li>
            <li><a href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">登录设施信息</a></li>
            <%--<li><a href="${ctxsys}/PmShopInfo/shopAdvertise?shopid=${pmShopInfo.id}"">门店装修</a></li>--%>
        </ul>
        <div class="jb-msg">
            <p>基本信息</p>
            <ul>
                <li>账号：</li>
                <li>${fns:replaceMobileShopShoppingFlag(mobile)}</li>
            </ul>
        </div>
        <div class="gs-msg">
            <p>公司信息：</p>
            <ul>
                <li>公司名：</li>
                <li>${pmShopInfo.companyName}</li>
            </ul>
            <ul>
                <li>详细地址：</li>
                <li>${pmShopInfo.districtName}${pmShopInfo.shopLlAddress}${pmShopInfo.contactAddress}</li>
            </ul>
            <ul>
                <li><b>*</b>法人代表：</li>
                <li><input id="legalPerson" name="legalPerson" value="${pmShopInfo.legalPerson}" class="input" type="text"></li>
            </ul>
            <ul>
                <li><b>*</b>注册资金：</li>
                <li><input id="capital" name="capital" value="${pmShopInfo.capital}" class="input" type="text" maxlength="16" onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false">万元</li>
            </ul>
            <ul class="gs-msg-you">
                <li><b>*</b>营业执照有效期：</li>
                <li>
                    <input name="businessStartTime" value="<fmt:formatDate value="${pmShopInfo.businessStartTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_s" readonly="readonly" class="businessStartTime" type="text">
                    <span>到</span>
                    <input name="businessEndTime" value="<fmt:formatDate value="${pmShopInfo.businessEndTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_e" readonly="readonly" class="businessEndTime" type="text">
                </li>
            </ul>
            <ul>
                <li><b>*</b>营业执照经营范围：</li>
                <li><textarea id="licenseAppScope" name="licenseAppScope" class="input">${pmShopInfo.licenseAppScope}</textarea></li>
            </ul>
            <ul>
                <li>公司官网地址：</li>
                <li><input id="officialUrl" name="officialUrl" value="${pmShopInfo.officialUrl}" type="text"></li>
            </ul>
            <ul>
                <li>电话号码：</li>
                <li><input id="customerPhone" name="customerPhone" value="${pmShopInfo.customerPhone}" type="text" maxlength="11" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"></li>
            </ul>
            <ul>
                <li>传真号码：</li>
                <li><input id="fax" name="fax" value="${pmShopInfo.fax}" type="text" maxlength="12" onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false"></li>
            </ul>
        </div>

        <div class="lx-mag">
            <p>联系信息</p>
            <ul>
                <li><b>*</b>联系人：</li>
                <li><input id="contactName" name="contactName" value="${pmShopInfo.contactName}" class="input" type="text"></li>
            </ul>
            <ul>
                <li>联系手机：</li>
                <li>${pmShopInfo.mobilePhone}</li>
            </ul>
            <ul>
                <li><b>*</b>电子邮箱：</li>
                <li><input id="email" name="email" value="${pmShopInfo.email}" class="input" type="text"></li>
            </ul>
            <ul>
                <li><b>*</b>短信通知手机：</li>
                <li><input id="msgPhone" name="msgPhone" value="${pmShopInfo.msgPhone}" class="input" type="text"> *：发送多个号码以逗号隔开，为空时无法收到订单短信通知</li>
            </ul>
            <ul>
                <li> </li>
                <li><a class="sub" href="javascript:;">修改</a></li>
            </ul>
        </div>
    </div>
</form>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
</body>
</html>