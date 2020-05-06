<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>查看</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		<li ><a href="${ctxsys}/Clinetversion/list">版本列表</a></li>
		<shiro:hasPermission name="merchandise:Clinetversion:edit"><li class="active"><a href="${ctxsys}/Clinetversion/form">版本添加</a></li></shiro:hasPermission>
	</ul>
	
	<form:form id="inputForm" modelAttribute="clinetversion" enctype="multipart/form-data" action="${ctxsys}/Clinetversion/save" method="post" class="form-horizontal">
		<form:hidden path="versionId"/>
		<div class="control-group">
			<label class="control-label">版本名称:</label>
			<div class="controls">
			<form:input path="versionName" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">版本号:</label>
			<div class="controls">
			<form:input path="versionNo" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">更新说明:</label>
			<div class="controls">
			<form:textarea path="versionDesc" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否强制更新:</label>
			<div class="controls">
			<label class="attr"> <form:radiobutton path="versionType" value="0"  checked="checked"/>否</label>
				<label class="attr"><form:radiobutton path="versionType" value="1"/>是</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">APP分类:</label>
			<div class="controls">
			  <form:select path="versionKind" required="required">
			    <form:option value="1">${fns:getProjectName()}</form:option>
			  </form:select>
			</div>
		</div>
	<%-- 	 <div class="control-group">
			<label class="control-label" for="href">文件上传后的路径:</label>
			<div class="controls"><value="${clinetversion.versionSrc}"
			 <form:input path="versionSrc" readonly="true"/>
			</div>
		</div>  --%>
		 <div class="control-group">
			<label class="control-label" for="href">文件上传:</label>
			<div class="controls">
			 <input name="file" type="file" >
			</div>
		</div> 
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:Clinetversion:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>