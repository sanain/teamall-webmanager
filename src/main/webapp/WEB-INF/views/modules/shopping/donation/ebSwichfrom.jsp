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
		<li ><a href="${ctxsys}/EbSwitch/list">活动列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li class="active"><a href="${ctxsys}/EbSwitch/form">活动添加</a></li></shiro:hasPermission>
	</ul></ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebSwitch" action="${ctxsys}/EbSwitch/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="type">
			<form:option value="0">ios内购</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="state">
			<form:option value="0">关</form:option>
			<form:option value="1">开</form:option>
			</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:Donation:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>