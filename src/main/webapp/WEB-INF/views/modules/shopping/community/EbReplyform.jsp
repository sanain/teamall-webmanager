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
		<li class="active"><a href="#">贴子回复</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ebReply" action="${ctxsys}/EbReply/save" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="href">回帖的时间:</label>
			<div class="controls">
			<input class="small"  name="replyTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebReply.replyTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="sort">内容:</label>
			<div class="controls">
			 <form:textarea path="replyContent" id="replyContent" htmlEscape="false"/>
			<tags:ckeditor replace="replyContent" uploadPath="/article"></tags:ckeditor>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:community:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>