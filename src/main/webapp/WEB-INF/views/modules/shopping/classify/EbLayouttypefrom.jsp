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
		<li><a href="${ctxsys}/EbLayouttype">模板列表</a></li>
		<li class="active"><a href="${ctxsys}/EbLayouttype/form?id=${ebLayouttype.id}">广告<shiro:hasPermission name="merchandise:layouttype:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:layouttype:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ebLayouttype" action="${ctxsys}/EbLayouttype/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="name">模板名称:</label>
			<div class="controls">
				<form:input path="moduleTitle" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">类型:</label>
				<div class="controls">
				<form:select path="type">
				<form:option value="0">app</form:option>
				<form:option value="1">h5</form:option>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">模板类别:</label>
			<div class="controls">
				<form:select path="moduleType">
				<form:option value="1">文章宫格列表</form:option>
				<form:option value="2">配图广告加广告列表类别1:1:1</form:option>
				<form:option value="3">广告加商品类别</form:option>
				<form:option value="4">商品宫格列表</form:option>
				<form:option value="5">头部广告</form:option>
				<form:option value="6">热点广告</form:option>
				<form:option value="7">热门筛选</form:option>
				<form:option value="8">h5的一元夺宝广告</form:option>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">模板状态:</label>
			<div class="controls">
				<form:select path="status">
				<form:option value="1">开启</form:option>
				<form:option value="2">未开启</form:option>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">排序:</label>
			<div class="controls">
				<form:input path="objectId" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:layouttype:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>