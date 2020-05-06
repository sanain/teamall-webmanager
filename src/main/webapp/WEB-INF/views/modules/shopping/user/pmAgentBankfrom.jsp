<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>银行卡列表</title>
	<meta name="decorator" content="default"/>
	 <script src="${ctxStatic}/h5/js/card.js"></script>
	 <script src="${ctxStatic}/h5/js/bankCardCheck.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			// 身份证号码验证
			jQuery.validator.addMethod("isIdCardNo", function(value, element) {
			return this.optional(element) || idCardNoUtil.checkIdCardNo(value);
			}, "请正确输入您的身份证号码");
			
			// 银行卡号验证
			jQuery.validator.addMethod("isBankCardNo", function(value, element) {
			return this.optional(element) || luhmCheck(value);
			}, "请正确输入银行卡号");
			
			// 手机号码验证
			jQuery.validator.addMethod("isMobile", function(value, element) {
			var length = value.length;
			var mobile = /^1[34578]\d{9}$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
			}, "请正确填写您的手机号码");
			
			$("#inputForm").validate({
				 rules : {
					 phoneNum : {
				            required : true,
				            minlength : 11,
				            isMobile : true
				        },
			        idcard:{
						required:true,
						isIdCardNo:true
						  
						},
						account:{
						required:true,
						isBankCardNo:true
						  
						}
				    },
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				messages : {
					phoneNum : {
			            required : "请输入手机号",
			            minlength : "确认手机不能小于11个字符",
			            isMobile : "请正确填写您的手机号码"
			        },
			        idcard:{
			        	required:"请输入身份证号",
			        	isIdCardNo:"请输入正确的身份证号"
			        	}
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
		<li ><a href="${ctxsys}/pmAgentBank">银行卡列表</a></li>
		<li class="active"><a>银行卡${not empty pmAgentBank.id?'修改':'添加'}</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmAgentBank" action="${ctxsys}/pmAgentBank/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">开户名（持卡人）:</label>
			<div class="controls">
			<form:input path="accountName" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易银行账号 :</label>
			<div class="controls">
			 <form:input path="account" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" >银行名称（开户行）:</label>
			<div class="controls">
			 <form:input path="bankName" required="required"/>
			</div>
		</div> 
		 <div class="control-group">
			<label class="control-label" >开户地址:</label>
			<div class="controls">
			 <form:input path="districtName" />
			</div>
		</div><%-- 
		 <div class="control-group">
			<label class="control-label" >银行类型:</label>
			<div class="controls">
			<form:radiobutton path="bankType" htmlEscape="false" class="required"   value="0"  checked="checked" />银行卡
			 <form:radiobutton path="bankType" htmlEscape="false" class="required"  value="1" />支付宝 
			</div>
		</div> 
		
		 --%><div class="control-group">
			<label class="control-label" >开户国家:</label>
			<div class="controls">
			 <form:input path="countryName" />
			</div>
		</div> 
		
		 <div class="control-group">
			<label class="control-label" >银行预留手机号:</label>
			<div class="controls">
			 <form:input path="phoneNum" required="required"/>
			</div>
		</div> 
		
		 <div class="control-group">
			<label class="control-label" >所属支行:</label>
			<div class="controls">
			 <form:input path="subbranchName" />
			</div>
		</div> 
		
		 <div class="control-group">
			<label class="control-label" >身份证号:</label>
			<div class="controls">
			 <form:input path="idcard" maxlength="18" required="required"/>
			</div>
		</div> 
		
		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>