<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="${fns:getProjectName()}"/></title>
	<%@include file="/WEB-INF/views/modules/front/include/head.jsp" %>
	<link rel="shortcut icon" href="${ctxStaticFront}/images/favicon.png" type="image/png">
	<sitemesh:head/>
</head>
<body >
	<div id="top" class="animate-element top_to_bottom"> 
				  <%@include file="/WEB-INF/views/modules/front/include/top.jsp" %>
					<div class="nav"> 
					<div class="center">
						<div class="l">
							<div class="logo"> 
									<a href="${ctx}/"><img src="${ctxStaticFront}/images/logo.png"></a>
							</div>
						</div>
						<div class="r"> 
								<ul> 
								<li class=""><a href="${ctx}/#top">首页</a></li>
									<li class=""><a href="${ctx}/#yl">就诊服务</a></li>
									<li class=""><a href="${ctx}/#yc">网络医疗</a></li>
									<li class=""><a href="${ctx}/#dt">智能导诊</a></li>
									<li class=""><a href="${ctx}/#yz">义诊咨询</a></li>
									<li class=""><a href="${ctx}/#yd">健康资讯</a></li>
								<!-- 	<li class=""><a href="#cx">医患分享</a></li> -->
									<li class=""><a href="${ctx}/#fx">药品查询</a></li>
									
								</ul>
						</div>
					</div>
				</div>
		</div>
	<sitemesh:body/>
	<%@include file="/WEB-INF/views/modules/front/include/bottom.jsp" %>
</body>
</html>