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
	<div id="top_ys" class="animate-element top_to_bottom tys"> 
		<%@include file="/WEB-INF/views/modules/front/include/tophospital.jsp" %>
	</div>
	<sitemesh:body/>
	<%@include file="/WEB-INF/views/modules/front/include/bottom.jsp" %>
</body>
</html>