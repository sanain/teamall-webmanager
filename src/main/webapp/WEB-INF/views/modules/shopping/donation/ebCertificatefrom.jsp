<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<link href="//cdn.bootcss.com/bootstrap/3.1.0/css/bootstrap.css" rel="stylesheet">
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
<body style=" font-size: 13px;">
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:Donation:edit"><li class="active"><a href="${ctxsys}/Certificate/form">优惠查看</a></li></shiro:hasPermission>
	</ul></ul><br/>
	
	<form:form id="inputForm" modelAttribute="ebConversioncode" action="${ctxsys}/Certificate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="userId"/>
		<div class="container" style="width: 100%;">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="panel panel-primary">
						<div class="panel-heading panel-inner">
							<h3 class="panel-title">
								详情
							</h3>
						</div>
						<div class="panel-body">
							积分名称:${ebConversioncode.redcontainingName}
						</div>
						<div class="panel-footer">
							积分类型:<c:if test="${ebConversioncode.redcontainningType==1}">积分</c:if><c:if test="${ebConversioncode.redcontainningType==2}">优惠券</c:if><c:if test="${ebConversioncode.redcontainningType==3}">新手礼包</c:if>
						</div>
						<div class="panel-body">
							使用范围:<c:if test="${ebConversioncode.favorableType==0}">满${ebConversioncode.fullAmount}减${ebConversioncode.reductionAmount}</c:if><c:if test="${ebConversioncode.favorableType==1}">在${ebConversioncode.merchandisetypeName}下使用优惠${ebConversioncode.moneyAmount}</c:if><c:if test="${ebConversioncode.favorableType==2}">在${ebConversioncode.merchandisetypeName}下使用满${ebConversioncode.fullAmount}减${ebConversioncode.reductionAmount}</c:if>
						</div>
						<div class="panel-footer">
							使用期限:${ebConversioncode.startTime}--${ebConversioncode.stopTime}
						</div>
						<div class="panel-body">
							所属用户:${ebConversioncode.userName}
						</div>
						<div class="panel-footer">
							领取时间:${ebConversioncode.drawTime}
						</div>
						<div class="panel-body">
							使用时间:${ebConversioncode.employTime}
						</div>
						<div class="panel-footer">
							使用状态:<c:if test="${ebConversioncode.status==1}">已领取</c:if><c:if test="${ebConversioncode.status==2}">未领取</c:if><c:if test="${ebConversioncode.status==3}">已使用</c:if><c:if test="${ebConversioncode.status==4}">已过期</c:if>
						</div>
						<div class="panel-body">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>