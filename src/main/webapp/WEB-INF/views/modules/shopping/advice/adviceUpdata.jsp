<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>查看</title>
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
		<li class="active"><a href="${ctxsys}/EbAdvice/list">意见与建议</a></li>
	</ul>
	
	<form:form id="inputForm" modelAttribute="ebAdvice" action="${ctxsys}/EbAdvice/updatedvice" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">编号:</label>
			<div class="controls">
			${ebAdvice.adviceId}
			<form:hidden path="adviceId"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话:</label>
			<div class="controls">
			${ebAdvice.contactNo}
			<form:hidden path="adviceId"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户ID:</label>
			<div class="controls">
			${ebAdvice.userId}
			<form:hidden path="userId"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提出时间:</label>
			<div class="controls">
			${ebAdvice.createdate}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="type">
			<form:option value="0">未读</form:option>
			<form:option value="1">已读</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">内容:</label>
			<div class="controls">
			<form:textarea path="advice"/>
			</div>
		</div>
			<div class="control-group">
			<c:forEach var="images" items="${ebProductimages}">
			<img width="70px;" height="50px;" src="${images.name}"/>
			</c:forEach>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:advice:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>