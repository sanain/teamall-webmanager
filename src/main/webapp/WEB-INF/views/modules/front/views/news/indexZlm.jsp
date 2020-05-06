<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
<body >	
		<div id="content"> 
					<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   ></a>   <a href="${ctx}/news/index${urlSuffix}">健康资讯   ></a>   <a>${newstype.newstypename}</a>

								</div>
								

						</div>
			<div class="yil">
					<div class="block_name mtt"> 
							
							<p class="animate-element right_to_left">${newstype.newstypename}</p>
							<div class="brd"></div>
					</div>
					<div class="i7 zlm" > 
							<div class="center">
										<ul>
										<c:forEach items="${listNewsDetails.list}" var="newsDetail">
											<li class="">
												<a href="../${newsDetail.newsdetailid}${urlSuffix}" class="opacity zc">
												<div class="l">
													<c:if test="${not empty newsDetail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${newsDetail.newsdetailspicture}">
													</c:if>	
													<c:if test="${empty newsDetail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${ctxStaticFront}/images/zixunimg.jpg">
														</c:if>
												</div>
												<div class="r">
													<p><b>${newsDetail.newsdetailtitle}</b>&nbsp;&nbsp;<fmt:formatDate value="${newsDetail.pubtime}" pattern="yyyy/MM/dd HH:mm:ss"/> </p>
													<span>${newsDetail.newsdetailabstract}</span>
												</div>
												</a>
											</li>
										 </c:forEach>
										</ul>
							</div>
					</div>	

				</div>
				<div class="page pgb">${listNewsDetails}</div>
		</div>
		
			<form id="searchForm" action="${ctx}/news/more/${typeid}.html" name="searchForm" class="form-inline">
        			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input  name="typeid" type="hidden" value="${typeid}"/>
					
					
		 		</form>
<script type="text/javascript">



function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}
</script>
</body>
</html>

