<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>营业 统计</title>
<%@include file="/WEB-INF/views/include/dialog.jsp" %>
<meta name="decorator" content="default"/>
<script type="text/javascript"> 


function checkAll() {
	if ($(".checkAll").is(":checked")) {
        $("input[class=checkRow]:checkbox").prop("checked", true);
    } else {
	    $("input[class=checkRow]:checkbox").prop("checked", false);
    }
}

function checkRow(obj) {
	if ($("#"+obj).is(":checked")) {
		$("input[id="+obj+"]:checkbox").prop("checked", false);
    } else {
    	$("input[id="+obj+"]:checkbox").prop("checked", true);
    }
}


function deleteService(){
	obj = document.getElementsByName("checkRow");
	
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要删除的服务包");
	}else{
		return confirmx('确认要删除该服务包吗？', '${ctxsys}/yh/yhCfdServicePack/deleteService?ids=' + check_val);
}
}


function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/agent/business");
	$("#searchForm").submit();
	return false;
}

</script>   

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>订单列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebOrder" action="" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			 <%--<li><label>门店名称 ：</label><form:input path="pmShopInfo.shopName" htmlEscape="false" maxlength="50" class="input-medium" style="width: 100px;" placeholder="请输入关键字"/></li>
			 <li class="btns">
			 	<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<!-- <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteService()" value="删除" /> -->
			</li> 
			
		--%></ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
              <th>会员账号</th>
              <th>订单类型</th>
              <th>订单号</th>
              <th>金额</th>
              <th>时间</th>
              
		</tr>
		<c:forEach items="${page.list}" var="pc">
			<tr id="">
				<td><input type="checkbox" value="" class="checkRow" name="checkRow"/></td> 
				<td>${pc.ebUser.mobile}</td>
				<td>
				<c:if test="${pc.type==1}">商品订单</c:if>
				<c:if test="${pc.type==2}">精英合伙人订单</c:if>
				<c:if test="${pc.type==3}">充值订单</c:if>
				</td>
				<td>${pc.orderNo}</td>
				<td>${pc.orderAmount}</td>
				<td><fmt:formatDate value="${pc.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>