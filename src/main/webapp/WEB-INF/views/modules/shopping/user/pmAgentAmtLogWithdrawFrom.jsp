<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>代理提现</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				rules: {
					amt: {
						min:1
					},
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
		<li class="active"><a>提现申请</a></li>
		<li class=""><a href="${ctxsys}/pmAgentAmtLog/agentAmtList?amtType=1">提现列表</a></li>
	</ul>
	<tags:message content="${message}"/>
	<form:form id="inputForm" modelAttribute="pmAgentAmtLog" action="${ctxsys}/pmAgentAmtLog/add" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">当前金额 :</label>
			<div class="controls">
			${sysOffice.currentAmt}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">金额 :</label>
			<div class="controls">
			 <form:input path="amt" type="number" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" >银行卡:</label>
			<div class="controls">
			<c:if test="${empty pmAgentBanks}">请添加银行卡</c:if>
			<c:if test="${not empty pmAgentBanks}">
			 <form:select path="bankId" class="input">
					<form:options items="${pmAgentBanks}" itemLabel="account" itemValue="id" htmlEscape="false" />
				</form:select>
			</c:if>
			</div>
		</div> 
		
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>