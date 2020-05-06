<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
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
	</ul></ul><br/>
	<form:form id="inputForm" modelAttribute="ebProperty" action="${ctxsys}/EbProperty/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="commoditytrialId" value="${commoditytrialId}"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="parent.id" value="${ebProperty.parent.id}" labelName="parent.propertyName" labelValue="${ebProperty.parent.propertyName}"
					title="菜单" url="" extId="${menu.id}" productId="${productId}" cssClass="required"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">名称:</label>
			<div class="controls">
				<form:input path="propertyName" htmlEscape="false" maxlength="50"   readonly= "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">属性图片:</label>
			<div class="controls">
			<form:hidden path="propertyImages" htmlEscape="false" maxlength="100"  class="input-xlarge"  readonly="readonly"/>
				<span class="help-inline" id="propertyImages"  style="color: blue;"></span>
				<tags:ckfinder input="propertyImages" type="images" uploadPath="/merchandise/EbProperty"/>
			</div>
			<div class="control-group">
			<label class="control-label" for="name">折后价格:</label>
			<div class="controls">
				<form:input path="propertyPrice" htmlEscape="false" maxlength="50"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">商品原价格:</label>
			<div class="controls">
				<form:input path="propertyYprice" htmlEscape="false" maxlength="50" readonly= "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">下级标题:</label>
			<div class="controls">
				<form:input path="nextTitle" htmlEscape="false" maxlength="50" readonly= "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">菜单:</label>
			<div class="controls">
				<form:select path="propertyTow" readonly= "true">
				<form:option value="0">一级</form:option>
				<form:option value="1">二级</form:option>
				<form:option value="2">三级</form:option>
				</form:select>
				<span>*一级，规格  二级是颜色，三级是尺寸，必须对应</span>
			</div>
		</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:pro:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>