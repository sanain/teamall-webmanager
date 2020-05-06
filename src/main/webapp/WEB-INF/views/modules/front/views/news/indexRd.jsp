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
<body >	
		<div id="content"> 
					<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   >  </a> <a href="${ctx}/news/index${urlSuffix}">健康资讯   > </a> <a> ${newstype.newstypename}</a>
								</div>
						</div>
			<div class="yil">
					<div class="block_name mtt"> 
							<span class="animate-element left_to_right"></span>
							<p class="animate-element right_to_left">${newstype.newstypename}</p>
							<div class="brd"></div>
					</div>
					<c:forEach var="newstype" items="${listNewsType}" begin="0" step="2" varStatus="status">
					<div class="i7" > 
							<div class="center">
								<div class="l"> 
								    <p class="i7p">${listNewsType[status.index].newstypename}<span></span> <a class="more" href="./${newstype.newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
										<c:set var="detailLists" value="${fnf:getnewsList(listNewsType[status.index].newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="../${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
												<div class="l">
													<c:if test="${not empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${newsdtail.newsdetailspicture}">
													</c:if>	
													<c:if test="${empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${ctxStaticFront}/images/zixunimg.jpg">
														</c:if>
												</div>
												<div class="r">
													<p><b>${newsdtail.newsdetailtitle}</b> 	</p>
													<span>${newsdtail.newsdetailabstract}</span>
												</div>
												</a>
											</li>
											</c:forEach>
										</ul>
								</div>
								<div class="r"> 
								<c:if test="${status.index+2 <= fn:length(listNewsType)}">
										<p class="i7p">${listNewsType[status.index+1].newstypename} <span></span><a class="more" href="./${listNewsType[status.index+1].newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
										<c:set var="detailLists" value="${fnf:getnewsList(listNewsType[status.index+1].newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="../${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
												<div class="l">
													<c:if test="${not empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${newsdtail.newsdetailspicture}">
													</c:if>	
													<c:if test="${empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${ctxStaticFront}/images/zixunimg.jpg">
														</c:if>
												</div>
												<div class="r">
													<p><b>${newsdtail.newsdetailtitle}</b> 	</p>
													<span>${newsdtail.newsdetailabstract}</span>
												</div>
												</a>
											</li>
											</c:forEach>
										</ul>
								</c:if>
								</div>
								
							</div>
                             
				     	</div>
	                    </c:forEach>
		
				</div>
		</div>
</body>
</html>
