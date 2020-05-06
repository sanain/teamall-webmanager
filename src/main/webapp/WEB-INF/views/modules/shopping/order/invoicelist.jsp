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
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/Order/invoicelist");
			$("#searchForm").submit();
	    	return false;
	    }
	    $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     });
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/Order/invoicelist">发票管理</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebOrder" action="${ctxsys}/Order" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		     <input type="hidden" name="s" value="">
		    <li>
		     <label>订单编号</label>
		      <form:input path="orderNo" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入订单编号"/></li>
		      <li>
		      <label>是否发送</label>
		      <form:select path="invoiceStatus"  htmlEscape="false" maxlength="50" class="input-medium">
		           <option value="">请选择发送状态</option>  
                   <form:option value="0">未发送</form:option>  
                   <form:option value="1">已发送</form:option>
               </form:select>
		      </li>
		      
		       <li>
				 <label>下单时间</label>
		         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入下单开始时间"/>
		       --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入下单结束时间"/>
		       </li>
		      
		       <li><input id="btnSubmit" style="margin-left:10px" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
    </form:form> 
	
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>订单编号</th>
		<th>下单时间 </th>
		<th>开票金额</th>
		<th>发票状态</th>
		<th>发票抬头</th>
		<th>发票内容</th>
		<th>发送邮箱</th>
		<th>纳税人识别号</th>
		<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="orderlist" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>${orderlist.orderNo} <c:if test="${not empty orderlist.isWholesale&&orderlist.isWholesale==1}"><font color="green">(批)</font></c:if></td>
			    <td>
			    ${orderlist.createTime} 
			    </td>
			    <td>${orderlist.payableFreight}</td>
				<td>
					<c:if test="${empty orderlist.invoiceStatus || orderlist.invoiceStatus == 0 }">未发送</c:if>
					<c:if test="${orderlist.invoiceStatus == 1 }">已发送</br>【${orderlist.invoiceTime}】 </c:if></td>
				<td>${orderlist.invoiceTitle}</td>
				<td>
				     商品明细
			    </td>
				<td>
				    ${orderlist.invoicePostEmail}
			    </td>
				<td>
				    ${orderlist.invoicePeopleNo}
			    </td>
				<td><a href="${ctxsys}/Order/invoiceform?orderId=${orderlist.orderId}">详情</a></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	
	
</body>
</html>