<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				rules: {
					name: {
						required:true,
						maxlength:"50",
						remote: {
							url:"${ctxsys}/sys/office/checkName",
							data: {
								"oldName":"${office.name}"
							},
							type:"post"
						}
					},
					phone:"phone",
					email:"email"
				},
				messages: {
					name: {remote: "该名称已存在，请修改"}
				},
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
		<li><a href="${ctxsys}/sys/office/list1?isAgent=1">代理机构列表</a></li>
		<li class="active"><a href="${ctxsys}/sys/office/form1?id=${office.id}&parent.id=${office.parent.id}">代理机构<shiro:hasPermission name="sys:office:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:office:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="office" action="${ctxsys}/sys/office/save1" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级机构:</label>
			<div class="controls">
                <tags:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
					title="机构" url="${ctxsys}/sys/office/treeData?type=1&isAgent=1" extId="${office.id}" cssClass="required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">机构名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" />
			</div>
		</div>
		<c:if test="${not empty office.id}">
		<div class="control-group">
			<label class="control-label" for="code">机构编码:</label>
			<div class="controls">
			 ${office.code }
			</div>
		</div>
		</c:if>
		<div class="control-group">
			<label class="control-label" for="type">机构类型:</label>
			<div class="controls">
				<form:select path="type">
					<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<c:if test="${not empty office.id}">
		<div class="control-group">
			<label class="control-label" for="code">代理邀请码:</label>
			<div class="controls">
				${office.agentInvitationCode}
			</div>
		</div>
		</c:if>
		<%-- <div class="control-group">
			<label class="control-label" for="grade">机构级别:</label>
			<div class="controls">
				<form:select path="grade">
					<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label" for="isAgent">是否代理:</label>
			<div class="controls">
				<form:select path="isAgent">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label" for="address">联系地址:</label>
			<div class="controls">
				<form:input path="address" htmlEscape="false" maxlength="50"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="zipCode">邮政编码:</label>
			<div class="controls">
				<form:input path="zipCode" htmlEscape="false" maxlength="50"/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label" for="master">负责人:</label>
			<div class="controls">
				<form:input path="master" htmlEscape="false" maxlength="50"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="phone">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="50"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="fax">传真:</label>
			<div class="controls">
				<form:input path="fax" htmlEscape="false" maxlength="50"/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label" for="email">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="50"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:office:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>