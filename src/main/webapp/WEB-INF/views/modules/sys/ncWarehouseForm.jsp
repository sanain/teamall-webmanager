<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
	    $(document).ready(function() {
	    
		});
		$(function(){
			$("#password").val('');
		});
	 	</script>
		
		
		  <script type="text/javascript">
		$(function(){
			var msg='${msg}';
			var code='${code}';
			if(code=='01'||code=='00'){
			alert(msg);
			}
		});
	 	</script>
		
</head>
<body>
     <ul class="nav nav-tabs">
        <li ><a href="${ctxsys}/warehouse/list">仓库列表</a></li>
		<shiro:hasPermission name="merchandise:Warehouse:view">
		<li class="active"><a href="${ctxsys}/warehouse/form?id=${warehouse.id}">修改</a></li>
		</shiro:hasPermission>
	 </ul>
	 
	<tags:message content="${message}"/>
	<form:form id="inputForm"  modelAttribute="warehouse" action="${ctxsys}/warehouse/save"  method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="control-group">
					<label class="control-label">登录账号：</label>
					<div class="controls">
		            <form:input path="account" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">登录密码：</label>
					<div class="controls">
		            <form:input path="password" type="password" htmlEscape="false" maxlength="50"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">仓库编码：</label>
					<div class="controls">
		            <form:input path="wareNo" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">仓库名称：</label>
					<div class="controls">
		            <form:input path="wareName" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">对应部门编码：</label>
					<div class="controls">
		            <form:input path="organizationNo" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">对应部门名称：</label>
					<div class="controls">
		            <form:input path="organizationName" htmlEscape="false" maxlength="50" required="required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">仓库地址：</label>
					<div class="controls">
		            <form:input path="wareAddr" htmlEscape="false" maxlength="50"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">短信通知号码：</label>
					<div class="controls">
		            <form:input path="warePeaplePhone" htmlEscape="false" maxlength="200" required="required"/>
					</div>
					<font color="red"> *请填写仓库联系人手机号，短信提醒。
					多人提醒请以英文逗号隔开（例如：158172***22,159321***44）</font>
				</div>
				
				
				<div class="control-group">
					<label class="control-label">备注：</label>
					<div class="controls">
		            <form:input path="remarks" htmlEscape="false" maxlength="50"/>
					</div>
				</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:warehouse:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>