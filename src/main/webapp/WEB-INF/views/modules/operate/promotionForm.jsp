<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>转盘奖品池</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/lottery/list">奖品池列表</a></li>
		</ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebPromotion" action="${ctxsys}/promotion/save" method="post" class="form-horizontal">
		<form:hidden path="promotionId" />
		<form:hidden path="createTime" />
		
		<div class="control-group">
			<label class="control-label" for="promotionName">活动名称 :</label>
			<div class="controls">
				<form:input path="promotionName" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="url">活动链接 :</label>
			<div class="controls">
				<form:input path="url" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="peopleNum">参与人数 :</label>
			<div class="controls">
				<form:input path="peopleNum" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isOpen">是否开启 :</label>
			<div class="controls">
				<form:radiobutton path="isOpen" htmlEscape="false" class="required" value="1" />是
				<form:radiobutton path="isOpen" htmlEscape="false" class="required" value="0" />否
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

</body>
</html>