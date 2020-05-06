<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/EbUseraddress/list?userId=${userId}">用户地址列表</a></li>
		<li class="active"><a href="${ctxsys}/EbUseraddress/form?id=${ebUseraddress.addressId}&userId=${userId}">用户地址<shiro:hasPermission name="sys:user:edit">${not empty ebUseraddress.addressId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:user:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ebUseraddress" action="${ctxsys}/EbUseraddress/save" method="post" class="form-horizontal">
		<input type="hidden" value="${userId}" name="userId"/>
		<form:hidden path="addressId"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">收货人姓名:</label>
			<div class="controls">
			<form:input path="userName" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货人手机:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="50" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">省份编码:</label>
					<div class="controls">
						<form:input path="provincesId" htmlEscape="false" maxlength="50" class="required"/>
					
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">市编码:</label>
			<div class="controls">
			<form:input path="municipalId" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区县编码:</label>
			<div class="controls">
				<form:input path="districtId" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">省份:</label>
			<div class="controls">
			<form:input path="provinces" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">市:</label>
			<div class="controls">
			<form:input path="municipal" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区县:</label>
			<div class="controls">
				<form:input path="district" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">经度:</label>
			<div class="controls">
			<form:input path="longitude" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">纬度:</label>
			<div class="controls">
			<form:input path="latitude" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">用户定位位置:</label>
			<div class="controls">
			<form:input path="userLocation" htmlEscape="false" maxlength="500" class="required"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">详细地址:</label>
			<div class="controls">
				<form:input path="detailsAddress" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">状态:</label>
			<div class="controls">
			<form:select  path="status" >
				<form:option value="0">默认</form:option>
				<form:option value="1">不默认</form:option>
			</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>