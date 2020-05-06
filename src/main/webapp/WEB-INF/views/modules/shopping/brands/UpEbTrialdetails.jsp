<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核</title>
		<style type="text/css">
			li{ list-style-type: none;}
			/* input{ readonly:true;} */
		</style>
	<meta name="decorator" content="default"/>
	<script type="text/javascript"></script>
</head>
<body>
<%--  	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/EbTrialdetails/list">试用列表</a></li>
	    <shiro:hasPermission name="merchandise:audit:edit"><li class="active"><a href="${ctxsys}/EbTrialdetails/form?id=${EbTrialdetails.productId}">修改</a></li></shiro:hasPermission>
	</ul>  --%>
	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbTrialdetails/form?id=${EbTrialdetails.trialdetailsId}">审核</a></li>
	</ul>
	<div class="content_box">
	<div class="content form_content">
	<tags:message content="${message}"/>
	<form:form id="inputForm"  modelAttribute="EbTrialdetails" action="${ctxsys}/EbTrialdetails/upebTrialdetails" enctype="multipart/form-data" method="post" class="form-horizontal">
			<form:hidden path="trialdetailsId"/>
				<div class="control-group">
					<label class="control-label">商品ID：</label>
					<div class="controls">
		            <form:input readonly="true" path="productId" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商品编号：</label>
					<div class="controls">
		            <form:input readonly="true" path="productNo" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商品名：</label>
					<div class="controls">
		            <form:input readonly="true" path="productName" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">押金：</label>
					<div class="controls">
		            <form:input readonly="true" path="deposit" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商品数量：</label>
					<div class="controls">
		            <form:input readonly="true" path="nums" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">优惠商品ID：</label>
					<div class="controls">
		            <form:input readonly="true" path="commoditytrialId" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">用户名：</label>
					<div class="controls">
		            <form:input readonly="true" path="userName" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">用户性别：</label>
					<div class="controls">
		            <form:input readonly="true" path="userSex" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">用户手机：</label>
					<div class="controls">
		            <form:input readonly="true" path="userMobile" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">用户身份证：</label>
					<div class="controls">
		            <form:input readonly="true" path="userIdcard" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">用户ID：</label>
					<div class="controls">
		            <form:input readonly="true" path="userId" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">订单号：</label>
					<div class="controls">
		            <form:input readonly="true" path="orderId" htmlEscape="false" maxlength="50" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
				<label class="control-label">阅读：</label>
					<div class="controls">
					<form:select path="isSend"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
			           <option value="">是否有写申请报告</option>  
	                   <form:option value="0">写了</form:option>  
	                   <form:option value="1">没写</form:option>
               		</form:select> 
               		</div>
				</div>
				
				<div class="control-group">
				<label class="control-label">报告内容：</label>
					<div class="controls">
						<form:textarea readonly="true" path="trialreport" htmlEscape="false" maxlength="200" class="required"/>
					</div>
				</div>
				
				<div class="control-group">
				<label class="control-label">审核：</label>
					<div class="controls">
					<form:select path="status"  htmlEscape="false" maxlength="50" style="width: 100px;" class="control-group">
			           <option value="" >请审核</option>  
	                   <form:option value="0">通过</form:option>  
	                   <form:option value="1">未通过</form:option>
               		</form:select> 
               		</div>
				</div>
				
			<table class="form_table">
				<col width="150px" />
				<col />
				<tr>
				<td></td>
				<td><shiro:hasPermission name="merchandise:audit:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission><input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/></td>
				</tr>
			</table>
	</form:form>
	</div>
</div>
</body>
</html>