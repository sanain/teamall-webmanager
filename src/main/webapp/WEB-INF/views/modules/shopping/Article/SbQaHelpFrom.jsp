<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>增加问答帮助</title>
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
		<li ><a href="${ctxsys}/PmQaHelp">问答帮助列表</a></li>
		<li class="active"><a href="${ctxsys}/PmQaHelp/form">问答帮助<shiro:hasPermission name="merchandise:PmQaHelp:edit">${not empty sbServiceProtocol.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmQaHelp:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="sbQaHelp" action="${ctxsys}/PmQaHelp/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
			  <form:input path="name" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">类型:</label>
			<div class="controls">
			  <form:select path="qaType"  class="input-medium">
		           <form:option value="1">用户</form:option>
		           <form:option value="2">店家</form:option>
		           <%--<form:option value="3">代理</form:option>--%>
               </form:select>  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">排序:</label>
			<div class="controls">
				<form:input path="sortNum" htmlEscape="false" maxlength="10"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">状态:</label>
			<div class="controls">
			  <form:select path="delFlag"  class="input-medium">
		           <form:option value="0">不显示</form:option>
		           <form:option value="1">显示</form:option>
               </form:select>  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">内容:</label>
			<div class="controls">
				<form:textarea id="content" path="content" htmlEscape="false" maxlength="200"/>
				<tags:ckeditor replace="content" uploadPath="/merchandise/SbQaHelp" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmQaHelp:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>