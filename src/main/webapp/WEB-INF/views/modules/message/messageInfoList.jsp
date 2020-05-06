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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/message/List">系统消息列表</a></li>
		<li> <a href="${ctxsys}/message/form">消息添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="messageInfo" action="${ctxsys}/message/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			  <li><label>标题：</label><form:input path="messageTitle" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
			 <%--
			 <li><label>类型:</label>
				<form:select path="spackType" class="input-small">
				<form:option value=""></form:option>
				<form:option value="1">基础服务包</form:option>
				<form:option value="2">个性化服务包</form:option>
				</form:select>
			</li>
			 --%><li class="btns">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			 <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteIds()" value="删除" />
			</li>
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>标题</th>
			<th>摘要 </th>
			<th>内容</th>
			<th>消息类型 </th>
			<th>消息分类</th>
			<th>是否定时 </th>
			<th>发送类型 </th>
			<th>发送状态</th>
			<th>定时发送时间 </th>
			<th>创建时间 </th>
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.messageTitle}</td>
				<td title='${pack.messageAbstract}'>${fns:abbr(pack.messageAbstract,30)}</td>
				<td title='${pack.messageContent}'>${fns:abbr(pack.messageContent,30)}</td>
				<td>${fns:getDictLabel(pack.messageClass, 'messageClass', '')}</td>
				<td>${fns:getDictLabel(pack.messageType, 'messageType', '')}</td>
				<td>${pack.isTimingSend==1?"是":"否"}</td>
				<td>
					<c:if test="${pack.receiverType==1}">所有用户</c:if>
					<c:if test="${pack.receiverType==2}">所有门店</c:if>
					<%--<c:if test="${pack.receiverType==3}">所有买家</c:if>--%>
					<c:if test="${pack.receiverType==4}">指定用户</c:if>
					<%--<c:if test="${pack.receiverType==5}">指定代理</c:if>--%>
					<%--<c:if test="${pack.receiverType==6}">所有代理</c:if>--%>
					<c:if test="${pack.receiverType==7}">指定门店</c:if>
				</td>
				<td>${pack.sendStatus==1?"已发送":"未发送"}</td>
				<td><fmt:formatDate value="${pack.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctxsys}/message/form?id=${pack.id}">修改</a>&nbsp;&nbsp;
				</td>
				 
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>