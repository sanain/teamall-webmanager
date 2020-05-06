<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
		<li ><a href="${ctxsys}/PmServiceProtocol">平台协议列表</a></li>
		<li class="active"><a href="${ctxsys}/PmServiceProtocol/form">平台协议<shiro:hasPermission name="merchandise:PmServiceProtocol:edit">${not empty sbServiceProtocol.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmServiceProtocol:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="sbServiceProtocol" action="${ctxsys}/PmServiceProtocol/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">编码:</label>
			<div class="controls">
             <form:input path="code" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">内容</label>
			<div class="controls">
			<form:textarea id="contentInfo" path="contentInfo"  maxlength="200" htmlEscape="false"/>
			<tags:ckeditor replace="contentInfo" uploadPath="/merchandise/PmServiceProtocol"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">显示隐藏:</label>
			<div class="controls">
				<form:select path="delFlag" required="required" >
				   <form:option value="0">不显示</form:option>
				   <form:option value="1">显示</form:option>
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmServiceProtocol:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>