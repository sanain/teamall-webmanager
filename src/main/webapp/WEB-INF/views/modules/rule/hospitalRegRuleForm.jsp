<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>挂号限制规则管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#depName").focus();
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
		<li><a href="${ctxsys}/rule/hospitalRegRule/">挂号限制规则列表</a></li>
		<li class="active"><a href="form?id=${hospitalRuleReg.id}">挂号限制规则<shiro:hasPermission name="rule:reg:edit">${not empty hospitalRegRule.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="rule:reg:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="hospitalRegRule" action="${ctxsys}/rule/hospitalRegRule/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">医院:</label>
			<div class="controls">
				<tags:treeselect id="hospital" name="hospital.hospitalId" value="${hospitalRegRule.hospital.hospitalId}" labelName="hospital.name" labelValue="${hospitalRegRule.hospital.name}"
					title="医院" url="${ctxsys}/sys/department/treeDataForHospital" cssClass="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isClose">是否启用:</label>
			<div class="controls">
				<form:select path="isClose" class="input-xlarge">
					<form:option value="1">启用</form:option>
					<form:option value="0">未启用</form:option>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="week">执行星期:</label>
			<div class="controls">
				<form:select path="week" class="input-xlarge">
					<form:option value="1">星期一</form:option>
					<form:option value="2">星期二</form:option>
					<form:option value="3">星期三</form:option>
					<form:option value="4">星期四</form:option>
					<form:option value="5">星期五</form:option>
					<form:option value="6">星期六</form:option>
					<form:option value="7">星期日</form:option>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="startTimeHour">服务开通时间:</label>
			<div class="controls">
				<form:select path="startTimeHour" class="input-xlarge">
					<c:forEach items="${hours}" var="hour">
						<form:option value="${hour }" label="${hour }"/>
					</c:forEach>
				</form:select>时
				<form:select path="startTimeMin" class="input-xlarge">
					<c:forEach items="${mins}" var="min">
						<form:option value="${min }" label="${min }"/>
					</c:forEach>
				</form:select>分
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="endTimeHour">服务关闭时间:</label>
			<div class="controls">
				<form:select path="endTimeHour" class="input-xlarge">
					<c:forEach items="${hours}" var="hour">
						<form:option value="${hour }" label="${hour }"/>
					</c:forEach>
				</form:select>时
				<form:select path="endTimeMin" class="input-xlarge">
					<c:forEach items="${mins}" var="min">
						<form:option value="${min }" label="${min }"/>
					</c:forEach>
				</form:select>分
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="7" maxlength="300" class="input-xlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="rule:reg:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>