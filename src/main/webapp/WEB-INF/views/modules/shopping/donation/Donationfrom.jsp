<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
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
		    var favorableType=$("#favorableType").val();
		    if(favorableType=='6'){
		      $("#menuid").hide();
		      $("#detail").hide();
		    }
		     if(favorableType=='7'){
		      $("#menuid").hide();
		      $("#detail").hide();
		    }
		 });
			function ckce(favorableType){
			if(favorableType=='6'){
			      $("#menuid").hide();
			      $("#detail").hide();
			    }
			    if(favorableType=='7'){
			      $("#menuid").hide();
			      $("#detail").hide();
			    }
			}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbDonationController/list">活动列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li class="active"><a href="${ctxsys}/EbDonationController/form">活动添加</a></li></shiro:hasPermission>
	</ul></ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebDonation" action="${ctxsys}/EbDonationController/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group" id="menuid">
					<label class="control-label">所属分类：</label>
					<div class="controls">
		            <tags:treeselect id="menu" name="categoryId" value="${ebDonation.categoryId}" labelName="categoryName" labelValue="${ebDonation.categoryName}"
					title="菜单" url="${ctxsys}/EbProCategory/treeData" extId="" cssClass="required"/>
					</div>
				</div>
		<div class="control-group">
			<label class="control-label">活动名称:</label>
			<div class="controls">
			<form:input path="activityName" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">活动类型:</label>
			<div class="controls">
			<form:select path="favorableType" id="favorableType" onchange="ckce(this.value)">
			<form:option value="1">满减</form:option>
			<form:option value="2">满赠</form:option>
			<form:option value="3">满包邮</form:option>
			<form:option value="4">单品包邮</form:option>
			<form:option value="5">赠品</form:option>
			<form:option value="6">充值活动</form:option>
			<form:option value="7">ios内购充值</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">活动开始时间:</label>
			<div class="controls">
			<input class="small"  name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebDonation.startTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</div>
		</div>
	<div class="control-group">
			<label class="control-label" for="href">活动结束时间:</label>
			<div class="controls">
			<input class="small"  name="stopTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebDonation.stopTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="status">
			<form:option value="0">开启</form:option>
			<form:option value="1">关闭</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">是否只能用一次:</label>
			<div class="controls">
			<form:select path="isOnce">
			<form:option value="0">否</form:option>
			<form:option value="1">是</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group" id="sufficientMoney">
			<label class="control-label" for="href">充值金额:</label>
			<div class="controls">
			<form:input path="sufficientMoney"  htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group" id="giveMoney">
			<label class="control-label" for="href">送的澄币:</label>
			<div class="controls">
			<form:input path="giveMoney"  htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group" id="detail">
			<label class="control-label" for="href">活动详情:</label>
			<div class="controls">
			<form:textarea path="details" id="details" htmlEscape="false"/>
			<tags:ckeditor replace="details" uploadPath="/merchandise/donation"></tags:ckeditor>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:Donation:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>