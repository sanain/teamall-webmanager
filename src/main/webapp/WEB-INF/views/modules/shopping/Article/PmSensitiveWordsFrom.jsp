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
		<li ><a href="${ctxsys}/PmSensitiveWords">敏感词列表</a></li>
		<li class="active"><a href="${ctxsys}/PmSensitiveWords/form">敏感词<shiro:hasPermission name="merchandise:PmSensitiveWords:edit">${not empty pmSensitiveWords.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmSensitiveWords:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmSensitiveWords" action="${ctxsys}/PmSensitiveWords/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
			  <form:input path="sensitiveWords" required="required"/>
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
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmSensitiveWords:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>