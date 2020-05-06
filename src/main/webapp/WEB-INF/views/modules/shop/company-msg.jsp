<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},公司信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},公司信息"/>
    <title>公司信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/company-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/company-msg.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>

    <style type="text/css">
        .sub{
            background: #393D49;
            border: #393D49;
        }

        .sub:hover{
            background: #393D49;
            color: rgb(120,120,120);
        }
        .form-horizontal{background:#fff;}
    </style>
</head>
<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">基本信息</span>
	</div>
<div style="background:#fff;margin:0 30px;">
<form class="form-horizontal" action="${ctxweb}/shop/shopInfo/companyMsgFormEdit" method="post" name="form2">
    <div class="company">
        <div class="jb-msg">
            <p><b style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>基本信息</p>
            <ul>
                <li>账号：</li>
                <li>${fns:replaceMobileShopShoppingFlag(ebUser.mobile)}</li>
            </ul>
        </div>
        <div class="gs-msg">
            <p>	<b style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>公司信息</p>
            <ul>
                <li>公司名：</li>
                <li>${shopInfo.companyName}</li>
            </ul>
            <ul>
                <li style="height:120px;">营业执照：</li>
                <li  style="height:120px;"><img src="${shopInfo.businessCodeLogo}" style="margin-top:10px;width:100px;height:100px;;"></li>
            </ul>
            <ul>
                <li>注册地址：</li>
                <li>${shopInfo.districtName}${shopInfo.contactAddress}</li>
            </ul>
            <ul>
                <li><b>*</b>法人代表：</li>
                <li><input id="legalPerson" name="legalPerson" value="${shopInfo.legalPerson}" type="text"></li>
            </ul>
            <ul>
                <li><b>*</b>注册资金：</li>
                <li><input id="capital" type="text" name="capital" value="${shopInfo.capital}" class="input" maxlength="16" onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false">万元</li>
            </ul>
            <ul class="gs-msg-you">
                <li><b>*</b>营业执照有效期：</li>
                <li>
                    <input class="businessStartTime" name="businessStartTime" value="<fmt:formatDate value="${shopInfo.businessStartTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_s" readonly="readonly" type="text">
                    <span>到</span>
                    <input class="businessEndTime" name="businessEndTime" value="<fmt:formatDate value="${shopInfo.businessEndTime}" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" id="LAY_demorange_e" readonly="readonly" type="text">
                </li>
            </ul>
            <ul>
                <li  style="height:117px;"><b>*</b>营业执照经营范围：</li>
                <li  style="height:117px;"><textarea style="margin-top:10px;" id="licenseAppScope" name="licenseAppScope" class="input" type="text">${shopInfo.licenseAppScope}</textarea></li>
            </ul>
            <ul>
                <li>公司官网地址：</li>
                <li><input id="officialUrl" name="officialUrl" value="${shopInfo.officialUrl}" type="text"></li>
            </ul>
            <ul>
                <li>客服电话：</li>
                <li><input id="customerPhone" name="customerPhone" value="${shopInfo.customerPhone}" maxlength="11" type="text"></li>
            </ul>
            <ul>
                <li>传真号码：</li>
                <li><input id="fax" name="fax" value="${shopInfo.fax}" type="text"></li>
            </ul>
        </div>
        <div class="lx-mag">
            <p><b style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>联系信息</p>
            <ul>
                <li><b>*</b>联系人：</li>
                <li><input id="contactName" name="contactName" value="${shopInfo.contactName}" class="input" type="text"></li>
            </ul>
            <ul>
                <li>联系手机：</li>
                <li>${fns:replaceMobileShopShoppingFlag(shopInfo.mobilePhone)}</li>
            </ul>
            <ul>
                <li style="height:40px;"><b>*</b>电子邮箱：</li>
                <li><input id="email" name="email" value="${shopInfo.email}" class="input" type="text"></li>
            </ul>
        </div>
        <div class="btts"  style="padding-bottom:30px;"><a   style="width:90px;" class="sub btn btn-primary" href="javascript:;">修改</a></div>
    </div>
</form>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
</div>
</body>
</html>