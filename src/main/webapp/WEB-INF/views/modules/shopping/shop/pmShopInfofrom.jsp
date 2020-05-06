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
		<li ><a href="${ctxsys}/PmShopInfo">商户信息</a></li>
		<li class="active"><a href="${ctxsys}/PmShopInfo/form"  >商户<shiro:hasPermission name="merchandise:PmShopInfo:edit">${not empty pmShopInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:PmShopInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmShopInfo" enctype="multipart/form-data" action="${ctxsys}/PmShopInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">商家代码:</label>
			<div class="controls">
			<form:input path="shopCode" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邀请人:</label>
			<div class="controls">
			 <form:input path="recommendMobile" readonly="true"/> 
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司名:</label>
			<div class="controls">
			<form:input path="companyName" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业执照:</label>
			<div class="controls">
			<a>下载</a>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业地址:</label>
			<div class="controls">
			 <form:input path="contactAddress" readonly="true"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" for="href">法人代表:</label>
			<div class="controls">
			 <form:input path="legalPerson" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">注册资金:</label>
			<div class="controls">
			 <form:input path="capital" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">营业执照有限期:</label>
			<div class="controls">
			  <input class="small" type="text" style=" width: 100px;" name="businessStartTime" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${pmShopInfo.businessStartTime}" placeholder="请输入开始时间"/>
			       --<input class="small" type="text" name="businessEndTime" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style=" width: 100px;" value="${pmShopInfo.businessEndTime}" placeholder="请输入结束时间"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">公司官网:</label>
			<div class="controls">
			 <form:input path="officialUrl" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">电话号码:</label>
			<div class="controls">
			 <form:input path="customerPhone" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">传真号码:</label>
			<div class="controls">
			 <form:input path="fax" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">营业执照经营范围:</label>
			<div class="controls">
			 <form:textarea path="licenseAppScope" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">联系人:</label>
			<div class="controls">
			 <form:input path="contactName" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">联系手机:</label>
			<div class="controls">
			 <form:input path="mobilePhone" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">电子邮箱:</label>
			<div class="controls">
			 <form:input path="email" email="required email"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" for="href">备注:</label>
			<div class="controls">
			 <form:textarea path="describeInfo" required="required"/>
			</div>
		</div> 
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:PmShopInfo:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>