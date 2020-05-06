<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>付金额统计列表</title>
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
		return confirmx('确认要删除吗？', "${ctxsys}/pmSysPayAmountStatistics/deleteAll?ids="+ check_val+"");
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
	$("#searchForm").attr("action","${ctxsys}/pmSysPayAmountStatistics/list");
	$("#searchForm").submit();
	return false;
}

</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmSysPayAmountStatistics/list">支付金额统计列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmSysPayAmountStatistics" action="${ctxsys}/pmSysPayAmountStatistics/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			  <li><label>创建时间：</label>
		         <input class="input-medium" type="text" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${startTime}" placeholder="开始时间"/>
			     -- <input class="input-medium" type="text" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${endTime}" placeholder="结束时间"/>
				   </li> 
		         <li> 
			 <li class="btns">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>统计时间  </th>
			<th>预计总收入</th>
			<th>预计让利款</th>
			<th>实际总收入</th>
			<th>实际让利款</th>
			<th>货到付款 </th>
			<th>支付宝支付  </th>
			<th>快钱支付 </th>
			<th>银联支付  </th>
			<th>微信支付</th>
			<th>余额支付</th>
			<th>酷宝支付</th>
			<th>易宝微信支付</th>
			<th>易宝微信支付2</th>
			<th>易宝支付宝支付</th>
			<th>易宝一键支付</th>
			<th>易宝一键支付2</th>
			<th>通联移动支付</th>
			<th>通联支付宝</th>
			<th>创建时间  </th>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td><fmt:formatDate value="${pack.statisticsTime}" pattern="yyyy-MM-dd"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.estimatedRevenue}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.expectedAssignment}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.realityRevenue}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.realityAssignment}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payDelivery}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payAlipay}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payQuick}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payUnion}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payWechat}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payBalance}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payKubao}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payWechatYibao}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payWechatYibaoTwo}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payAlipayYibao}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payOneKeyYibao}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payOneKeyYibaoTwo}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payMoveTonglian}" pattern="0.00" maxFractionDigits="2"/></td>
				<td style="text-align: right;"><fmt:formatNumber type="number" value="${pack.payAlipayTonglian}" pattern="0.00" maxFractionDigits="2"/></td>
				<td><fmt:formatDate value="${pack.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</td>
			</tr>
		</c:forEach>
	</table>
  </div>
	<div class="pagination">${page}</div>
</body>
</html>