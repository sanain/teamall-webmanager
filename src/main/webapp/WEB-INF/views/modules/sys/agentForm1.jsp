<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合伙人管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/sys/agent/list1?isAgent=1">合伙人列表</a></li>
		<li class="active"><a href="${ctxsys}/sys/agent/form1?agentId=${agent.agentId}&parent.agentId=${agent.parent.agentId}">合伙人
		<shiro:hasPermission name="sys:agent:edit">${ agent.flag eq 'add' ? '添加':'修改'}</shiro:hasPermission><shiro:lacksPermission name="sys:agent:view">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="agent" action="${ctxsys}/sys/agent/save1" method="post" class="form-horizontal">
		 <form:hidden path="agentId"/> 
		  <form:hidden path="flag"/> 
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级合伙人: </label>
			<div class="controls">
		  <c:choose>
		  <c:when test="${agent.flag eq 'add' }">
		    <tags:treeselect id="agent" name="parent.agentId" value="${agent.parent.agentId}" labelName="parent.agentName" labelValue="${agent.parent.agentName}"
					title="合伙人" url="${ctxsys}/sys/agent/treeData" extId="${agent.agentId}" cssClass="required" /> 
		  </c:when>
		  <c:otherwise>
		  	${agent.parent.agentName }
		  </c:otherwise>
		  </c:choose>
		
             
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="agentName">合伙人名称:</label>
			<div class="controls">
				<form:input path="agentName" htmlEscape="false"  />
			</div>
		</div>
		<c:if test="${not empty agent.agentId and agent.flag eq 'edit'}">
		<div class="control-group">
			<label class="control-label" for="agentCode">合伙人编码: </label>
			<div class="controls">
			${agent.agentCode}
			</div>
		</div>
		</c:if>
		<div class="control-group">
			<label class="control-label" for="agentType">代理类型:</label>
			<div class="controls">
			  <c:choose>
		  <c:when test="${agent.flag eq 'add' }">
		    <form:select path="agentType">
					<form:options items="${fns:getDictList('sys_agent_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>  
		  </c:when>
		  <c:otherwise>
		  ${fns:getDictLabel(agent.agentType, 'sys_agent_type', '无')}
		  </c:otherwise>
		  </c:choose>
		 
			</div>
		</div>
		<c:if test="${not empty agent.agentId and agent.flag eq 'edit'}">
		 <c:if test="${not empty agent.agentInvitationCode }">
		<div class="control-group">
			<label class="control-label" for="agentInvitationCode">合伙人邀请码:</label>
			<div class="controls">
				${agent.agentInvitationCode}
			</div>
		</div></c:if>
		</c:if>
		
		
		
		<c:if test="${not empty agent.agentId and empty agentUser}">
		 <form:hidden path="ebind" value="0"/> 
		<div class="control-group">
			<label class="control-label">绑定用户: </label>
			<div class="controls">
              <tags:treeselect id="user" name="user.userId" value="${agent.user.userId}" labelName="user.mobile" labelValue="${agent.user.mobile}"
					title="用户" url="${ctxsys}/sys/agent/treeUserData"  />  
			</div>
		</div>
		</c:if>
		
			<c:if test="${not empty agentUser}">
			 <form:hidden path="user.userId" value="${agentUser.userId }"/> 
		    <div class="control-group">
			<label class="control-label">解绑用户:${agentUser.mobile } </label>
			<div class="controls">
              <input type="radio" name="ebind" value="1"/>是
               <input type="radio" name="ebind" checked="checked" value="0"/>否
			</div>
		</div>
		</c:if>
		
		
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