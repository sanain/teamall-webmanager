<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>
		<c:if test="${ebProductCharging.id == null}">增加加料</c:if>
		<c:if test="${ebProductCharging.id != null}">修改加料</c:if>
	</title>
	<meta name="decorator" content="default"/>

	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

	<script type="text/javascript">
		<%--给表单提交验证--%>
        $().ready(function(){
            $("#inputForm").validate({
                rules:{ //验证规则
                    cName:"required",
                    sellPrice:"required",
                    lable:"required"
				},
                messages:{ //提示
                    cName:"标签名不能为空",
                    sellPrice:"销售价不能为空",
                    lable:"标签名不能为空"

                }
            });
        })
	</script>

<script type="text/javascript">
	$(function(){
        if('${ebProductCharging.id}' != ''){
        	$("#inputForm").attr("action","${ctxsys}/EbProductCharging/update");
		}

		if("${message}" != ''){
		    layer.msg('${message}')
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
		<li><a href="${ctxsys}/EbProductCharging/list?productTypeId=${pmProductType.id}">加料列表</a></li>
		<li class="active">
			<c:if test="${ebProductCharging.id == null}">
				<a href="${ctxsys}/EbProductCharging/form?flag=add&productTypeId=${pmProductType.id}">
					增加加料
				</a>
			</c:if>
			<c:if test="${ebProductCharging.id != null}">
				<a href="${ctxsys}/EbProductCharging/form?id=${ebProductCharging.id}&productTypeId=${pmProductType.id}">
					修改加料
				</a>
			</c:if>
		</li>
	</ul><br/>
	<p id="price" style="display:none;"></p>
	<form:form id="inputForm" style="position:relative" modelAttribute="ebProductCharging" action="${ctxsys}/EbProductCharging/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="productTypeId" id="productTypeId" value="${pmProductType.id}">
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="cName">加料名称:</label>
			<div class="controls">
				<form:input path="cName"  value="${ebProductCharging.cName}" htmlEscape="false" maxlength="50" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="sellPrice">销售价格:</label>
			<div class="controls">
				<input type="number" name="sellPrice" value="${ebProductCharging.sellPrice}" htmlEscape="false" maxlength="50">
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">标签名:</label>
			<div class="controls">
				<form:input path="lable"  htmlEscape="false" maxlength="50" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="icon">状态</label>
			<div class="controls">
			<form:select path="status" id="status" style="width: 100px;" class="input-medium">
		           	<form:option value="1">可用</form:option>
					<form:option value="0">不可用</form:option>
               </form:select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="isPublic">使用状态:</label>
			<div class="controls">
				<form:radiobutton  path="isPublic" value="0"/>平台使用
				<form:radiobutton  path="isPublic" value="1"/>商家使用
				<form:radiobutton  path="isPublic"  value="2"/>平台和商家共用
			</div>
		</div>

		<c:if test="${ebProductCharging.id != null}">
			<div class="control-group">
				<label class="control-label" for="isPublic">来源:</label>
				<div class="controls">
					<input type="text" readonly="readonly" value="${ebProductCharging.shopName != null && !''.equals(ebProductCharging.shopName) ? ebProductCharging.shopName : '平台'}" htmlEscape="false" maxlength="50" />
				</div>
			</div>
		</c:if>
		<div class="form-actions" >
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="${ebProductCharging.id == null ?'增加':'修改'}"/>&nbsp;
			<button id="btnCancel" class="btn" type="button"  onclick="window.location.href='${ctxsys}/EbProductCharging'">返 回</button>
		</div>


	</form:form>

</body>

</html>