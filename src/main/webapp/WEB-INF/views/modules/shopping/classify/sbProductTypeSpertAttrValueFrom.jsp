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
<body style="height: 100%">
	 <ul class="nav nav-tabs">
	 <li ><a href="${ctxsys}/PmProductTypeSpertAttrValue/list?spertAttrId=${spertAttrId}">规格属性明细列表</a></li>
	 <li class="active"><a href="${ctxsys}/PmProductTypeSpertAttrValue/from?spertAttrId=${spertAttrId}">规格属性<shiro:hasPermission name="merchandise:PmProductTypeSpertAttrValue:edit">${not empty sbProductTypeSpertAttrValue.id?'修改':'添加'}
	 </shiro:hasPermission><shiro:lacksPermission name="merchandise:PmProductTypeSpertAttrValue:view">查看</shiro:lacksPermission></a></li>
	</ul><br/> 
	
	<form:form id="inputForm" modelAttribute="sbProductTypeSpertAttrValue" action="${ctxsys}/PmProductTypeSpertAttrValue/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="name">类别名称:</label>
			<form:hidden path="spertAttrId"/>
			<div class="controls">
				<input  readonly="true" class="required" value="${sbProductTypeSpertAttr.spertAttrName}"  class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">图片:</label>
			<div class="controls">
			<form:hidden path="spertUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="spertUrl"  style="color: blue;"></span>
				<tags:ckfinder input="spertUrl" type="images" uploadPath="/merchandise/PmProductTypeSpertAttrValue"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">排序:</label>
			  <div class="controls">
				 <form:input path="orderNo" htmlEscape="false" maxlength="50" class="required digits"/>
			  </div>
		 </div>
		 <div class="control-group">
			<label class="control-label" for="isShow">属性/规格名称:</label>
			  <div class="controls">
				 <form:input path="spertAttrValue" htmlEscape="false" maxlength="50" required="required"/>
			  </div>
		 </div>
		<div class="control-group">
			<label class="control-label">标准值:</label>
			<div class="controls">
			${sbProductTypeSpertAttrValue.shopName}
			</div>
		</div>
		<div class="form-actions">
		      <%--  <shiro:hasPermission name="merchandise:PmProductTypeSpertAttrValue:edit"> --%>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<%-- </shiro:hasPermission> --%>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>