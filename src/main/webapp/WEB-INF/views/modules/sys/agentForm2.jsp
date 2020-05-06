<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合伙人管理</title>
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
							url:"${ctxsys}/sys/agent/checkName",
							data: {
								"oldName":"${agent.agentName}"
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
		<li><a href="${ctxsys}/sys/agent/list1?isAgent=1">合伙人列表</a></li>
		<li class="active"><a href="${ctxsys}/sys/agent/form1?agentId=${agent.agentId}&parent.agentId=${agent.parent.agentId}">合伙人
		<shiro:hasPermission name="sys:agent:edit">添加</shiro:hasPermission><shiro:lacksPermission name="sys:agent:view">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="agent" action="${ctxsys}/sys/agent/save1" method="post" class="form-horizontal">
		 <form:hidden path="agentId"/> 
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级合伙人: </label>
			<div class="controls">
              <tags:treeselect id="agent" name="agentId" value="${agent.agentId}" labelName="agentName" labelValue="${agent.agentName}"
					title="机构" url="${ctxsys}/sys/agent/treeData?type=1&isAgent=1" extId="${agent.agentId}" cssClass="required" />  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="agentName">合伙人名称:</label>
			<div class="controls">
				<%-- <form:input path="agentName" htmlEscape="false"  /> --%>
				<input type="text" name="agentName"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="agentType">代理类型:</label>
			<div class="controls">
			<form:select path="agentType">
					<form:options items="${fns:getDictList('sys_agent_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
		
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">绑定用户: </label>
			<div class="controls">
              <tags:treeselect id="agent" name="agentId" value="${agent.agentId}" labelName="agentName" labelValue=""
					title="机构" url="${ctxsys}/sys/agent/treeData?type=1&isAgent=1" extId="${agent.agentId}" cssClass="required" />  
			</div>
		</div>
		
		<%-- <div class="control-group">
			<label class="control-label" for="grade">机构级别:</label>
			<div class="controls">
				<form:select path="grade">
					<form:options items="${fns:getDictList('sys_agent_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label" for="isAgent">是否合伙人:</label>
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
<%-- 		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="sys:agent:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>