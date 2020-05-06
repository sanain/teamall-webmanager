<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>转盘奖品池</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/lottery/list">奖品池列表</a></li>
		</ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebPrize" action="${ctxsys}/lottery/save" method="post" class="form-horizontal">
		<form:hidden path="prizeId" />
		<form:hidden path="createTime" />
		
		<div class="control-group">
			<label class="control-label" for="prizeName">奖品名称 :</label>
			<div class="controls">
				<form:input path="prizeName" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="begin">奖品池区间开始值 :</label>
			<div class="controls">
				<form:input path="begin" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="end">奖品池区间结束值 :</label>
			<div class="controls">
				<form:input path="end" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="number">奖品池剩余数量 :</label>
			<div class="controls">
				<form:input path="number" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

</body>
</html>