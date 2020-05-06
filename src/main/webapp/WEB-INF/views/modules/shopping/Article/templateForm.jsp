<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
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
		<li><a href="${ctxsys}/template">广告模板列表</a></li>
		 <li  class="active"><a href="${ctxsys}/template/form">广告模板<shiro:hasPermission name="merchandise:template:edit">${not empty ebProductimage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:template:edit">查看</shiro:lacksPermission></a></li>
 	</ul>
	<form:form id="inputForm" modelAttribute="ebLayouttype" action="${ctxsys}/template/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">标题:</label>
			<div class="controls">
			<form:input path="moduleTitle" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题图片:</label>
			<div class="controls">
			  <form:hidden path="moduleTitleDemoUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					<span class="help-inline" id="moduleTitleDemoUrl"  style="color: blue;"></span>
			   <tags:ckfinder input="moduleTitleDemoUrl" type="images" uploadPath="/merchandise/template"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">模板类型:</label>
			<div class="controls">
			<form:select path="moduleType" items="${fns:getDictListDelFlag('caType','0')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			  <%--  <form:select path="moduleType"  required="required">
				  <form:option value="1">活动模板</form:option>
				  <form:option value="2">必抢</form:option>
				  <form:option value="3">品牌推荐</form:option>
				  <form:option value="4">单类推荐</form:option>
				</form:select> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">序号:</label>
			<div class="controls">
				<form:input path="objectId" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">类型:</label>
			<div class="controls">
				<form:select path="type">
				  <form:option value="1">app</form:option>
				  <form:option value="2">h5</form:option>
				  <form:option value="3">pc</form:option>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">对应业务广告:</label>
			<div class="controls">
			   <form:select path="objAdModule" items="${fns:getDictListDelFlag('layouttype','0')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">模板图:</label>
				<div class="controls">
				       <form:hidden path="moduleDemoUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					   <span class="help-inline" id="moduleDemoUrl"  style="color: blue;"></span>
					   <tags:ckfinder input="moduleDemoUrl" type="images" uploadPath="/merchandise/template"/>
					   <p style="color: red;">*广告图片需要提示设置的广告大小751*368</p>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">模板背景图:</label>
				<div class="controls">
				       <form:hidden path="moduleBg" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					   <span class="help-inline" id="moduleBg"  style="color: blue;"></span>
					   <tags:ckfinder input="moduleBg" type="images" uploadPath="/merchandise/template"/>
					   <p style="color: red;">*广告的背景图，只在分类展示生效</p>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">模板描述:</label>
			<div class="controls">
			  <form:textarea path="moduleDesc" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">状态:</label>
			<div class="controls">
			<form:radiobutton path="status" value="1" required="required" />开启
			<form:radiobutton path="status" value="2" />关闭
			</div>
		</div>
		<div class="form-actions">
			 <shiro:hasPermission name="merchandise:template:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission> 
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>