<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
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
		<li ><a href="${ctxsys}/PmFunctionClass">功能图片列表</a></li>
		<li class="active"><a href="${ctxsys}/PmFunctionClass/form">功能图片<shiro:hasPermission name="merchandise:PmFunctionClass:edit">${not empty pmFunctionClass.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmFunctionClass:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmFunctionClass" action="${ctxsys}/PmFunctionClass/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">功能分类编码:</label>
			<div class="controls">
			  <form:input path="functionClassCode" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">功能分类名称:</label>
			<div class="controls">
			  <form:input path="functionClassName" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">排序:</label>
			<div class="controls">
				<form:input path="sortnum" htmlEscape="false" maxlength="10"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">连接URL:</label>
			<div class="controls">
				<form:input path="linkUrl" htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">状态:</label>
			<div class="controls">
			  <form:select path="status"  class="input-medium">
		           <form:option value="0">不显示</form:option>
		           <form:option value="1">显示</form:option>
               </form:select>  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">功能分类图标URL:</label>
			<div class="controls">
			    <form:hidden path="functionClassIconUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="functionClassIconUrl"  style="color: blue;"></span>
				<tags:ckfinder input="functionClassIconUrl" type="images" uploadPath="/merchandise/getpmfClass/adImg"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmFunctionClass:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>