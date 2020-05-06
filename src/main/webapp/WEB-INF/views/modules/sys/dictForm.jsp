<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate({
				rules: {
					value:{required:true,maxlength:"50"},
					label:{required:true,maxlength:"50"},
					type:{required:true,abc:true,maxlength:"50"},
					description:{required:true,maxlength:"50"},
					sort:{required:true,digits:true,maxlength:"11"}
				},
				messages: {
					
				},
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
		<li><a href="${ctxsys}/sys/dict/">字典列表</a></li>
		<li class="active"><a href="${ctxsys}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="dict" action="${ctxsys}/sys/dict/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="value">键值:</label>
			<div class="controls">
				<form:input path="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="label">标签:</label>
			<div class="controls">
				<form:input path="label" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="type">类型:</label>
			<div class="controls">
				<form:input path="type" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="description">描述:</label>
			<div class="controls">
				<form:input path="description" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="sort">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:dict:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>