<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		var f="${f}";
		if(f==1){
		}else{
	    	var frame = window.parent.document.getElementById("left"); 
		    var path = frame.getAttribute("src"); 
		          frame.setAttribute("src", path); 
		}
		 jQuery.validator.addMethod("love", function(value, element) {
			 return love();
			 }, "名称重复，请重新输入");
			$("#inputForm").validate({
				rules: {
					productTypeName:{
						required:true,
						love:true,
						},
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				messages: {
					productTypeName: {remote: "名称重复，请重新输入"},
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
		function love(){
			var f=false;
			$.ajax({
				type: "POST",
				 async: false,
				url: "${ctxsys}/PmProductType/checkName?id=${sbProductType.id}&parentId="+$("#menuId").val()+"&productTypeName="+$("#productTypeName").val()+"",
				success: function(data){
					if(data==false){
						f= false;
					}else{
						f= true;
					}
				  }
				});
			return f;
		}
		function del(id){
			return confirmx('确认要删除吗？', "${ctxsys}/PmProductType/delete?id="+ id+"");
		}
		
	</script>
</head>
<body style="height: 100%">
	 <ul class="nav nav-tabs">
		<li <c:if test="${not empty sbProductType.id}"> class="active"</c:if> ><a href="${ctxsys}/PmProductType/form?ys=1">分类<shiro:hasPermission name="merchandise:PmProductType:edit">修改</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmProductType:edit">查看</shiro:lacksPermission></a></li>
		<li <c:if test="${empty sbProductType.id}"> class="active"</c:if> ><a href="${ctxsys}/PmProductType/form">分类<shiro:hasPermission name="merchandise:PmProductType:edit">添加</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmProductType:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/> 
	<form:form id="inputForm" modelAttribute="sbProductType" action="${ctxsys}/PmProductType/savetype" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="parentId" value="${sbProductType.parentId}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}"
					title="菜单" url="${ctxsys}/PmProductType/treeData" extId="${menu.id}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">名称:</label>
			<div class="controls">
				<form:input path="productTypeName" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">商品分类图片:</label>
			<div class="controls">
			<form:hidden path="productTypeLogo" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="productTypeLogo"  style="color: blue;"></span>
				<tags:ckfinder input="productTypeLogo" type="images" uploadPath="/merchandise/category"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">关键词:</label>
			<div class="controls">
				<form:input path="typeKeyword" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">排序:</label>
			<div class="controls">
				<form:input path="orderNo" htmlEscape="false" maxlength="50" class="required digits"/>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">是否前端展示:</label>
			<div class="controls">
			   <form:radiobutton path="isShowFront" value="0" checked="true"/>不开放
               <form:radiobutton path="isShowFront" value="1"/>开放
			</div>
		</div>
		<input name="isfshow" id="isfshow" type="hidden" value="${sbProductType.isShowFront}"/>
		<div class="control-group">
			<label class="control-label" for="isShow">是否开放商家:</label>
			<div class="controls">
				  <form:radiobutton path="isShowShop" value="0" checked="true"/>不开放
                  <form:radiobutton path="isShowShop" value="1"/>开放
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">是否共用:</label>
			<div class="controls">
				  <form:radiobutton path="isPublic" value="0" checked="true"/>平台使用
                  <form:radiobutton path="isPublic" value="1"/>商家使用
                  <form:radiobutton path="isPublic" value="2"/>平台和商家共用
			</div>
		</div>

		<c:if test="${sbProductType.id != null}">
			<div class="control-group">
				<label class="control-label" for="isPublic">来源:</label>
				<div class="controls">
					<input type="text" readonly="readonly" value="${sbProductType.shopName != null && !"".equals(sbProductType.shopName) ? sbProductType.shopName : '平台'}" htmlEscape="false" maxlength="50" />
				</div>
			</div>
		</c:if>
		<%-- <div class="control-group">
			<label class="control-label" for="isShow">费率:</label>
			<div class="controls">
				<form:input path="rate" htmlEscape="false" maxlength="50" class="required digits"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label" for="isShow">备注:</label>
			<div class="controls">
				<form:textarea path="describeInfo" htmlEscape="false" maxlength="50" />
			</div>
		</div>
		<div class="form-actions">
		        <shiro:hasPermission name="merchandise:PmProductType:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="删除" onclick="del(${sbProductType.id})"/>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>