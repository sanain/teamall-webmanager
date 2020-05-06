<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>积分支付配置</title>
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
		return confirmx('确认要删除吗？', "${ctxsys}/pmLovePayDeploy/deleteAll?ids="+ check_val+"");
}
}

function send(id,receiverType,messageId){
	var ids= $("#"+id+"Id").val();
	var msg="";
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
	$("#searchForm").attr("action","${ctxsys}/pmLovePayDeploy/list");
	$("#searchForm").submit();
	return false;
}

</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmLovePayDeploy/list">支付配置列表</a></li>
		<li> <a href="${ctxsys}/pmLovePayDeploy/form">支付配置添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmLovePayDeploy" action="${ctxsys}/pmLovePayDeploy/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			  <li><label>支付名称：</label><form:input path="lovePayName" htmlEscape="false" maxlength="50" class="input-medium" placeholder="支付名称" /></li> 
			  <li><label>生效类型:</label>
				<form:select path="lovePayEffectType" class="input-small">
				<form:option value=""></form:option>
				<form:option value="1">默认</form:option>
				<form:option value="2">时间区间</form:option>
				</form:select>
			 </li>
			  <li><label>时间：</label>
		         <input class="input-medium" type="text"  name="lovePayStartDate" id="lovePayStartDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd 00:00:00'})" value="<fmt:formatDate value="${pmLovePayDeploy.lovePayStartDate}" pattern="yyyy-MM-dd 00:00:00"/>" placeholder="生效开始时间"/>
			     -- <input class="input-medium" type="text" name="lovePayEndDate" id="lovePayEndDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd 00:00:00'})" value="<fmt:formatDate value="${pmLovePayDeploy.lovePayEndDate}" pattern="yyyy-MM-dd 00:00:00"/>" placeholder="生效结束时间"/>
				   </li> 
		         <li> 
			 <li class="btns">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			 <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteIds()" value="删除" />
			</li>
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>名称</th>
			<th>生效类型 </th>
			<th>生效开始时间 </th>
			<th>生效结束时间  </th>
			<th>金额下线占比(%)</th>
			<th>金额上线占比(%)</th>
			<th>备注</th>
			<th>创建时间  </th>
			<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.lovePayName}</td>
				<td>
					<c:if test="${pack.lovePayEffectType==1}">默认</c:if>
					<c:if test="${pack.lovePayEffectType==2}">时间区间</c:if>
				</td>
				
				<td><fmt:formatDate value="${pack.lovePayStartDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${pack.lovePayEndDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${pack.lovePayMinRatio}</td>
				<td>${pack.lovePayMaxRatio}</td>
				<td>${pack.remarks}</td>
				<td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctxsys}/pmLovePayDeploy/form?id=${pack.id}">修改</a>&nbsp;&nbsp;
				</td>
				 
			</tr>
		</c:forEach>
	</table>
	
	<div class="pagination">${page}</div>
</body>
</html>