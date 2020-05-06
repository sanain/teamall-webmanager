<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户消息列表</title>
<%@include file="/WEB-INF/views/include/dialog.jsp" %>
<meta name="decorator" content="default"/>
<script type="text/javascript"> 
$(document).ready(function() {
	$("#btnExport").click(function(){
		top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$("#searchForm").attr("action","${ctxsys}/bsky/product/export");
				$("#searchForm").submit();
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	});
	$("#btnImport").click(function(){
		$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},  
			bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件"});
		
	});
	$("#btnImportRelation").click(function(){
		$.jBox($("#importRelationBox").html(), {title:"导入数据", buttons:{"关闭":true},  
			bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件"});	
}); 
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
		return confirmx('确认要删除吗？', "${ctxsys}/message/deleteService?ids="+ check_val+"");
}
}


function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/messageUser/list");
	$("#searchForm").submit();
	return false;
}

</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/messageUser/List">用户消息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebMessageUser" action="${ctxsys}/messageUser/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			 <li><label>消息标题：</label><form:input path="messageInfo.messageTitle" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
			 <li class="btns">
				 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			 </li>
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>消息标题</th>
			<th>消息摘要 </th>
			<th>消息内容</th>
			<th>消息类型 </th>
			<th>消息分类</th>
			<th>创建时间 </th>
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.messageInfo.messageTitle}</td>
				<td title='${pack.messageInfo.messageAbstract}'>${fns:abbr(pack.messageInfo.messageAbstract,30)}</td>
				<td title='${pack.messageInfo.messageContent}'>${fns:abbr(pack.messageInfo.messageContent,40)}</td>
				<td>${fns:getDictLabel(pack.messageInfo.messageClass, 'messageInfo.messageClass', '')}</td>
				<td>${fns:getDictLabel(pack.messageInfo.messageType, 'messageInfo.messageType', '')}</td>
				<td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<a href="${ctxsys}/messageUser/view?id=${pack.id}">查看</a>&nbsp;&nbsp;
				</td>
				 
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>