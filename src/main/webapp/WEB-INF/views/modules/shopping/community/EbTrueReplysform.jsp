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
		<li class="active"><a href="#">贴子回复详情</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ebRestore" action="${ctxsys}/EbRestore/save" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="name">用户名:</label>
			<div class="controls">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">回帖的时间:</label>
			<div class="controls">
			<input class="small"  name="time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebRestore.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">听众次数:</label>
			<div class="controls">
				<form:input path="commentNum" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">打赏</label>
			<div class="controls">
			<form:input path="exceptionalNum" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="sort">内容:</label>
			<div class="controls">
			<audio src="${ebRestore.content}" controls="controls"></audio>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">状态</label>
			<div class="controls">
			<form:select path="state" style="width: 100px;" class="input-medium">
		           <option value="">请选择</option>
		           <form:option value="1">完成</form:option>
		           <form:option value="2">未完成</form:option>
					<form:option value="3">删除</form:option>
               </form:select>  
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