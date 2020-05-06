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

<body>
<div id="content"> 
					<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页    >  </a>
										    <a href="${ctx}/news/index${urlSuffix}">健康资讯</a>
								</div>
						</div>
			<div class="yil">
					<div class="fullSlide">
						<div class="bd">
						    <ul>
						    
						      	<c:set var="advertiselists" value="${fnf:getAdvertisePictures('informationbanner')}"/>
								<c:forEach items="${advertiselists}" var="advertise" varStatus="newstatus">
								 <li _src="url(${ctx}${advertise.advertisesrc})" style="background:#fff center 0 no-repeat;"></li>
						     <%--    <li _src="url(${ctxStaticFront}/images/ylbanner.jpg)" style="background:#fff center 0 no-repeat;"></li> --%> 
						    <%--   <li _src="url(${ctxStaticFront}/images/ylbanner.jpg)" style="background:#fff center 0 no-repeat;"></li>
						      <li _src="url(${ctxStaticFront}/images/ylbanner.jpg)" style="background:#fff center 0 no-repeat;"></li> --%>
						       </c:forEach>
						       
						      
						      
						    </ul>
						</div>
						<div class="hd">
						    <ul>
						    </ul>
						</div>
					</div>
					
						<div class="i7" > 
							<div class="center">
							<c:forEach var="newstype" items="${typeList}"  begin="0" end="1" varStatus="status">
								<c:if test="${status.index % 2 == 0 }">
								<div class="l"> 
										<p class="i7p">${newstype.newstypename } <span></span> <a class="more" href="./more/${newstype.newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
											<c:set var="detailLists" value="${fnf:getnewsList(newstype.newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="./${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
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
								</c:if>
								<c:if test="${status.index % 2 == 1 }">
								<div class="r"> 
										<p class="i7p">${newstype.newstypename } <span></span><a class="more" href="./more/${newstype.newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
											<c:set var="detailLists" value="${fnf:getnewsList(newstype.newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="./${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
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
								</c:if>
								</c:forEach>
							</div>

					</div>	
					<div class="wxb">
							<div class="center">
							    <c:set var="advertiselists" value="${fnf:getAdvertisePictures('informationimg')}"/>
								<c:forEach items="${advertiselists}" var="advertise" varStatus="newstatus">
								  <c:if test="${newstatus.index==0}">
								   <a href=""><img src="${ctx}${advertise.advertisesrc}"></a>
								 </c:if>
						       </c:forEach>
							<%-- 	<a href=""><img src="${ctxStaticFront}/images/wxb.jpg"></a> --%>
							</div>	
					</div>		
					<c:forEach var="newstype" items="${typeList}"  begin="2"  step="2" varStatus="status">
					<div class="i7" > 
							<div class="center">
								<div class="l"> 
										<p class="i7p">${typeList[status.index].newstypename}<span></span> <a class="more" href="./more/${newstype.newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
											<c:set var="detailLists" value="${fnf:getnewsList(typeList[status.index].newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="./${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
												<div class="l">
													<c:if test="${not empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${newsdtail.newsdetailspicture}">
													</c:if>	
													<c:if test="${empty newsdtail.newsdetailspicture }">
														<img height="88px"  width="90px" src="${ctxStaticFront}/images/zixunimg.jpg">
													</c:if>	
												</div>
												<div class="r">
													<p><b>${newsdtail.newsdetailtitle}</b>	</p>
													<span>${newsdtail.newsdetailabstract}</span>
												</div>
												</a>
											</li>
										    </c:forEach>
										</ul>
								</div>
								
								<c:if test="${status.index+2 <= fn:length(typeList)}">
								<div class="r"> 
										
										<p class="i7p">${typeList[status.index+1].newstypename } <span></span><a class="more" href="./more/${typeList[status.index+1].newstypeid}${urlSuffix}">更多>></a></p>
										<ul>
											<c:set var="detailLists" value="${fnf:getnewsList(typeList[status.index+1].newstypeid, 3)}"/>
											<c:forEach items="${detailLists}" var="newsdtail" varStatus="newstatus">
											<li class="animate-element fadein">
												<a href="./${newsdtail.newsdetailid}${urlSuffix}" class="opacity">
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
							 </c:if>
								
							</div>

					</div>	
					 </c:forEach>
					
							
					
				</div>
			
				
		</div>	
		
<script type="text/javascript"> 
jQuery(".fullSlide").slide({
interTime:5000,
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    mouseOverStop:false,
    startFun: function(i) {
        var curLi = jQuery(".fullSlide .bd li").eq(i);
        if ( !! curLi.attr("_src")) {
            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
        }
    }
});

</script>			

</body>
</html>
