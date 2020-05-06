<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
	<meta name="Keywords" content="${fns:getProjectName()},门店装修"/>
    <title>门店装修</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-fitment.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
   	<script src="${ctxStatic}/tii/tii.js"></script>
   	<script src="${ctxStatic}/sbShop/js/admin-fitment.js"></script>
    <script>
        function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmShopInfo/shopAdvertise");
			$("#searchForm").submit();
		    return false;
		}
    </script>
</head>
<body>
	<input class="ctxsys" id="ctxsys" name="ctxsys" type="hidden" value="${ctxsys}"/>
    <div class="fitment">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${shopid}">门店信息</a></li>
            <li><a href="${ctxsys}/PmShopInfo/form?id=${shopid}">企业信息</a></li>
            <li><a class="active" href="${ctxsys}/PmShopInfo/shopAdvertise?shopid=${shopid}">门店装修</a></li>
        </ul>
        <form id="searchForm" class="breadcrumb form-search">
	        <input id="shopid" name="shopid" type="hidden" value="${shopid}"/>
	        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="add-mu-div">
            <a class="add-mu" href="${ctxsys}/PmShopInfo/advertiselist?shopid=${shopid}">添加模块</a>
        </div>
        <div class="mu-div">
            <ul class="mu-top">
                <li>图片</li>
                <li>模块名称</li>
                <li>广告类型</li>
                <li>模块</li>
                <li>状态</li>
                <li>操作</li>
            </ul>
            <c:forEach items="${page.list}" var="advertise">
            <ul class="mu-list">
                <li>
                    <div class="mu-img">
                        <img src="${advertise.advertuseImg}" alt="">
                    </div>
                </li>
                <li>${advertise.advertiseTitle}</li>
                <li>
                	<c:choose>
                		<c:when test="${advertise.advertiseType==1}">类别</c:when>
                		<c:when test="${advertise.advertiseType==2}">商品</c:when>
                		<c:when test="${advertise.advertiseType==3}">链接(广告图片)</c:when>
                		<c:when test="${advertise.advertiseType==4}">商家</c:when>
                		<c:when test="${advertise.advertiseType==5}">文章</c:when>
                	</c:choose>
				</li>
                <li>${advertise.ebLayouttype.moduleTitle}</li>
                <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                <li>
                	<c:choose>
                		<c:when test="${advertise.status==0}"><a href="${ctxsys}/PmShopInfo/status?status=1&shopid=${shopid}&advertiseid=${advertise.id}">启用</a></c:when>
                		<c:when test="${advertise.status==1}"><a href="${ctxsys}/PmShopInfo/status?status=0&shopid=${shopid}&advertiseid=${advertise.id}">禁用</a></c:when>
                	</c:choose>
				</li>
				</shiro:hasPermission>
                <li>
                <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                    <a href="${ctxsys}/PmShopInfo/advertiselist?shopid=${shopid}&layouttypeId=${advertise.layouttypeId}&advertiseid=${advertise.id}">编辑</a>
                </shiro:hasPermission>
                    <a class="con-a" advertiseid="${advertise.id}" shopid="${shopid}" href="javascript:;">删除</a>
                </li>
            </ul>
            </c:forEach>
        </div>
        <div class="pagination">${page}</div>
        </form>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
                <span>确定要删除该数据吗？</span>
                <br>
                <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                <a class="con-yes" href="javascript:;">确定</a>
                </shiro:hasPermission>
                <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
</body>
</html>