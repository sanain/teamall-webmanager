<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户消息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/messageUser/list">用户消息列表</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebMessageUser" action="${ctxsys}/messageUser/view" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="messageInfo.messageClass">消息分类:</label>
			<div class="controls">
				<form:select path="messageInfo.messageClass" class="input-medium" disabled="true">
					<form:options items="${fns:getDictList('messageClass')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageInfo.messageTitle">标题:</label>
			<div class="controls">
				<form:input path="messageInfo.messageTitle" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" readonly="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageInfo.messageAbstract">简述:</label>
			<div class="controls">
				<form:textarea path="messageInfo.messageAbstract" htmlEscape="false"  class="required input-xxlarge" style="width: 560px;" disabled="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageInfo.messageContent">内容:</label>
			<div class="controls">
				<form:textarea path="messageInfo.messageContent" htmlEscape="false" class="required input-xxlarge" style="width: 560px;height: 130px;" disabled="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageInfo.messageType">消息类型:</label>
			<div class="controls">
				<form:select path="messageInfo.messageType" class="input-medium" disabled="true">
					<form:options items="${fns:getDictList('messageInfo.messageType')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>