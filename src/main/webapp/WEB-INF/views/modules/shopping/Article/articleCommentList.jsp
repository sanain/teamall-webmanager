<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/discuss.css">
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ebArticle/commentlist?articleTypeId="+${articleTypeId}+"&articleId="+${articleId});
			$("#searchForm").submit();
	    	return false;
	    }
		/* $(function(){
			for(i=0;i<$('.history-list').length;i++){
				if($($('.history-list')[i]).find('.right-top').length==1){
					$($('.history-list')[i]).find('.right-top').css('margin-left','50px')
				}
			}
		}) */
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/ebArticle/list?articleTypeId=${articleTypeId}">文章列表</a></li>
		<li class="active"><a href="${ctxsys}/ebArticle/commentlist?articleTypeId=${articleTypeId}&articleId=${articleId}">文章评论列表</a></li>
	</ul>
	<form id="searchForm" modelAttribute="" action="" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		 <ul class="ul-form">
			 <li><label>评论状态:</label>
		       <select id="discussStatus" name="discussStatus" class="input-medium">
		         <option value="">全部</option>
		         <option ${discussStatus=='0'?'selected':''} value="0">显示</option>
		         <option ${discussStatus=='1'?'selected':''} value="1">隐藏</option>
		         <option ${discussStatus=='2'?'selected':''} value="2">删除</option>
		       </select>
		    </li>
		    <li><label>审核状态:</label>
		       <select id="examineStatus" name="examineStatus" class="input-medium">
		         <option value="">全部</option>
		         <option ${examineStatus=='1'?'selected':''} value="1">待审核</option>
		         <option ${examineStatus=='2'?'selected':''} value="2">审核通过</option>
		         <option ${examineStatus=='3'?'selected':''} value="3">审核失败</option>
		       </select>
		    </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form>
	<tags:message content="${message}"/>
	<div class="history">
          <div class="history-box">
            <c:forEach items="${page.list}" var="discusses" varStatus="status">
                <div class="history-list">
                    <div class="list-top-two">
	                    <div class="list-top">
		                    <c:choose>
		                    	<c:when test="${empty discusses.discussPortrait}">
			                    	<p><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></p>
			                        <span>${discusses.userName}</span>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<p><img src="${discusses.discussPortrait}" alt=""></p>
		                        	<span>${discusses.userName}</span>
		                    	</c:otherwise>
		                    </c:choose>
	                        <span><fmt:formatDate value="${discusses.discussAddtime}" type="both"/></span>
	                    </div>
	                    <ul>
	                        <li>${discusses.discussContent}</li>
	                    </ul>
                    </div>
                    <c:if test="${!empty discusses.ebDiscuss}">
                    	<div class="right-top">
		                    <div class="list-top">
			                    <c:choose>
			                    	<c:when test="${empty discusses.ebDiscuss.discussPortrait}">
				                    	<p><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></p>
				                        <span>${discusses.ebDiscuss.userName}</span>
			                    	</c:when>
			                    	<c:otherwise>
			                    		<p><img src="${discusses.ebDiscuss.discussPortrait}" alt=""></p>
			                        	<span>${discusses.ebDiscuss.userName}</span>
			                    	</c:otherwise>
			                    </c:choose>
		                        <span><fmt:formatDate value="${discusses.ebDiscuss.discussAddtime}" type="both"/></span>
	                    	</div>
	                        <ul>
		                        <li>${discusses.ebDiscuss.discussContent}</li>
	                    	</ul>
                    	</div>
                    	<br>
                    </c:if>
                </div>
			</c:forEach>
          </div>
        </div>
	<div class="pagination">${page}</div>
</body>
</html>