<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核</title>
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbAftersale/list">申请列表</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="ebAftersale" action="${ctxsys}/EbAftersale/updateAftersale" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
		<form:hidden path="saleId"/>
		<table id="treeTable" class="table table-striped table-condensed">
		<tr>
			<td colspan="8" style=" text-align:center;">明细</td>
		</tr>
		<tr>
			<td>商品名称</td>
			<td>商品规格</td>
			<td>数量</td>
			<td>商品原价</td>
			<td>总金额</td>
			<td>申请类型</td>
			<td>申请审核</td>
		</tr>
		<tr>
			 	<td>${ebAftersale.productName}</td>
			    <td>${ebAftersale.propertyName}</td>
			    <td>${ebAftersale.nums}</td>
			    <td>${ebAftersale.goodsPrice}</td>
			    <td>${ebAftersale.deposit}</td>
			    <td><form:select path="applicationType"  style="width:80px; ">
					<form:option value="0">退货退款</form:option>
					<form:option value="1">退款</form:option>
					<form:option value="2">换货</form:option>
					</form:select>
					</td>
					 <td>
					<form:select path="status" style="width:80px;">
					<form:option value="0">创建服务单</form:option>
					<form:option value="1">审核中</form:option>
					<form:option value="2">审核通过</form:option>
					<form:option value="3">退款中</form:option>
					<form:option value="4">换货中</form:option>
					<form:option value="5">退款成功</form:option>
					<form:option value="6">换货成功</form:option>
					<form:option value="7">已完成</form:option>
					<form:option value="8">审核失败</form:option>
					<form:option value="9">确定收货</form:option>
					</form:select>
					</td>
		</tr>
		<tr>
			<td>服务单号</td>
			<td></td>
			<td>用户名</td>
			<td></td>
		    <td>收货地址</td>
		    <td></td>
			<td>手机号</td>
			<td></td>
			</tr>
		<tr>
			<td>${ebAftersale.saleNo}</td>
			<td></td>
			<td>${ebAftersale.userName}</td>
			<td></td>
		    <td>${ebAftersale.address.provinces}${ebAftersale.address.municipal}${ebAftersale.address.district}${ebAftersale.address.detailsAddress}${ebAftersale.address.userLocation}</td>
			<td></td>
			<td>${ebAftersale.address.phone}</td>
			<td></td>
			</tr>
			<tr>
		    <td colspan="1" >申请时间:</td>
			<td colspan="7" >${ebAftersale.applicationTime}</td>
			</tr>
		<c:if test="${ebAftersale.status==4}">
					<tr>
				    <td colspan="1" >快递编号:</td>
					<td colspan="7" ><form:input path="expressnumber" /></td>
					</tr>
			</c:if>
			<tr>
			<td colspan="1" >申请理由:</td>
			<td colspan="7" ><form:textarea path="travelingApplicants" style=" width:95%"/></td>
			</tr>
			<tr>
			<td colspan="1" >拒绝理由:</td>
			<td colspan="7" ><form:textarea path="trialreport" style=" width:95%" /></td>
			</tr>
			<tr>
			<td colspan="8" >
			<c:forEach var="images" items="${ebProductimages}">
			<img width="70px;" height="50px;" src="${images.name}"/>
			</c:forEach>
			
			</td>
			
			</tr>
	 </table>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:aftersale:edit">
			<c:if test="${ebAftersale.status==0}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=1" class="btn btn-primary">审核通过</a>
			</c:if>
			<c:if test="${ebAftersale.status==1}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=2" class="btn btn-primary">审核通过</a>
			</c:if>
			<c:if test="${ebAftersale.status==2}">
			<c:if test="${ebAftersale.applicationType==1}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=3" class="btn btn-primary">退款</a>
			</c:if>
			<c:if test="${ebAftersale.applicationType==2}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=9" class="btn btn-primary">确定收货</a>
			</c:if>
			<c:if test="${ebAftersale.applicationType==0}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=9" class="btn btn-primary">确定收货</a>
			</c:if>
			</c:if>
			<c:if test="${ebAftersale.status==3}">
			    <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=5" class="btn btn-primary">退款完成</a>
			</c:if>
			<%-- <c:if test="${ebAftersale.status==4}">
			    <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=6" class="btn btn-primary">换货完成</a>
			</c:if> --%>
			<c:if test="${ebAftersale.status==5}">
			    <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=7" class="btn btn-primary">完成</a>
			</c:if>
			<c:if test="${ebAftersale.status==6}">
			    <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=7" class="btn btn-primary">完成</a>
			</c:if>
		
			<c:if test="${ebAftersale.status==9}">
				 <c:if test="${ebAftersale.applicationType==2}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=4" class="btn btn-primary">换货</a>
			</c:if> 
			<c:if test="${ebAftersale.applicationType==0}">
			 <a href="${ctxsys}/EbAftersale/updatsale?id=${ebAftersale.saleId}&saleId=3" class="btn btn-primary">退款</a>
			</c:if>
			</c:if>
				<c:if test="${ebAftersale.status!=7}">
				<input type="hidden" name="status" value="8"/>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="审核失败"/>
				</c:if>
			<c:if test="${ebAftersale.status==4}">
				<input type="hidden" name="status" value="6"/>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="换货完成"/>
			</c:if>
			</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>