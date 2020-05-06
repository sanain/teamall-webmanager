<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>消息列表</title>
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

function send(id,receiverType,messageId){
	var ids= $("#"+id+"Id").val();
	var msg="";
	if(receiverType==1){
		msg="所有用户";
	}else if(receiverType==2){
		msg="所有商家";
	}else if(receiverType==3){
		msg="所有买家";
	}else if(receiverType==4){
		if(ids==""){
			alert("请选择用户！");
			return;
		}
		msg="所选择的用户";
	}else if(receiverType==5){
		if(ids==""){
			alert("请选择代理！");
			return;
		}
		msg="所选择的代理";
	}else if(receiverType==6){
		msg="所有代理";
	}
		if(confirm("确定要发送"+msg+"吗？")){
			$.post("${ctxsys}/message/sendMsgToUser",{messageId:messageId,userids:ids,receiverType:receiverType},function(result){
				alert(result)
			    $("span").html(result);
			  });
		 }
		
	 
}

function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/message/list");
	$("#searchForm").submit();
	return false;
}

</script>     


</head>
<body>

	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>标题</th>
			<th>摘要 </th>
			<th>内容</th>
			<th>创建时间 </th>
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.messageTitle}</td>
				<td title='${pack.messageAbstract}'>${fns:abbr(pack.messageAbstract,30)}</td>
				<td title='${pack.messageContent}'>${pack.messageContent }</td>
				<td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<c:if test="${pack.messageType == 8}">
					<td><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${pack.messageObjId }&id=${pack.id }">处理</a>&nbsp;&nbsp;</td>
				 </c:if>
				 <c:if test="${pack.messageType == 10}">
					<td><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${pack.messageObjId }&id=${pack.id }">处理</a>&nbsp;&nbsp;</td>
				 </c:if>
				 <c:if test="${pack.messageType == 11}">
					<td><a href="${ctxsys}/UserAmtLog?id=${pack.id }">处理</a>&nbsp;&nbsp;</td>
				 </c:if>
				 <c:if test="${pack.messageType == 12}">
					<td><a href="${ctxsys}/pmAgentAmtLog/list?id=${pack.id }">处理</a>&nbsp;&nbsp;</td>
				 </c:if>
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>