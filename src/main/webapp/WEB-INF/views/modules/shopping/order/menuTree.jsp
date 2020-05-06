<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单导航</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="accordion" id="menu">
	<table>
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
		<tr>
			<td>${menu.id}</td>
		    <td>${menu.name}</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>
