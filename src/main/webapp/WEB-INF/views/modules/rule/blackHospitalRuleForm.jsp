<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
				    var blackHospitalId=-$("#blackHospitalId").val();
					if(''==blackHospitalId) {
				        document.getElementById("nonull").style.display='';
						alert('请选择医院');
						return false;
					}
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
		<li><a href="${ctxsys}/rule/blackHospitalRule/list">医院爽约黑名单规则管理</a></li>
		<li class="active">
		   <a href="${ctxsys}/rule/blackHospitalRule/form?id=${blackListHospitalRule.id}">医院爽约黑名单规则
		     <shiro:hasPermission name="rule:blackHospitalRule:edit">${not empty blackListHospitalRule.id?'修改':'添加'}</shiro:hasPermission>
		     <shiro:lacksPermission name="rule:blackHospitalRule:edit">查看</shiro:lacksPermission>
		    </a>
		</li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="blackListHospitalRule" action="${ctxsys}/rule/blackHospitalRule/blackHospitalRuleSave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="blackHospital">医院名:</label>
			<div class="controls">
			    <c:choose>
					    <c:when test="${blackListHospitalRule.id==null}">
					       <tags:treeselect id="blackHospital" name="blackHospital.hospitalId" value="${blackListHospitalRule.blackHospital.hospitalId}" labelName="blackHospital.name" labelValue="${blackListHospitalRule.blackHospital.name}" 
								title="医院" url="${ctxsys}/rule/blackHospitalRule/treeDataHospital" cssClass="imput-small" allowClear="true" />
								<label id="nonull" style="display: none;" class="error">请选择医院</label>
								<span class="help-inline"><font color="red">*</font> </span>
					       
					    </c:when>  
	
					    <c:otherwise>
	                       <td><span style="line-height:30px;"><b>${blackListHospitalRule.blackHospital.name }</b></span></td>
					    </c:otherwise>  
				     </c:choose>


				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" >黑名单规则:</label>
			<div class="controls">
				<form:input path="month" htmlEscape="false" maxlength="50" class="required number"/>个月内爽约<form:input path="missNumber" htmlEscape="false" maxlength="50" class="required number"/>次
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="10" maxlength="5000" cols="300"/>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="rule:blackHospitalRule:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
</body>
</html>