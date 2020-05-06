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
			getHospital();
		});
   function getHospital(){
	var url="${ctxsys}/EbPresentController/getzp";
	$.getJSON(url,function(data){callbackfunHospital(data);});
	}
	function callbackfunHospital(jsonObj){
	var EbProductlist=jsonObj.EbProductlist;
	var str="<option value=''>-选择赠品-</option>";
	var a=$("#zproductId").val();
	if(EbProductlist!=undefined){
		$.each(EbProductlist,function(i,pro){
		if(a==pro.productId){
		str+="<option value='"+pro.productId+"'  selected='selected'>"+pro.productName+"</option>";
		}else{
		str+="<option value='"+pro.productId+"'>"+pro.productName+"</option>";
		}
		});
	}
	$("#zproductId").html(str);
}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbPresentController/list?productid=${productId}">商品属性列表</a></li>
		<shiro:hasPermission name="merchandise:pro:edit"><li class="active"><a href="${ctxsys}/EbPresentController/form">商品属性添加</a></li></shiro:hasPermission>
	</ul></ul><br/>
	<form:form id="inputForm" modelAttribute="ebPresent" action="${ctxsys}/EbPresentController/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="productId" value="${productId}"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">选择赠品:</label>
			<div class="controls">
			<form:select path="zpproductId" id="zproductId" htmlEscape="false">
			<form:option value="${ebPresent.zpproductId}">${ebPresent.presentName}</form:option>
			</form:select>
			<span></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">数量:</label>
			<div class="controls">
				<form:input path="presentMun" htmlEscape="false" maxlength="200" />
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