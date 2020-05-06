<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="robots" content="noarchive">
<title>订单列表</title>
<meta name="decorator" content="default"/>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
	$("#searchForm").attr("action","${ctxsys}/pmSysAccount/mylove");
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
		<li class="active"><a>账户明细列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmSysAccount" action="" method="post" class="breadcrumb form-search ">
		<input path="userId" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		
		<ul class="ul-form">
		   <li><label>交易时间：</label>:
			         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="statrDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入开始时间"/>
			       --<input class="small" type="text" name="stopDate" id="stopDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/>
				  <li>
		<label></label>	  
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		</ul>
		
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			 <th>订单ID</th>
              <th>金额</th>
              <th>状态</th>
              <th>备注</th>
              <th>创建时间</th>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.orderId}</td>
				<td>${pack.love}</td>
                <td>${pack.loveStatus}</td>
                <td>${pack.remark}</td>
                <td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				 
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>