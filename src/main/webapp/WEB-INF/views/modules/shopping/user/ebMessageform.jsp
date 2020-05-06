<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
			$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
			 rules:{
                    myname:{
                        required:true
                    },
                    email:{
                        required:true,
                        email:true
                    },
                    password:{
                        required:true,
                        rangelength:[3,10]
                    },
                    confirm_password:{
                        equalTo:"#password"
                    }                    
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
		});
					});
	 	</script>
</head>
<body>
 
     <ul class="nav nav-tabs">
		<li><a href="${ctxsys}/ebMessage">消息列表</a></li>
	    <li class="active"><a href="${ctxsys}/ebMessage/form?id=${ebMessage.id}">消息<shiro:hasPermission name="merchandise:ebMessage:edit">${not empty ebProductcomment.commentId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:pcomment:view">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form  modelAttribute="ebMessage"  action="${ctxsys}/ebMessage/save" method="post" class="form-horizontal">
	 <form:hidden path="id"/>
	<tags:message content="${message}"/>
	 <form:hidden path="messageId"/>
	 <div class="control-group">
			<label class="control-label">消息分类:</label>
			<div class="controls">
			<form:select path="messageParent" >
			<form:option value="0">真心话消息</form:option>
			<form:option value="1">圈子消息</form:option>
			<form:option value="2">商场客服</form:option>
			<form:option value="3">活动精选</form:option>
			<form:option value="4">系统通知</form:option>
			</form:select>
		    <span class="help-inline"><font color="red">*注:</font> </span>
			</div>
	</div>
	<div class="control-group">
			<label class="control-label">消息标题:</label>
			<div class="controls">
			<form:input path="messageTitle"/>
			</div>
	</div>
	<div class="control-group">
			<label class="control-label">消息创建时间:</label>
			<div class="controls">
			<input class="small"   name="messageCreationdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebMessage.messageCreationdate}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			<span class="help-inline"><font color="red"></font> </span>
			</div>
	</div>
			
	<div class="control-group">
			<label class="control-label">消息发送时间:</label>
			<div class="controls">
			<input class="small"   name="messageTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebMessage.messageTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss' />" >  
			<span class="help-inline"><font color="red">*注,为空表示立即发送:</font> </span>
			</div>
	</div>
	<div class="control-group">
			<label class="control-label">用户姓名:</label>
			<div class="controls">
			<form:input path="sendpepoleName"/>
			<span class="help-inline"><font color="red">*注,为空则是全部用户发送:</font> </span>
			</div>
	</div>
		<div class="control-group">
			<label class="control-label">消息类型:</label>
			<div class="controls">
			<form:select path="messageType">
			<form:option value="1">系统消息</form:option>
			<form:option value="2">真心话消息</form:option>
			<form:option value="3">圈子消息</form:option>
			<form:option value="4">订单消息</form:option>
			<form:option value="5">物流消息</form:option>
			<form:option value="6">支付消息</form:option>
			</form:select>
			</div>
	</div>
   <div class="control-group">
			<label class="control-label">消息状态:</label>
			<div class="controls">
				<form:select path="messageState">
			<form:option value="1">已读</form:option>
			<form:option value="2">未读</form:option>
			<form:option value="3">隐藏</form:option>
			</form:select>
			</div>
	</div>
	<div class="control-group">
			<label class="control-label">消息状态:</label>
			<div class="controls">
				<select name="jumpType">
				  <option value="articleshow">文章详情</option>
				  <option value="goodsshow">商品详情</option>
				  <option value="outline">h5页面,或者活动页面</option>
				  <option value="msgcoreshow">消息中心 </option>
				  <option value="myordershow">我的订单详情 </option>
				  <option value="myorderlist">我的订单列表</option>
				  <option value="customshow">自定义消息</option>
				</select>
			</div>
	</div>
	
	<div class="control-group">
			<label class="control-label">消息内容:</label>
			<div class="controls">
			<form:textarea path="messageContent"/>
			</div>
	</div>
    <div class="control-group">
			<label class="control-label"></label>
			<div class="controls">
			<shiro:hasPermission name="merchandise:ebMessage:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission>
			<input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
	</div>	
	</form:form>

</body>
</html>