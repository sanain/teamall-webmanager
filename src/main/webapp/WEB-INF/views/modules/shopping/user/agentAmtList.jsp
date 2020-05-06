<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>提现记录</title>
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

function sale(){
	obj = document.getElementsByName("checkRow");
	
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要启用的服务包");
	}else{
		return confirmx('确认要启用该服务包吗？', '${ctxsys}/bsky/product/sale?ids=' + check_val);
}
}

function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/pmAgentAmtLog/agentAmtList");
	$("#searchForm").submit();
	return false;
}

</script>   

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmAgentAmtLog/agentAmtList">提现列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmAgentAmtLog" action="" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>交易状态:</label>
				<form:select path="status" class="input-small">
				<form:option value=""></form:option>
				<form:option value="0">交易中</form:option>
				<form:option value="1">交易完成</form:option>
				<form:option value="2">交易取消</form:option>
				
				</form:select>
			</li>
			
			 <li class="btns">
			 	<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<!-- <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteService()" value="删除" /> -->
			</li> 
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed" >
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>金额</th>
			<th>交易状态</th>
			<th>备注说明</th>
			<th>创建时间</th>
		</tr>
		<c:forEach items="${page.list}" var="record">
			<tr id="${record.id}">
				<td><input type="checkbox" value="${record.id}" class="checkRow" name="checkRow"/></td> 
				<td>${record.amt}</td>
				<td>
					<c:if test="${record.status==0}">交易中</c:if>
					<c:if test="${record.status==1}">交易完成</c:if>
					<c:if test="${record.status==2}">交易取消</c:if>
				</td>
				<td>${record.remark}</td>
				<td><fmt:formatDate value="${record.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>