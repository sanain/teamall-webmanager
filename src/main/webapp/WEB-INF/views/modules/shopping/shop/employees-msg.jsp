<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
    <meta name="Keywords" content="${fns:getProjectName()},门店装修"/>
    <title>员工列表</title>

    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-fitment.css">
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
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
            height: 30px;
            border-radius: 5px;

        }

        #btnSubmit{
            background-color: rgb(105,172,114);
        }
        /*body .form-search .ul-form li input{*/
        /*outline-color: invert ;*/
        /*outline-style: none ;*/
        /*outline-width: 0px ;*/
        /*border: none ;*/
        /*border-style: none ;*/
        /*text-shadow: none ;*/
        /*-webkit-appearance: none ;*/
        /*-webkit-user-select: text ;*/
        /*outline-color: transparent ;*/
        /*box-shadow: none;*/
        /*}*/
        .ul-form{
            padding-top: 10px;
            margin-bottom: 60px;
        }
        .nav-ul li a.active {
            color: #69AC72;

            border-bottom: 2px solid #69AC72;
        }
        .nav-ul li a {
            display: inline-block;
            color: #666666;
            line-height: 40px;
            height: 40px;
        }
        .nav-ul li {
            float: left;
            padding-right: 4%;
        }
        .nav-ul {
            overflow: hidden;
            height: 42px;
            line-height: 40px;
            background: #ffffff;
            padding-left: 33px;
            margin-bottom: 20px;
        }
        .c-context {
            padding: 10px;
            background: #E3E4E6;
        }

        .ul-form input {
            height: 30px;
            border-radius: 4px;
            outline: none;
            width: 120px;
            border: 1px solid #CCCCCC;
            padding: 0 10px;
            display: inline-block;
            margin-bottom: 0;
            vertical-align: middle;
        }
        }

    </style>

    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-fitment.js"></script>
    <script>
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/PmShopInfo/employees");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<input class="ctxsys" id="ctxsys" name="ctxsys" type="hidden" value="${ctxsys}"/>
<div class="fitment">
    <ul class="nav-ul">
        <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopUser.shopId}">门店信息</a></li>
        <li><a class="active"  href="${ctxsys}/PmShopInfo/employees?id=${pmShopUser.shopId}">门店员工</a></li>
        <li><a href="${ctxsys}/PmShopInfo/device?id=${pmShopUser.shopId}">登录设备信息</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopUser.shopId}">门店结算</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopUser.shopId}">收支明细</a></li>
    </ul>
    <form id="searchForm" class="breadcrumb form-search" method="post">
        <input id="shopid" name="id" type="hidden" value="${pmShopUser.shopId}"/>
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>

        <ul class="ul-form">

            <li><label>工号:</label><input value="${pmShopUser.jobNumber}" name="jobNumber" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
            <li><label>员工名字:</label><input value="${pmShopUser.username}" name="username" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
            <li><label>人员类型:</label>
                <select name="type" class="input-medium">
                    <option value="" >全部</option>
                    <option value="1" <c:if test="${pmShopUser.type == 1}">selected</c:if>>收银人员</option>
                    <option value="2" <c:if test="${pmShopUser.type == 2}">selected</c:if>>配送人员</option>
                </select>
            </li>

            <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
        </ul>

        <%--<div class="add-mu-div">--%>
        <%--&lt;%&ndash;<a class="add-mu" href="${ctxsys}/PmShopInfo/advertiselist?shopid=${shopid}">添加模块</a>&ndash;%&gt;--%>
        <%--</div>--%>
        <div class="mu-div" style="margin-top: 10px;">
            <ul class="mu-top">
                <li>工号</li>
                <li>员工名字</li>
                <li>员工类型</li>
                <li>创建时间</li>
                <li>状态</li>
            </ul>
            <c:forEach items="${page.list}" var="shopUser">
                <ul class="mu-list">
                    <li>${shopUser.jobNumber}</li>
                    <li>${shopUser.username}</li>
                    <li>${shopUser.type == 1 ? '收银人员':'配送人员'}</li>
                    <li>${shopUser.createTime}</li>
                    <li>
                        <c:if test="${shopUser.status == 0}">禁用</c:if>
                        <c:if test="${shopUser.status == 1}">启用</c:if>
                    </li>
                        <%--<li>--%>
                        <%--<div class="mu-img">--%>
                        <%--<img src="${advertise.advertuseImg}" alt="">--%>
                        <%--</div>--%>
                        <%--</li>--%>
                        <%--<li>${advertise.advertiseTitle}</li>--%>
                        <%--<li>--%>
                        <%--<c:choose>--%>
                        <%--<c:when test="${advertise.advertiseType==1}">类别</c:when>--%>
                        <%--<c:when test="${advertise.advertiseType==2}">商品</c:when>--%>
                        <%--<c:when test="${advertise.advertiseType==3}">链接(广告图片)</c:when>--%>
                        <%--<c:when test="${advertise.advertiseType==4}">商家</c:when>--%>
                        <%--<c:when test="${advertise.advertiseType==5}">文章</c:when>--%>
                        <%--</c:choose>--%>
                        <%--</li>--%>
                        <%--<li>${advertise.ebLayouttype.moduleTitle}</li>--%>
                        <%--<shiro:hasPermission name="merchandise:PmShopInfo:edit">--%>
                        <%--<li>--%>
                        <%--<c:choose>--%>
                        <%--<c:when test="${advertise.status==0}"><a href="${ctxsys}/PmShopInfo/status?status=1&shopid=${shopid}&advertiseid=${advertise.id}">启用</a></c:when>--%>
                        <%--<c:when test="${advertise.status==1}"><a href="${ctxsys}/PmShopInfo/status?status=0&shopid=${shopid}&advertiseid=${advertise.id}">禁用</a></c:when>--%>
                        <%--</c:choose>--%>
                        <%--</li>--%>
                        <%--</shiro:hasPermission>--%>
                        <%--<li>--%>
                        <%--<shiro:hasPermission name="merchandise:PmShopInfo:edit">--%>
                        <%--<a href="${ctxsys}/PmShopInfo/advertiselist?shopid=${shopid}&layouttypeId=${advertise.layouttypeId}&advertiseid=${advertise.id}">编辑</a>--%>
                        <%--</shiro:hasPermission>--%>
                        <%--<a class="con-a" advertiseid="${advertise.id}" shopid="${shopid}" href="javascript:;">删除</a>--%>
                        <%--</li>--%>
                </ul>
            </c:forEach>
        </div>
        <div class="pagination">${page}</div>
    </form>
</div>
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
</body>
</html>