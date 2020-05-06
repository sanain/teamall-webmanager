<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctxsys" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxweb" value="${pageContext.request.contextPath}"/>
<c:set var="ctxwebsys" value="${pageContext.request.contextPath}/sys"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>