<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
	<meta name="Keywords" content="${fns:getProjectName()},门店装修"/>
    <title>门店装修</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/fitment.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/fitment.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
	    function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/ShopAdvertise/list");
			$("#searchForm").submit();
		    return false;
		}
    </script>
</head>
<body>
	<input class="ctxweb" id="ctxweb" name="ctxweb" type="hidden" value="${ctxweb}"/>
    <div class="fitment">
        <p>门店装修</p>
        <div class="fitment-sel">
		<form class="form-horizontal" action="${ctxweb}/shop/ShopAdvertise/list" method="post" id="searchForm" name="form2">
	    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
            <span>模块名称：</span><input id="layouttypeName" name="layouttypeName" value="${layouttypeName}" type="text">
            <span>模块类型：</span>
            <select name="advertiseType" id="advertiseType">
                <option value="">全部</option>
                <option ${advertiseType=='3'?'selected':''} value="3">广告图片</option>
                <option ${advertiseType=='2'?'selected':''} value="2">商品</option>
            </select>
            <span>模块：</span>
            <select name="layouttypeId" id="layouttypeId">
                <option value="">全部</option>
                <c:forEach items="${layouttypes}" var="layouttype">
	                <option value="${layouttype.id}" ${layouttype.id==layouttypeId?'selected':''}>${layouttype.moduleTitle}</option>
                </c:forEach>
            </select>
            <a href="javascript:;" onclick="page()">搜索</a>
   		</form>
        </div>
        <div>
            <a class="add-mu" href="${ctxweb}/shop/ShopAdvertise/edit">添加模块</a>
        </div>
        <div class="mu-div">
            <ul class="mu-top">
                <li>模块名称</li>
                <li>广告类型</li>
                <li>模块</li>
                <li>状态</li>
                <li>操作</li>
            </ul>
            <c:forEach items="${page.list}" var="advertise">
            <ul class="mu-list">
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
                <li>
                	<c:choose>
                		<c:when test="${advertise.status==0}"><a href="${ctxweb}/shop/ShopAdvertise/status?status=1&advertiseid=${advertise.id}">启用</a></c:when>
                		<c:when test="${advertise.status==1}"><a href="${ctxweb}/shop/ShopAdvertise/status?status=0&advertiseid=${advertise.id}">禁用</a></c:when>
                	</c:choose>
                </li>
                <li>
                    <a href="${ctxweb}/shop/ShopAdvertise/edit?layouttypeId=${advertise.layouttypeId}&advertiseid=${advertise.id}">编辑</a>
                    <a class="con-a" advertiseid="${advertise.id}" href="javascript:;">删除</a>
                </li>
            </ul>
            </c:forEach>
        </div>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
                <span>确定要删除该数据吗？</span>
                <br>
                <a class="con-yes" href="javascript:;">确定</a>
                <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
  <div class="pagination">${page}</div>
</body>
</html>