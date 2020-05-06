<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务明细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		
		 jQuery.validator.addMethod("userid", function(value, element) {
		 return showAdd();
		 }, "请选择用户");
		 jQuery.validator.addMethod("timeChoose", function(value, element) {
			 return timeChoose();}, "请选择时间发送时间");
		$("#inputForm").validate({
			
			rules: {
				wid:{
					userid:true
					},
				sendTime: {
					timeChoose:true
					},
				supplierPrice: {
					required:true,
					maxlength:"50",
					remote: {
						url:"${ctxsys}/bsky/product/checkPrice",
						data: {
							
						},
						type:"post"
					}
				},
			
			
			},
			messages: {
				supplierPrice: {remote: "采购价格必须为合法数字(正数，最多两位小数)"},
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
		
		showChoose();
		$("#receiverType").change(function(){
			var val=$("#receiverType").val();
			$("#wName").val("");
			$("#wId").val("");
			if(val==5){
				$("#sel").css("display","");
				$(".jbox-title").html("xxx");
				$("#wurl").val("${ctxsys}/sys/agent/treeData1?type=2&isAgent=1")
			}else if(val==4){
				$("#sel").css("display","");
				$(".jbox-title").html("xxx");
				$("#wurl").val("${ctxsys}/message/userInfoTreeData?usertype=1")
			}else if(val==7){
                $("#sel").css("display","");
                $(".jbox-title").html("xxx");
                $("#wurl").val("${ctxsys}/message/shopInfoTreeData?shoptype=1")
			}else{
				$("#sel").css("display","none");
			}
		});
		
		
	});
		function showChoose(){
			var rt=$("#receiverType").val();
				$("#sel").css("display","none");
			if(rt==5){
				$("#sel").css("display","");
				$("#wurl").val("${ctxsys}/sys/agent/treeData1?type=2&isAgent=1")
			}else if(rt==4){
				$("#sel").css("display","");
				$("#wurl").val("${ctxsys}/message/userInfoTreeData?usertype=1")
			}
		}
		function showAdd(){
			var ids=$("#wId").val();
			$("#userid").val(ids);
			var receiverType=$("#receiverType").val();
			if(receiverType==4){
				if(ids==""){
					alert("请选择用户！");
					return false;
				}
			}else if(receiverType==5){
				if(ids==""){
					alert("请选择代理！");
					return false;
				}
			}
			return true;
		}
		function timeChoose(){
			var lf=$("#isTimingSend1").attr("checked")==undefined?"":"checked";
			if(lf=="checked"){
				if($("#sendTime").val() == "" ){
						return false;
				}else{
					return true;
				}
			}else{
				return true;
			}
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/message/list">消息列表</a></li>
		<li class="active"><a href="form">消息<%-- <shiro:hasPermission name="bsky:product:edit"> --%>${not empty messageInfo.id?'修改':'添加'}<%-- </shiro:hasPermission><shiro:lacksPermission name="bsky:product:edit">查看</shiro:lacksPermission> --%></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="messageInfo" action="${ctxsys}/message/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="sendUserIds" id="userid"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="messageClass">消息分类:</label>
			<div class="controls">
			<form:select id="messageClass" path="messageClass" class="input-medium">
                <form:options items="${fns:getDictList('messageClass')}" itemLabel="label" itemValue="value" htmlEscape="false" /></form:select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageTitle">标题 :</label>
			<div class="controls">
				<form:input path="messageTitle" htmlEscape="false" class="required input-xxlarge" style="width: 250px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageAbstract">简述:</label>
			<div class="controls">
				<form:textarea path="messageAbstract" htmlEscape="false"  class="required input-xxlarge" style="width: 560px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageContent">内容:</label>
			<div class="controls">
				<form:textarea path="messageContent" htmlEscape="false"  class="required input-xxlarge" style="width: 560px;height: 130px;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="messageType">消息类型:</label>
			<div class="controls">
				<form:select id="messageType" path="messageType" class="input-medium">
					<form:options items="${fns:getDictList('messageType')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="messageIcon">消息图标:</label>
			<div class="controls">
				<form:hidden path="messageIcon" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<tags:ckfinder input="messageIcon" type="images" uploadPath="/message/messageIcon"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="receiverType">发送类型:</label>
			<div class="controls">
				<form:select path="receiverType" class="input">
					<form:option value="0" label="--请选择--"/>
					<form:option value="1" label="所有用户"/>
					<form:option value="2" label="所有门店"/>
					<%--<form:option value="3" label="所有买家"/>--%>
					<form:option value="4" label="指定用户"/>
					<%--<form:option value="5" label="指定代理"/>--%>
					<%--<form:option value="6" label="所有代理"/>--%>
					<form:option value="7" label="指定门店"/>
				</form:select>
			
			<span id="sel"><a ><tags:treeselect id="w" name="" value="" checked="true" allowClear="true" labelName="" labelValue="" 
						    title="" url="${ctxsys}/sys/agent/treeData1?type=2&isAgent=1" /></a></span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="isTimingSend" >是否定时发送:</label>
			<div class="controls">
				<form:radiobutton path="isTimingSend" htmlEscape="false" class="required" onclick="TimingSend(this.value)"  value="1" />是
				<form:radiobutton path="isTimingSend" htmlEscape="false" class="required"  onclick="TimingSend(this.value)"   value="0" />否
			</div>
		</div>	
		
		<div class="control-group" id="timesvte">
			<label class="control-label">发送时间:</label>
			<div class="controls">
			<input class="small" type="text" class="input-medium" name="sendTime" id="sendTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${messageInfo.sendTime}" placeholder="请选择时间"/>
			</div>
		</div> 
		
		<div class="form-actions">
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<%-- </shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
	function TimingSend(id){
	  if(id=='1'){
	    $("#timesvte").show();
	   }else{
	    $("#timesvte").hide();
	   }
	}
	$(document).ready(function() {
	 var ydua="${messageInfo.isTimingSend}";
	 if(ydua=='1'){
	    $("#timesvte").show();
	   }else{
	    $("#timesvte").hide();
	   }
	})
	</script>
</body>
</html>