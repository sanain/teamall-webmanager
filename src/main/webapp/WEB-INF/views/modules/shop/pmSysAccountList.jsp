<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>系统账号列表</title>
<meta name="decorator" content="default"/>
<meta name="robots" content="noarchive">
<script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
<script type="text/javascript"> 
$(document).ready(function() {
	
});

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

function deleteIds(){
	obj = document.getElementsByName("checkRow");
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要删除的");
	}else{
		return confirmx('确认要删除吗？', "${ctxsys}/productcomment/deleteService?ids="+ check_val+"");
}
}


function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/pmSysAccount/list");
	$("#searchForm").submit();
	return false;
}
function selectStar(){
	$("#star").val(${star});
}
</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>系统账号列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmSysAccount" action="${ctxsys}/pmSysAccount/list" method="post" class="breadcrumb form-search ">
		<input path="userId" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			 <th>账号名称</th>
              <th>当前余额</th>
              <th>累计总额</th>
              <th>冻结金额</th>
              <th>累计支出</th>
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.accountName}</td>
                <td><fmt:formatNumber type="number" value="${pack.currentAmt}" pattern="0.00" maxFractionDigits="2"/></td>
                <td><fmt:formatNumber type="number" value="${pack.totalAmt}" pattern="0.00" maxFractionDigits="2"/></td>
                <td><fmt:formatNumber type="number" value="${pack.frozenAmt}" pattern="0.00" maxFractionDigits="2"/></td>
                <td><fmt:formatNumber type="number" value="${pack.expenditureAmt}" pattern="0.00" maxFractionDigits="2"/></td>
				<c:if test="${pack.id==7}"><td><a href="${ctxsys}/pmLoveImprestLog?isAllot=1">查看明细</a>&nbsp;&nbsp;</c:if>
                <c:if test="${pack.id!=7}"><td><a href="${ctxsys}/pmSysAccount/mylove?objId=${pack.id}">查看明细</a>&nbsp;&nbsp;</c:if>
				 
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>