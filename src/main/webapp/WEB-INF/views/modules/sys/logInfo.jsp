<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日记详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/sys/log">日志列表</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="log" action="#" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">创建者:</label>
			<div class="controls">
			<label class="lbl">${log.createBy.loginName}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作的URI:</label>
			<div class="controls">
			<label class="lbl">${log.requestUri}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作的方式:</label>
			<div class="controls">
			<label class="lbl">${log.method}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作提交的数据:</label>
			<div class="controls">
			<label style="word-break: break-all;width: 50%;">${log.params}</label>
				<%--<form:textarea path="params" htmlEscape="false" rows="3" readonly="true"/>
			--%></div>
		</div>
		<div class="control-group">
			<label class="control-label">操作用户的IP地址:</label>
			<div class="controls">
			<label class="lbl">${log.remoteAddr}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作用户代理信息:</label>
			<div class="controls">
			<label class="lbl">${log.userAgent}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间:</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${log.createDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>