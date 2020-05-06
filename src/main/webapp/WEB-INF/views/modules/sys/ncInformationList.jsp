<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/NcInfo/list">nc请求信息配置</a></li>
		
	</ul>
	
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
	    <th>编号</th>
		<th>密钥向量</th>
		<th>密钥</th>
		<th>密钥加密</th>
		<th>密钥加密密钥</th>
		<th>安全校验码</th>
		<th>校验码加密</th>
		<th>安全校验码密钥</th>
		<th>请求地址</th>
		<th>公司编码</th>
		<shiro:hasPermission name="merchandise:NcInfo:edit">
		<th>操作</th>
		</shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="ncInfo" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td>${ncInfo.keyVector}</td>
				<td>${ncInfo.informationKey}</td>
				<td><c:if test="${ncInfo.isInformationKey==0}">否</c:if><c:if test="${ncInfo.isInformationKey==1}">是</c:if></td>
				<td>${ncInfo.encryptionKey}</td>
				<td>${ncInfo.securityCheckCode}</td>
				<td><c:if test="${ncInfo.isSecurityCheck==0}">否</c:if><c:if test="${ncInfo.isSecurityCheck==1}">是</c:if></td>
				<td>${ncInfo.securityCheckCodeKey}</td>
				<td>${ncInfo.ncUrl}</td>
				<td>${ncInfo.pkCorp}</td>
			   <shiro:hasPermission name="merchandise:NcInfo:edit"><td>
					<a href="${ctxsys}/NcInfo/form?id=${ncInfo.id}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>