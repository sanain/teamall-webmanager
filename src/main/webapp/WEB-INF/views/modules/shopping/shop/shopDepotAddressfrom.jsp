<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
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
		<li><a href="${ctxsys}/PmShopInfo">商户信息</a></li>
		<li><a href="${ctxsys}/PmShopInfo/shopDepotAddress?shopid=${shopid}">商户仓库地址</a></li>
		<li class="active"><a href="${ctxsys}/PmShopInfo/shopDepotAddressfrom?shopid=${shopid}&id=${id}">商户仓库地址详情</a></li>
		<%-- <li class="active"><a href="javascript:;">商户仓库地址详情</a></li> --%>
	</ul>
	<form:form id="inputForm" modelAttribute="shopDepotAddress" enctype="multipart/form-data" action="${ctxsys}/PmShopInfo/shopDepotAddressSave?shopid=${shopid}" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">是否默认:</label>
			<div class="controls">
			<c:if test="${shopDepotAddress.isDefault==0}">不默认</c:if>
			<c:if test="${shopDepotAddress.isDefault==1}">默认</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货人姓名:</label>
			<div class="controls">
			<form:input path="contactName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码:</label>
			<div class="controls">
			 <form:input path="phoneNumber" readonly="true"/> 
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话号码:</label>
			<div class="controls">
			<form:input path="telephoneNumber" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮政编码:</label>
			<div class="controls">
			 <form:input path="zipCode" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">国家:</label>
			<div class="controls">
			 <form:input path="countryName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">省:</label>
			<div class="controls">
			 <form:input path="provinceName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">市:</label>
			<div class="controls">
			 <form:input path="cityName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区:</label>
			<div class="controls">
			 <form:input path="areaName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">街道地址:</label>
			<div class="controls">
			 <form:textarea path="detailAddress" readonly="true"/>
			</div>
		</div> 
		<div class="control-group">
			<label class="control-label" for="href">创建时间:</label>
			<div class="controls">
			  <form:input path="createTime" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">创建人:</label>
			<div class="controls">
			  <form:input path="createUser" readonly="true"/>
			</div>
		</div>
		<c:if test="${!empty shopDepotAddress.modifyTime}">
		<div class="control-group">
			<label class="control-label" for="href">修改时间:</label>
			<div class="controls">
			  <form:input path="modifyUser" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">修改人:</label>
			<div class="controls">
			  <form:input path="modifyTime" readonly="true"/>
			</div>
		</div>
		</c:if>
		<c:if test="${!empty shopDepotAddress.verifyTime}">
		<div class="control-group">
			<label class="control-label">审核状态:</label>
			<div class="controls">
			<c:if test="${shopDepotAddress.isDefault==2}">审核通过</c:if>
			<c:if test="${shopDepotAddress.isDefault==3}">审核不通过</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">审核时间:</label>
			<div class="controls">
			  <form:input path="verifyTime" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">审核人:</label>
			<div class="controls">
			  <form:input path="verifyUser" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">审核备注:</label>
			<div class="controls">
			 <form:textarea path="verifyRemar" readonly="true"/>
			</div>
		</div>
		</c:if>
		<c:if test="${empty shopDepotAddress.verifyTime}">
		<div class="control-group">
			<label class="control-label" for="href">审核:</label>
			<div class="controls">
			   <form:select path="verifyStatus" required="required">
		         <form:option value="">--请选择--</form:option>
		         <form:option value="2">审核通过</form:option>
		         <form:option value="3">审核不通过</form:option>
		       </form:select>
		    </div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">审核备注:</label>
			<div class="controls">
			 <form:textarea path="verifyRemar"/>
			</div>
		</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmShopInfo:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>