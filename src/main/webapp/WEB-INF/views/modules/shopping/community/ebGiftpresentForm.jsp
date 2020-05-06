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
        <li ><a href="${ctxsys}/EbGiftpresent/list">礼物列表</a></li>
		<li class="active"><a href="${ctxsys}/EbGiftpresent/form?id=${ebGiftpresent.id}">礼物<shiro:hasPermission name="merchandise:truewords:edit">${not empty ebGiftpresent.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:truewords:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebGiftpresent" action="${ctxsys}/EbGiftpresent/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">礼物名称:</label>
			<div class="controls">
			<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">图片:</label>
			<div class="controls">
				<form:hidden path="imgUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="imgUrl"  style="color: blue;"></span>
				<tags:ckfinder input="imgUrl" type="images" uploadPath="/merchandise/product"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">价格:</label>
			<div class="controls">
				<form:input path="money" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">状态</label>
			<div class="controls">
			<label class="attr"> <form:radiobutton path="status" value="0"  checked="checked"/>开启</label>
				<label class="attr"><form:radiobutton path="status" value="1"/>关闭</label>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:truewords:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>