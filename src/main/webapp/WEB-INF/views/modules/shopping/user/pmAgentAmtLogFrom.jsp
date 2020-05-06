<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>代理提现</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			
			$("#checkStatus").change(function(){
				var withdrawProcess=$("#checkStatus").val();
				if(withdrawProcess==1){
					$("#btnSubmit").css("visibility","visible");
					$("#applycode").css("display","block");
				}else if(withdrawProcess==2){
					$("#btnSubmit").css("visibility","visible");
					$("#applycode").css("display","none");
				}else if(withdrawProcess==0){
					$("#btnSubmit").css("visibility","hidden");
					$("#applycode").css("display","none");
				}
			});
			
			
			
			
			
			
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
		<li class="active"><a>提现申请修改</a></li>
	</ul>
	<tags:message content="${message}"/>
	<form:form id="inputForm" modelAttribute="pmAgentAmtLog" action="${ctxsys}/pmAgentAmtLog/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">提现金额:</label>
			<div class="controls">
					<input type="text" value="${pmAgentAmtLog.amt}" disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提现银行账号:</label>
			<div class="controls">
				<input type="text" value="${pmAgentAmtLog.pmAgentBank.account}" disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开户名:</label>
			<div class="controls">
				<input type="text" value="${pmAgentAmtLog.pmAgentBank.accountName}" disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间:</label>
			<div class="controls">
				<input type="text" value="<fmt:formatDate value="${pmAgentAmtLog.createTime}" pattern="yyyy-MM-dd" />" disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核状态:</label>
			<div class="controls">
				<c:choose>
					<c:when test="${pmAgentAmtLog.status==0}">
						<form:select path="status" class="input-small" id="checkStatus">
							<form:option value="0">交易中</form:option>
							<form:option value="1">交易完成</form:option>
							<form:option value="2">交易取消</form:option>
						</form:select>
					</c:when>
					<c:otherwise>
						<c:if test="${pmAgentAmtLog.status==1}">交易完成</c:if>
						<c:if test="${pmAgentAmtLog.status==2}">交易取消</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="control-group" id="applycode" style="display: none;">
				<label class="control-label">提现编码 :</label>
				<div class="controls">
					<input type="text" value="${pmAgentAmtLog.applycode}" name="applycode" id="applycode"/>
				</div>
			</div>
		<div class="form-actions">
				<input id="btnSubmit" style="visibility: hidden;" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>