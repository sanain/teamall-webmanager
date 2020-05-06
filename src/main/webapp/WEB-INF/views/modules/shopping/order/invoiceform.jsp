<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发票管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
	<script type="text/javascript">
	    $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	    	
	    	$('body').on('click','#btnSubmit',function(){
	    		if($("#invoiceTitle").val().trim() == '' || $("#invoiceTitle").val().trim() == null){
	    			alert("发票抬头不能为空");
	    			return false;
	    		}
	    		if($("#invoicePostEmail").val().trim() == '' || $("#invoicePostEmail").val().trim() == null){
	    			alert("发送邮箱不能为空");
	    			return false;
	    		}
	    		if($("#invoiceHeadType").val() == 2){
		    		if($("#invoicePeopleNo").val().trim() == '' || $("#invoicePeopleNo").val().trim() == null){
		    			alert("纳税人识别号不能为空");
		    			return false;
		    		}
		    	}
	    		if($('#invoiceStatus option:selected').val() == 1){
	    		 var mymessage=confirm("保存后无法修改，确认保存吗？");
	    		    if(mymessage==true)
	    		    {
	    		    	return true;
	    		    }
	    		    else
	    		    {
	    		    	return false;
	    		    }
	    		}else{
	    			return true;
	    		}
	    	});
	    	
	     });
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/Order/invoiceform">发票修改</a></li>
	</ul>
	
	 <form:form id="searchForm" modelAttribute="ebOrder" action="${ctxsys}/Order/invoicesave" method="post" class="breadcrumb form-search ">
	 
	 	<form:input path="orderId" type="hidden" value="${ebOrder.orderId }" />
	 	<form:input id="invoiceHeadType" path="invoiceHeadType" type="hidden" value="${ebOrder.invoiceHeadType }" />
	 	
	 	<c:if test="${not empty ebOrder.invoiceStatus && ebOrder.invoiceStatus == 1 }">
		<div class="control-group">
			<label class="control-label" for="invoiceTitle">发票抬头:</label>
			<div class="controls">
			<form:input id="invoiceTitle" path="invoiceTitle" htmlEscape="false" readonly="true" class="input-xxlarge" style="width: 250px;" placeholder="请输入个人/企业名称" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		<c:if test="${empty ebOrder.invoiceStatus || ebOrder.invoiceStatus == 0 }">
		<div class="control-group">
			<label class="control-label" for="invoiceTitle">发票抬头:</label>
			<div class="controls">
			<form:input id="invoiceTitle" path="invoiceTitle" htmlEscape="false"  class="input-xxlarge" style="width: 250px;" placeholder="请输入个人/企业名称" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		
		<c:if test="${not empty ebOrder.invoiceStatus && ebOrder.invoiceStatus == 1 }">
		<div class="control-group">
			<label class="control-label" for="invoicePostEmail">发送邮箱:</label>
			<div class="controls">
			<form:input id="invoicePostEmail" path="invoicePostEmail" htmlEscape="false" readonly="true" class="input-xxlarge" style="width: 250px;" placeholder="请输入接收发票的邮箱" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		<c:if test="${empty ebOrder.invoiceStatus || ebOrder.invoiceStatus == 0 }">
		<div class="control-group">
			<label class="control-label" for="invoicePostEmail">发送邮箱:</label>
			<div class="controls">
			<form:input id="invoicePostEmail" path="invoicePostEmail" htmlEscape="false" class="input-xxlarge" style="width: 250px;" placeholder="请输入接收发票的邮箱" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		
		<c:if test="${not empty ebOrder.invoiceStatus && ebOrder.invoiceStatus == 1 }">
		<div class="control-group">
			<label class="control-label" for="invoiceStatus">发票状态:</label>
			<div class="controls">
			<form:select id="invoiceStatus" path="invoiceStatus" class="input-mini" readonly="true">
					<form:option value="0" label="未发送" select="${ebOrder.invoiceStatus == 0 ? 'selected' : '' }" />
					<form:option value="1" label="已发送" select="${ebOrder.invoiceStatus == 1 ? 'selected' : '' }" />
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		<c:if test="${empty ebOrder.invoiceStatus || ebOrder.invoiceStatus == 0 }">
		<div class="control-group">
			<label class="control-label" for="invoiceStatus">发票状态:</label>
			<div class="controls">
			<form:select id="invoiceStatus" path="invoiceStatus" class="input-mini">
					<form:option value="0" label="未发送" select="${ebOrder.invoiceStatus == 0 ? 'selected' : '' }" />
					<form:option value="1" label="已发送" select="${ebOrder.invoiceStatus == 1 ? 'selected' : '' }" />
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		</c:if>
		
		<c:if test="${not empty ebOrder.invoiceStatus && ebOrder.invoiceStatus == 1 }">
		<div class="control-group">
			<label class="control-label" for="invoicePeopleNo">纳税人识别号:</label>
			<div class="controls">
			<form:input id="invoicePeopleNo" path="invoicePeopleNo" htmlEscape="false" readonly="true" class="input-xxlarge" style="width: 250px;" placeholder="请输入纳税人识别号" />
			<span class="help-inline"><font color="red">*个人无需填写纳税人识别号</font> </span>
		</div>
		</c:if>
		<c:if test="${empty ebOrder.invoiceStatus || ebOrder.invoiceStatus == 0 }">
		<div class="control-group">
			<label class="control-label" for="invoicePeopleNo">纳税人识别号:</label>
			<div class="controls">
			<form:input id="invoicePeopleNo" path="invoicePeopleNo" htmlEscape="false" class="input-xxlarge" style="width: 250px;" placeholder="请输入纳税人识别号" />
			<span class="help-inline"><font color="red">*个人无需填写纳税人识别号</font> </span>
		</div>
		</c:if>
		
    </form:form> 
	
	<br></br>
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
			<th>商品名称</th>
			<th>单价</th>
			<th>数量 </th>
			<th>总价</th>
		</tr>
		<c:forEach items="${ebOrder.ebOrderitems }" var="ebOrderitem" varStatus="status">
			<tr>
				<td>${ebOrderitem.productName } </td>
			    <td>${ebOrderitem.realPrice }</td>
			    <td>${ebOrderitem.goodsNums }</td>
			    <td>${ebOrderitem.realPrice * ebOrderitem.goodsNums }</td>
			</tr>
		</c:forEach>
	</table>
	
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
		
</body>
</html>