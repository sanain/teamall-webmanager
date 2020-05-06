<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告类型</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#adtypename").focus();
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
			$("#btnSubmit").click(function(){
					$("#inputForm").submit();
			});
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/news/advertiseType/list">广告类型列表</a></li>
		<li class="active"><a href="#">广告类型${not empty advertiseType.adtypeid?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="advertiseType" action="${ctxsys}/news/advertiseType/save" method="post" class="form-horizontal">
		<form:hidden path="adtypeid"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="adtypename">广告类型名称:</label>
			<div class="controls">
				<form:input path="adtypename" htmlEscape="false" maxlength="100"  class="required input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adtypetag">标签:</label>
			<div class="controls">
				<form:input path="adtypetag" htmlEscape="false" maxlength="100"  class="input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adtypeonlynum">唯一码:</label>
			<div class="controls">
				<form:input path="adtypeonlynum" htmlEscape="false" maxlength="6"   class="digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="imgmemo">图片尺寸说明:</label>
			<div class="controls">
				<form:input path="imgmemo" htmlEscape="false" maxlength="100"  class="input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="memo">广告说明:</label>
			<div class="controls">
				<form:input path="memo" htmlEscape="false" maxlength="500"  class="input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adtypeflag">是否显示:</label>
			<div class="controls">
				<form:radiobutton path="adtypeflag" htmlEscape="false" class="required"  value="1"  checked="checked" />显示
				<form:radiobutton path="adtypeflag" htmlEscape="false" class="required"   value="0" />不显示
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="news:advertiseType:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>