<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/bounced/css/xcConfirm.css"/>
		<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/bounced/js/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/bounced/js/xcConfirm.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
	function btin(){
			var model= $("#model").val();
			  $.ajax({
			     url: '${ctxsys}/User/ralue',
			     type: 'POST',
			     cache: false,
			     data: {"model":model},
			     success: function (data){
			         if(data=='00'){
			          $("#inputForm").submit();
			          return true;  
			            }else{
			            	var txt="未找手机号为  <span style='color:red'>"+model+"</span>  用户！";
					       window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					       return false;  
			            }
			        }
			     });
			 }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbIndianarecord/list?objectId=${objectId}">夺宝记录列表</a></li>
		<shiro:hasPermission name="merchandise:sales:edit"><li class="active"><a href="${ctxsys}/EbIndianarecord/form">添加夺宝记录</a></li></shiro:hasPermission>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ebIndianarecord"  action="${ctxsys}/EbIndianarecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="objectId"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="href">用户手机:</label>
			<div class="controls">
			<input type="text" name="userName" id="model" onblur="modelr()">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">投入金额:</label>
			<div class="controls">
			<input type="text" name="money" id="money" value="1">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">选择支付方式:</label>
			<div class="controls">
			<select name="payType" >
			        <option value="3">微信</option>
			        <option value="2">支付宝</option>
					<option value="1">银联</option>
			</select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:sales:edit">
				<input id="bt" onclick="btin()" class="btn btn-primary" type="button" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>