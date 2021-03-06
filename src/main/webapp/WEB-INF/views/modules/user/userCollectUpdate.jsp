<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改</title>
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
		<li class="active"><a href="${ctxsys}/EbCollect/list">修改</a></li>
	</ul>
	
	<form:form id="inputForm" modelAttribute="ebCollect" action="${ctxsys}/EbCollect/UpdateCollect" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">ID:</label>
			<div class="controls">
			${ebCollect.id}
			<form:hidden path="id"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户ID:</label>
			<div class="controls">
			${ebCollect.userId}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户名:</label>
			<div class="controls">
			${ebCollect.userName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">类型:</label>
			<div class="controls">
			<form:select path="userType">
			<form:option value="1">商品</form:option>
			<form:option value="2">帖子</form:option>
			<form:option value="3">文章</form:option>
			<form:option value="4">关注用户</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收藏对象:</label>
			<div class="controls">
			${ebCollect.objectId}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="userType">
			<form:option value="1">显示</form:option>
			<form:option value="2">隐藏</form:option>
			<form:option value="3">删除</form:option>
			</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:collect:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>