<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
    <meta name="Keywords" content="${fns:getProjectName()},门店装修"/>
    <title>登录设备信息</title>

    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-fitment.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <link rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css"/>
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css" rel="stylesheet">
    <link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" rel="stylesheet">
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">--%>
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">--%>
    <style>
        .ul-form li{
            float:left;
        }
        body .form-search .ul-form li label{
            width:90px;
            text-align: right;
            padding-right:8px ;
            font-weight: normal;
        }


        body .form-search .ul-form li input,select,option{
            height: 35px;
            border-radius: 5px;


        }
        .nav-ul{
            margin-left:0px;
        }
        .nav-ul li a{
            height: 38px;
            line-height: 40px;
        }
        .ul-form{
            padding-top: 10px;
            margin-bottom: 60px;
        }

        #btnSubmit{
            background-color: rgb(105,172,114);
        }
        .nav-tabs-dv{
            background-color: white;
            padding-top: 1px;
            height: 42px;
        }
        .mu-div{
            margin-top: 20px;
            width: 100%;
            padding: 0px;
        }
        .mu-top,.mu-list{
            margin: 0px;
        }
        .mu-list{
            height: 40px;
            line-height: 40px;
        }
        .mu-div li  {
            height: 40px;
            line-height: 40px;

        }
        .nav>li>a {
            position: relative;
            display: block;
            padding: 10px 15px;
            width: 56px;
            text-align: center;
        }
    </style>

    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-fitment.js"></script>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    <script src="${ctxStatic}/common/jqsite.js"></script>
    <script>
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/PmShopInfo/device");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<input class="ctxsys" id="ctxsys" name="ctxsys" type="hidden" value="${ctxsys}"/>
<div class="fitment">
    <ul class="nav-ul">
        <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopDevice.shopId}">门店信息</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/employees?id=${pmShopDevice.shopId}">门店员工</a></li>
        <li><a class="active"  href="${ctxsys}/PmShopInfo/device?id=${pmShopDevice.shopId}">登录设备信息</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopDevice.shopId}">门店结算</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopDevice.shopId}">收支明细</a></li>
    </ul>
    <div class="nav-tabs-dv" id="nav-tabs-dv" >
        <ul class="nav nav-tabs" style="margin: 0px; height: 42px">
            <shiro:hasPermission name="merchandise:PmShopInfo:view">
                <li class="active" >
                    <c:if test="${stule!='99'}"><a  href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">设备列表</a></c:if><c:if test="${stule=='99'}"><a>设备列表</a>
                </c:if></li></shiro:hasPermission>
            <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                <li>
                    <c:if test="${stule!='99'}">
                        <a  href="${ctxsys}/PmShopInfo/deviceForm?id=${pmShopInfo.id}&flag=add" >绑定设备</a>
                    </c:if>
                    <c:if test="${stule=='99'}">
                        <a >绑定设备</a>
                    </c:if>
                </li>
            </shiro:hasPermission>
        </ul>
    </div>
    <form id="searchForm" class="breadcrumb form-search" method="post">
        <input id="shopid" name="id" type="hidden" value="${pmShopInfo.id}"/>
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>

        <ul class="ul-form">
            <%--<li><label>公司名/店名/商户码:</label><form:input path="shopCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>--%>
            <li><label>设备编号:</label><input value="${pmShopDevice.deviceCode}" name="deviceCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
            <li><label>设备名称:</label><input value="${pmShopDevice.deviceName}" name="deviceName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>

            <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
        </ul>

        <div class="mu-div">
            <ul class="mu-top">
                <%--<li>ID</li>--%>
                <li style="width: 25%">设备编号</li>
                <li style="width: 25%">设备名称</li>
                <li style="width: 25%">创建时间</li>
                <li style="width: 25%">操作</li>
            </ul>
            <c:forEach items="${page.list}" var="pmShopDevice">
                <ul class="mu-list">
                    <%--<li>${pmShopDevice.id}</li>--%>
                    <li style="width: 25%">${pmShopDevice.deviceCode}</li>
                    <li style="width: 25%">${pmShopDevice.deviceName}</li>
                    <li style="width: 25%">${pmShopDevice.createTime}</li>
                        <shiro:hasPermission name="merchandise:certificatelist:edit">
                            <li style="width: 25%"><a href="${ctxsys}/PmShopInfo/deviceForm?id=${pmShopDevice.shopId}&deviceId=${pmShopDevice.id}">修改</a>
                            <a href="${ctxsys}/PmShopInfo/deleteDevice?deviceId=${pmShopDevice.id}&id=${pmShopDevice.shopId}" onclick="return confirmx('确定要删除信息吗？', this.href)">解除绑定</a></li>
                        </shiro:hasPermission>
                </ul>
            </c:forEach>
        </div>
        <div class="pagination">${page}</div>
    </form>
<%--</div>onclick="return confirmx('确定要删除信息吗？', this.href)"--%>
<%--<div class="consent">--%>
<%--<div class="consent-box">--%>
<%--<p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>--%>
<%--<div class="consent-div">--%>
<%--<span>确定要删除该数据吗？</span>--%>
<%--<br>--%>
<%--<shiro:hasPermission name="merchandise:PmShopInfo:edit">--%>
<%--<a class="con-yes" href="javascript:;">确定</a>--%>
<%--</shiro:hasPermission>--%>
<%--<a class="consent-del" href="javascript:;">取消</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<div class="tii">
    <span class="tii-img"></span>
    <span class="message" data-tid="${message}">${message}</span>
</div>

    <script type="text/javascript">
        $(function(){
            if('${prompt}' != ''){
                alert('${prompt}')
            }
        })
    </script>
</body>
</html>