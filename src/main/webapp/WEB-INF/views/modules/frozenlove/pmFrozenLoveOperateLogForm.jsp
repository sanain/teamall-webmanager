<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		
		 jQuery.validator.addMethod("love", function(value, element) {
		 return love();
		 }, "如果冻结数量类型为比例请输入0-100正整数，其他请输入大于等于0.0001");
		 jQuery.validator.addMethod("mobiles", function(value, element) {
			 return ismonth(value);}, "有其他特殊符号");
		$("#inputForm").validate({
			
			rules: {
				mobiles:{
					required:true,
					mobiles:true
					},
					frozenLove:{
						love:true
					},
			},
			messages: {
				supplierPrice: {remote: "采购价格必须为合法数字(正数，最多两位小数)"},
			},
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
		var frozenTypeval=0;
		$("#frozenType").change(function(){
			var val=$("#frozenType").val();
			frozenTypeval=val;
			if(val==3){
				$("#dstartDate").css("display","");
				$("#dendDate").css("display","");
			}else{
				$("#dstartDate").css("display","none");
				$("#dendDate").css("display","none");
			}
			if(val==4){
				$("#loveNum").html("冻结比例（%）:");
			}else{
				$("#loveNum").html("冻结数 :");
			}
				
			if(val==1){
				$("#frozenLovegroup").css("display","none");
			}else{
				$("#frozenLovegroup").css("display","");
			}
				
		});
		
		
	});
	function ismonth(str){
		for(ilen=0;ilen<str.length;ilen++)
		{
		if(str.charAt(ilen) < '0' || str.charAt(ilen) > '9' )
		{
		if((str.charAt(ilen)!=','))
		return false;
		} 
		}
	  return true;
	}

	function DateMinus(sDate,eDate){ 
		　　var sdate = new Date(sDate.replace(/-/g, "/")); 
		　　var edate = new Date(eDate.replace(/-/g, "/")); 
		　　var day =edate.getTime() - sdate.getTime(); 
		　　return day; 
		}
	
		function sshowAdd(){
			var val=$("#frozenType").val();
			if(val==3){
				if($("#startDate").val()==""){
					return false;
				}else{
					if($("#endDate").val()!=""){
						if(DateMinus($("#startDate").val(),$("#endDate").val())<0){
						return false;
						}
					}
				}
			}else if(val==5){
			}
			return true;
		}
		function eshowAdd(){
			var val=$("#frozenType").val();
			if(val==3){
				if($("#endDate").val()==""){
					return false;
				}else{
					if($("#startDate").val()!=""){
						if(DateMinus($("#startDate").val(),$("#endDate").val())<0){
						return false;
						}
					}
				}
			}else if(val==5){
			}
			return true;
		}
		function love(){
			var val=$("#frozenType").val();
			if(val==4){
				if($("#frozenLove").val()==""||$("#frozenLove").val()==""){
					return false;
				}
				if($("#frozenLove").val()<0||$("#frozenLove").val()>100){
					return false;
				}
				
				var reg = /^[1-9]\d*$/;
				return reg.test($("#frozenLove").val());
			}
			if(val==2){
				if($("#frozenLove").val()==""||$("#frozenLove").val()<0.0001){
					return false;
				}
			}
			return true;
		}
		function timeChoose(val){
			if(val==""){
	 			return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/frozenLoveOperateLog">操作记录列表</a></li>
		<li class="active"><a href="form?frozenType=1">操作记录${not empty pmFrozenLoveOperateLog.id?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="pmFrozenLoveOperateLog" action="${ctxsys}/frozenLoveOperateLog/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="mobiles">手机号:</label>
			<div class="controls">
				<form:textarea path="mobiles" htmlEscape="false" rows="5" maxlength="100000" class="input-xxlarge" />
				<span class="help-inline"><font color="red">*</font>手机号之间以逗号“,”隔开</span>
			</div>
		</div>	
		
		<div class="control-group">
			<label class="control-label" for="receiverType">冻结数量类型:</label>
			<div class="controls">
				<form:select path="frozenType" class="input">
					<form:option value="1" label="所有当前数"/>
					<form:option value="2" label="指定数"/>
					<form:option value="4" label="指定当前比例"/>
				</form:select>
			</div>
		</div>
		
		<div class="control-group" id="frozenLovegroup" style="display:${pmFrozenLoveOperateLog.frozenType!=1?'':'none' }">
			<label class="control-label" for="frozenLove" id="loveNum">${pmFrozenLoveOperateLog.frozenType!=4?'冻结数':'冻结比例（%）' } :</label>
			<div class="controls">
				<form:input path="frozenLove"  type="number" htmlEscape="false" class="input-xxlarge" style="width: 250px;" />
			</div>
		</div>	
		
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="1000" class="input-xxlarge" />
			</div>
		</div>	
		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>