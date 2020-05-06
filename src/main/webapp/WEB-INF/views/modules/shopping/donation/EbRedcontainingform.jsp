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
			var type=$("#type").val();
			if(type=='1'){
			       $(".option").hide();
			       $(".optio").show();
			       $("#favorableType").val(3);
			}else if(type=='2'){
			       $(".option").show();
			       $(".optio").hide();
			       $("#favorableType").val(1);
			}
			var favorableType=$("#favorableType").val();
			if(favorableType=='0'){
			       $("#merchandisetypeId").hide();
			       $("#moneyAmount").hide();
			        $("#fullAmount").show();
			      $("#reductionAmount").show();
			}else if(favorableType=='1'){
			      $("#fullAmount").hide();
			      $("#reductionAmount").hide();
			      $("#merchandisetypeId").show();
			      $("#moneyAmount").hide();
			}else if(favorableType=='2'){
			      $("#merchandisetypeId").hide();
			      $("#fullAmount").hide();
			      $("#reductionAmount").hide();
			      $("#moneyAmount").show();
			}else if(favorableType=='3'){
			      $("#merchandisetypeId").hide();
			      $("#fullAmount").hide();
			      $("#reductionAmount").hide();
			      $("#moneyAmount").show();
			}
		});
		function Type(ftype){
		 if(ftype=='1'){
			       $(".option").hide();
			       $(".optio").show();
			        $("#favorableType").val(3);
			}else if(ftype=='2'){
			       $(".option").show();
			       $(".optio").hide();
			       $("#favorableType").val(1);
			}else if(ftype=='3'){
			       $(".option").show();
			       $(".optio").hide();
			       $("#favorableType").val(1);
			}
		}
		function favoraType(ftype){
		    if(ftype=='0'){
			       $("#merchandisetypeId").hide();
			       $("#moneyAmount").show();
			       $("#fullAmount").show();
			       $("#reductionAmount").show();
			}else if(ftype=='1'){
			      $("#fullAmount").hide();
			      $("#reductionAmount").hide();
			      $("#merchandisetypeId").show();
			      $("#moneyAmount").show();
			}else if(ftype=='2'){
			      $("#merchandisetypeId").show();
			      $("#fullAmount").show();
			      $("#reductionAmount").show();
			      $("#moneyAmount").show();
			}else if(ftype=='3'){
			      $("#merchandisetypeId").hide();
			      $("#fullAmount").hide();
			      $("#reductionAmount").hide();
			      $("#moneyAmount").show();
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbRedcontaining/list">优惠列表</a></li>
		<shiro:hasPermission name="merchandise:Donation:edit"><li class="active"><a href="${ctxsys}/EbRedcontaining/form">优惠添加</a></li></shiro:hasPermission>
	</ul></ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebRedcontaining" action="${ctxsys}/EbRedcontaining/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label" for="href">优惠名称:</label>
			<div class="controls">
			<form:input path="name"  required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">开始时间:</label>
			<div class="controls">
			<input cssClass="required"  name="stateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebRedcontaining.stateTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">结束时间:</label>
			<div class="controls">
			<input cssClass="required"  name="stopTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebRedcontaining.stopTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">类型:</label>
			<div class="controls">
			<form:select path="type" id="type" required="required" onchange="Type(this.value)">
			<form:option value="1">积分</form:option>
			<form:option value="2">优惠券</form:option>
			<form:option value="3">新手积分</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">优惠类型:</label>
			<div class="controls">
			<form:select path="favorableType" id="favorableType" class="input-medium" onchange="favoraType(this.value)">
			<form:option class="optio"  value="3">现金积分</form:option>
			<form:option class="option" value="0">满减</form:option>
			<form:option class="option"  value="1">类别限制</form:option>
			<form:option class="option"  value="2">类别限制+满减</form:option>
			</form:select>
			</div>
		</div>
		<div class="control-group" id="fullAmount">
			<label class="control-label" for="href">满金额:</label>
			<div class="controls">
			<form:input path="fullAmount"  required="required"/>
			</div>
		</div>
		<div class="control-group" id="reductionAmount">
			<label class="control-label" for="href">减金额:</label>
			<div class="controls">
			<form:input path="reductionAmount"  required="required"/>
			</div>
		</div>
		<div class="control-group" id="merchandisetypeId">
					<label class="control-label">所属分类：</label>
					<div class="controls">
		            <tags:treeselect id="menu" name="merchandisetypeId" value="${ebRedcontaining.merchandisetypeId}" labelName="merchandisetypeName" labelValue="${ebRedcontaining.merchandisetypeName}"
					title="菜单" url="${ctxsys}/EbProCategory/treeData" extId="" cssClass="required"/>
					</div>
				</div>
		</div>
		<div class="control-group" id="moneyAmount">
			<label class="control-label" for="href">金额:</label>
			<div class="controls">
			<form:input path="moneyAmount"  required="required"/>
			</div>
		</div>
		<div class="control-group" >
			<label class="control-label" for="href">数量:</label>
			<div class="controls">
			<form:input path="quantity"  required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<form:select path="status">
			<form:option value="1">开启</form:option>
			<form:option value="2">关闭</form:option>
			</form:select>
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