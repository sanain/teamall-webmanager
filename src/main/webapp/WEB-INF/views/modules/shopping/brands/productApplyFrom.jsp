<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>
		申请详情
	</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>

	<script type="text/javascript">
	</script>
	<script type="text/javascript">

		function toProductApplyList(){
            window.location.href='${ctxsys}/ebProductApply'
        }

        $(function(){
            $("input").attr("readonly","readonly");
            $("textarea").attr("readonly","readonly");

            //给审核状态赋值
            if($("#applyStatus").val()){
                var arr = ['未审核','通过','不通过','取消申请'];
                $("#applyStatus").val(arr[$("#applyStatus").val()]);
			}
		})

	</script>

	<style type="text/css">
		.control-group .control-label{
			padding-right: 10px;
		}

	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">
			<a href="${ctxsys}/ebProductApply/findApplyById?id=${ebProductApply.id}">申请列表</a>
		</li>
	</ul><br/>
	<p id="price" style="display:none;"></p>
	<form:form id="inputForm" style="position:relative" modelAttribute="ebProductApply" action="${ctxsys}/EbProductCharging/update" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label" for="asName">门店名称:</label>
			<div class="controls">
				<form:input path="shopName" value="${ebProductApply.shopName}" htmlEscape="false" maxlength="50" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="asName">商品名称:</label>
			<div class="controls">
				<form:input path="productName" value="${ebProductApply.productName}" htmlEscape="false" maxlength="50" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">申请时间:</label>
			<div class="controls">
				<form:input path="createTime" value="${ebProductApply.createTime}" htmlEscape="false" maxlength="50"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">附件:</label>
			<div class="controls">
				<a  href="${ctxsys}/ebProductApply/downloadApplyFile?id=${ebProductApply.id}"  class="btn btn-primary">下载</a>
			</div>
		</div>


		<div class="control-group">
			<label class="control-label" for="name">申请理由:</label>
			<div class="controls">
				<textarea style="width: 200px; height: 100px;" cols="100" rows="5">${ebProductApply.remark}</textarea>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="asName">审核状态:</label>
			<div class="controls">
				<form:input path="applyStatus" value="${ebProductApply.applyStatus}" id="applyStatus" htmlEscape="false" maxlength="50" />
			</div>
		</div>


		<div class="control-group">
			<label class="control-label" for="asName">状态:</label>
			<div class="controls">
				<form:input path="isapply" value="${ebProductApply.isapply == 1?'已审核':'未审核'}"  htmlEscape="false" maxlength="50" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">审核时间:</label>
			<div class="controls">
				<form:input path="applyTime" value="${ebProductApply.applyTime}" htmlEscape="false" maxlength="50"/>
			</div>
		</div>

		<c:forEach var="remark" items="${remarkList}" varStatus="vs">
			<div class="control-group">
				<label class="control-label" for="name">回复${vs.index+1}:</label>
				<div class="controls">
				<textarea style="width: 200px; height: 100px;" cols="100" rows="5">${remark.applyRemark}</textarea>
				</div>
			</div>
		</c:forEach>

		<div class="form-actions" >
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="toProductApplyList()"/>
		</div>
	</form:form>

</body>

</html>