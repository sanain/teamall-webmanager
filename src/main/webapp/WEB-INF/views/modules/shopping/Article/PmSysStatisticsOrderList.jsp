<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
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
			$("#searchForm").attr("action","${ctxsys}/PmSysStatistics/orderList");
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
		<li class="active"><a href="">财务汇总明细列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebOrder" action="${ctxsys}/PmSysStatistics/orderList" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	    <input id="statrDate" name="statrDate" type="hidden" value="${statrDate}" />
	    <input id="stopDate" name="stopDate" type="hidden" value="${stopDate}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><form:input path="orderNo" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入订单编号"/></li>
		      <li>
		      <form:select path="payStatus"  htmlEscape="false" maxlength="50" class="input-medium">
		           <option value="">请选择支付状态</option>  
                   <form:option value="1">已支付</form:option>
               </form:select>
		      </li>
		      <li>
		      <form:select path="onoffLineStatus"  htmlEscape="false" maxlength="50"  class="input-medium">
		           <option value="">请选择订单状态</option>  
                   <form:option value="1">线上订单</form:option>
                   <form:option value="2">线下订单</form:option>  
                   <form:option value="3">商家付款订单</form:option>
                   <form:option value="4">精英合伙人订单</form:option>
                   <form:option value="5">充值订单</form:option>
               </form:select>
		      </li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>
		<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>门店名称</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>订单总金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>运费</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>买家信息</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>订单状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>支付状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>下单时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>付款时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>完成时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>收货地址</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>买家留言</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="12"><label><i></i>发票抬头</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="13"><label><i></i>订单编号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="14"><label><i></i>让利比</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="15"><label><i></i>订单类型</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="16"><label><i></i>快递编号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="17"><label><i></i>物流公司</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="sort-column completionTime">交易时间 </th>
		<th>会员账号</th>
		<th>订单类型</th>
		<th>订单编号</th>
		<th>商品让利金额</th>
		<th>支付方式</th>
		</tr>
		<c:forEach items="${page.list}" var="orderlist" varStatus="status">
			<tr>
			    <td> 
				     ${orderlist.payTime} 
				</td>
				
				<td>${orderlist.mobile}</td>
				<td>
				     <c:if test="${orderlist.type==1}">
				         <c:if test="${orderlist.onoffLineStatus==1}">线上订单</c:if>
					     <c:if test="${orderlist.onoffLineStatus==2}">线下订单</c:if>
						 <c:if test="${orderlist.onoffLineStatus==3}">商家付款订单</c:if>
				     </c:if>
				     <c:if test="${orderlist.type==2}">
				                                  精英合伙人订单
				     </c:if>
				     <c:if test="${orderlist.type==3}">
				                                  充值订单
				     </c:if>
				     <c:if test="${orderlist.type==4}">
				                                  兑换订单
				     </c:if>
				</td>
			    <td>${orderlist.orderNo}</td>
			   <td>
			     <c:if test="${orderlist.onoffLineStatus==3||orderlist.onoffLineStatus==2}">
			     <c:set var="orderAmount" value="${(orderlist.orderAmount*orderlist.returnRatio/100)+orderAmount}"></c:set>
			    <fmt:formatNumber type="number" value="${(orderlist.orderAmount*orderlist.returnRatio/100)}" pattern="0.00" maxFractionDigits="2"/>
			    </c:if>
			     <c:if test="${orderlist.onoffLineStatus!=3&&orderlist.onoffLineStatus!=2}">
			     <c:set var="orderAmount" value="${orderlist.orderAmount+orderAmount}"></c:set>
			     <fmt:formatNumber type="number" value="${orderlist.orderAmount}" pattern="0.00" maxFractionDigits="2"/>
			     </c:if>
			    </td>
			    <td><c:if test="${orderlist.payType==null}">货到付款</c:if><c:if test="${orderlist.payType==1}">货到付款</c:if><c:if test="${orderlist.payType==2}">支付宝</c:if><c:if test="${orderlist.payType==3}">快钱支付</c:if>
			    <c:if test="${orderlist.payType==4}">银联支付</c:if><c:if test="${orderlist.payType==5}">微信支付</c:if><c:if test="${orderlist.payType==6}">现场支付</c:if><c:if test="${orderlist.payType==7}">余额支付</c:if>
				<c:if test="${orderlist.payType==52}">H5微信支付</c:if>
			    </td>
			</tr>
		</c:forEach>
		<tr>
		<th>合计</th>
		<th></th>
		<th></th>
		<th></th>
		<th><fmt:formatNumber type="number" value="${orderAmount}" pattern="0.00" maxFractionDigits="4"/> </th>
		<th></th>
		</tr>
	</table>
	<div class="pagination">${page}</div>
	<script>
	$('#all').click(function(){
        if($(this).is(':checked')){
            $('.kl').prop('checked',true).attr('checked',true);
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('.kl').removeAttr('checked');
            $('#all').removeAttr('checked');
        }
    });
	$('body').on('click','.kl',function(){
        if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('#all').removeAttr('checked');
        }
    })
    
		 $('#fromNewActionSbM').click(function(){
		     $.ajax({
				    type : "POST",
				    data:$('#searchForm').serialize(),
				    url : "${ctxsys}/Order/exsel",   
				    success : function (data) {
				         window.location.href=data; 
				    }
		         });
	     });
	</script>
</body>
</html>