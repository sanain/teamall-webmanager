<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>运费模板</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/freight-template.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/pmShopFreightTem/pmShopFreightTemList");
			$("#searchForm").submit();
	    	return false;
	    }
	    function selclick(tepId){
	    	   var stule="${stule}";
	    	    $.ajax({
					type: "POST",
					url: "${ctxweb}/shop/product/showTyepshop",
					data: {ids:stule,typeId:tepId},
					success: function(data){
					  //location.href="${ctxweb}/shop/product/eateSbscType";
					}
				 });
				window.opener=null;
				window.open('','_self');
				window.close();
	    }
	</script>
	<style type="text/css">
	.hide-btn{text-align:right;padding-top:10px;clear:both;}
	.hide-btn a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius:5px;}
	</style>
</head>
<body>
    <div class="templatae">
        <p><a class="temp1" href="${ctxweb}/shop/pmShopFreightTem/form" target="tager">新增运费模板</a></p>
        <div class="templatae-box">
        <form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
          <c:forEach items="${page.list}" var="list">
            <div class="templatae-list">
                <p>
	                <b>${list.templateName}</b>
	                <c:if test="${list.isFullFree==1}"><i>(满${list.fullNum}件包邮)</i></c:if>
	                <a class="templatae-lsit-del" href="${ctxweb}/shop/pmShopFreightTem/delete?id=${list.id}" target="tager">删除</a>
	                <a href="${ctxweb}/shop/pmShopFreightTem/form?id=${list.id}" target="tager">修改</a>
	                <a class="templatae-lsit-copy" href="${ctxweb}/shop/pmShopFreightTem/copy?id=${list.id}&templateName=${list.templateName}" target="tager">复制模板</a>
	                <span>
	                	<c:if test="${list.isPackageMail==1}">待付款【买家承担运费】最后编辑：<fmt:formatDate value="${list.modifyTime}" type="both"/></c:if>
	                	<c:if test="${list.isPackageMail==2}">待付款【卖家承担运费】最后编辑：<fmt:formatDate value="${list.modifyTime}" type="both"/></c:if>
	                </span>
                </p>
                <ul>
                    <li>运送方式</li>
                    <li>运送到</li>
                    <li>首件（个）</li>
                    <li>运费（元）</li>
                    <li>续件（个）</li>
                    <li>运费（元）</li>
                </ul>
                <c:forEach items="${list.pmShopShippingMethods}" var="list1">
	                <ul>
	                	<li>
	               			<c:choose>
        						<c:when test="${list1.shippingMethod==1}" >快递</c:when>
        						<%-- <c:when test="${list1.shippingMethod==2}" >EMS</c:when>
        						<c:when test="${list1.shippingMethod==3}" >平邮</c:when> --%>
        					</c:choose>
        				</li>
        				<c:choose>
        					<c:when test="${!empty list1.distrctName}">
        						<li title="${list1.distrctName}">${fns:abbr(list1.distrctName,60)}</li>
        					</c:when>
        					<c:otherwise>
        						<li title="全国(部分偏远地区除外...)">全国(部分偏远地区除外...)</li>
        					</c:otherwise>
        				</c:choose>
	                    <li>${list1.firstArticleKg}</li>
	                    <li>¥<span>${list1.firstCharge}</span></li>
	                    <li>${list1.continueArticleKg}</li>
	                    <li>¥<span>${list1.continueCharge}</span></li>
	                </ul>
	            </c:forEach>
	            <c:if test="${not empty stule}">
	                <div class="hide-btn">
	                	<a href="javascript:;" onclick="selclick(${list.id})">应用</a>
	                </div>
	             </c:if>
            </div>
          </c:forEach>
        </form>
		<div class="pagination">${page}</div>
	</div>
</body>
</html>