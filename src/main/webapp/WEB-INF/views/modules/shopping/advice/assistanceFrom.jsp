<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>查看</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class=""><a href="${ctxsys}/assistance/list">帮助</a></li>
		<li class="active"><a href="${ctxsys}/assistance/form?id=${ebAssistance.id}">帮助<shiro:hasPermission name="merchandise:assistance:edit">${not empty ebAssistance.id?'修改':'添加'}</shiro:hasPermission></a></li>
	
	</ul>
	
	<form:form id="inputForm" modelAttribute="ebAssistance" action="${ctxsys}/assistance/save" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label" for="href">标题:</label>
			<div class="controls">
			<form:select path="type">
			<form:option value="1">新手指导</form:option>
			<form:option value="2">售后说明</form:option>
			<form:option value="3">支付说明</form:option>
			<form:option value="4">配送方式</form:option>
			<form:option value="5">客服热线</form:option>
			<form:option value="6">夺宝协议</form:option>
			<form:option value="7">用户协议</form:option>
			<form:option value="8">玩法说明</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">内容:</label>
			<div class="controls">
			<form:textarea id="content" htmlEscape="true" path="content" rows="6"  maxlength="3000"   class="input-xxlarge"/>
				<tags:ckeditor replace="content" uploadPath="/merchandise/assistance" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:assistance:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>