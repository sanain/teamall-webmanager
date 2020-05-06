<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>积分支付配置</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		
		 jQuery.validator.addMethod("payMax", function(value, element) {
		 return payMax();}, "金额上线占比不能小于下线");
		 jQuery.validator.addMethod("timeChoose", function(value, element) {
		 return timeChoose();}, "结束时间不能小于开始时间");
		$("#inputForm").validate({
			
			rules: {
				lovePayMinRatio:{
					required:true,
					range:[0,100]
					},
				lovePayMaxRatio:{
					required:true,
					payMax:true,
					range:[0,100]
					},
				lovePayEndDate: {
					timeChoose:true
				},
			
			
			},
			messages: {
				lovePayMinRatio: {remote: "必须为合法数字(正数，0-100)"},
				lovePayMaxRatio: {remote: "必须为合法数字(正数，0-100)"},
			},
			submitHandler: function(form){
				if(showAdd()){
					loading('正在提交，请稍等...');
					form.submit();
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
		
		$("#lovePayEffectType2").change(function(){
			$("#lovePayStartDate").attr("class","required valid");
			$("#lovePayEndDate").attr("class","required valid");
		});
		$("#lovePayEffectType1").change(function(){
			$("#lovePayStartDate").attr("class","small");
			$("#lovePayEndDate").attr("class","small");
		});
		
	});
		function timeChoose(){
			console.log($("#lovePayEffectType1").attr("checked"))
			var lf=$("#lovePayEffectType2").attr("checked")==undefined?"":"checked";
			if(lf=="checked"){
				if($("#lovePayStartDate").val() != "" &&$("#lovePayEndDate").val() !=""){
				   if($("#lovePayStartDate").val()<$("#lovePayEndDate").val()){
				      	//layer.alert("开始时间不能大于结束时间！"); 
				 	    return true;
				   }else{
						return false;
					}
				}else{
					return false;
				}
			}else{
				return true;
			}
			return false;
		}
		function payMax(){
			var min=$("#lovePayMinRatio").val();
			var max=$("#lovePayMaxRatio").val();
			if(parseInt(min)<parseInt(max)){
			return true;
			}
			return false;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/pmLovePayDeploy/list">支付配置列表</a></li>
		<li class="active"><a href="form">支付配置${not empty pmLovePayDeploy.id?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="pmLovePayDeploy" action="${ctxsys}/pmLovePayDeploy/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="messageClass">名称:</label>
			<div class="controls">
			<form:input path="lovePayName" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="lovePayEffectType">生效类型:</label>
			<div class="controls">
				<form:radiobutton path="lovePayEffectType" htmlEscape="false" class="required"  value="1" />默认
				<form:radiobutton path="lovePayEffectType" htmlEscape="false" class="required"   value="2" />时间区间
			</div>
		</div>	
		
		<div class="control-group">
			<label class="control-label">生效开始时间:</label>
			<div class="controls">
			<input class="small" type="text" class="input-medium" name="lovePayStartDate" id="lovePayStartDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${pmLovePayDeploy.lovePayStartDate}" placeholder="请选择时间"/>
			</div>
		</div> 
		
		<div class="control-group">
			<label class="control-label">生效结束时间:</label>
			<div class="controls">
			<input class="small" type="text" class="input-medium" name="lovePayEndDate" id="lovePayEndDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${pmLovePayDeploy.lovePayEndDate}" placeholder="请选择时间"/>
			</div>
		</div> 
		
		<div class="control-group">
			<label class="control-label" for="lovePayMinRatio">金额下线占比(%):</label>
			<div class="controls">
			<form:input path="lovePayMinRatio" type="number" htmlEscape="false" class="required input-large" style="width: 250px;" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="lovePayMaxRatio">金额上线占比(%):</label>
			<div class="controls">
			<form:input path="lovePayMaxRatio" type="number" htmlEscape="false" class="required input-large" style="width: 250px;" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		
		
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false"  class="input-xxlarge" style="width: 560px;height: 130px;" />
			</div>
		</div>
		
		
		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>