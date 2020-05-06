<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
	    $(document).ready(function() {
	    
		});
	 	</script>
</head>
<body>
     <ul class="nav nav-tabs">
        <li ><a href="${ctxsys}/NcInfo/list">配置列表</a></li>
		<shiro:hasPermission name="merchandise:NcInfo:view">
		<li class="active"><a href="${ctxsys}/NcInfo/form">配置修改</a></li>
		</shiro:hasPermission>
	 </ul>
	 
	<tags:message content="${message}"/>
	<form:form id="inputForm"  modelAttribute="ncInfo" action="${ctxsys}/NcInfo/save"  method="post" class="form-horizontal">
			<form:hidden path="id"/>
				<div class="control-group">
					<label class="control-label">密钥向量：</label>
					<div class="controls">
		            <form:input path="keyVector" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">密钥：</label>
					<div class="controls">
		            <form:input path="informationKey" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
			    <div class="control-group">
				  <label class="control-label">密钥是否加密：</label>
					<div class="controls">
		             <form:select path="isInformationKey">
		                <form:option value="0">否</form:option>
		                <form:option value="1">是</form:option>
		             </form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">密钥加密密钥：</label>
					<div class="controls">
		            <form:input path="encryptionKey" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">安全校验码：</label>
					<div class="controls">
		            <form:input path="securityCheckCode" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				  <div class="control-group">
				  <label class="control-label">安全校验码是否加密：</label>
					<div class="controls">
		             <form:select path="isSecurityCheck">
		                <form:option value="0">否</form:option>
		                <form:option value="1">是</form:option>
		             </form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">安全校验码密钥：</label>
					<div class="controls">
		            <form:input path="securityCheckCodeKey" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">请求地址：</label>
					<div class="controls">
		            <form:input path="ncUrl" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">公司编码：</label>
					<div class="controls">
		            <form:input path="pkCorp" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:NcInfo:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>