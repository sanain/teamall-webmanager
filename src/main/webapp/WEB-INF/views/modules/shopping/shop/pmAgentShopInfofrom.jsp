<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},${fns:getProjectName()}分场信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},${fns:getProjectName()}分场信息"/>
	<title>分场信息</title>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#name").focus();
		$("#inputForm").validate({
			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			}
		});
	});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/AgentShopInfo/form">分场信息</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmAgentShopInfo" enctype="multipart/form-data" action="${ctxsys}/AgentShopInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="agentId"/>
		<form:hidden path="agentShopType"/>
		<tags:message content="${message}"/>
		<c:if test="${pmAgentShopInfo.agentShopType==2}">
			<div class="control-group">
			<label class="control-label" for="href">代&nbsp;&nbsp;理&nbsp;&nbsp;机&nbsp;&nbsp;构:</label>
			<div class="controls">
				<label class="lbl">${pmAgentShopInfo.sysOffice.name}</label>
			</div>
		</div> 
		</c:if>
		<div class="control-group">
	        <label class="control-label">分场主图:</label>
	        <div class="controls">
	            <form:hidden path="agentMainPicUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
	            <span class="help-inline" id="agentMainPicUrl"  style="color: blue;"></span>
	            <tags:ckfinder input="agentMainPicUrl" type="images" uploadPath="/merchandise/AgentShopInfo"/>
	        </div>
   		</div>
		<div class="control-group">
			<label class="control-label" for="href">分场名称:</label>
			<div class="controls">
			 <form:input path="agentShopName" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" for="href">分场简介:</label>
			<div class="controls">
			 <form:textarea path="agentShopIntroduce" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" for="href">分场描述:</label>
			<div class="controls">
			 <form:textarea path="agentShopDescribe" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">更新时间:</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${pmAgentShopInfo.modifyTime}" type="both" dateStyle="full"/></label>
			</div>
		</div> 
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>