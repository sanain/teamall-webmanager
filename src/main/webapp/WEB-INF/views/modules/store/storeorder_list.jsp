<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>派送列表</title>
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
			$("#searchForm").attr("action","${ctxweb}/storeItem/storeorderlist");
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
		<li class="active"><a href="${ctxweb}/storeItem/storeorderlist">派送列表</a></li>
		<li><a href="${ctxweb}/storeItem/saleorderlist">售后列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebOrder" action="${ctxweb}/storeItem/storeorderlist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		     <input type="hidden" name="storeId" value="${storeuser.storeId}">
		    <li>
		     <label>订单编号</label>
		      <form:input path="orderNo" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入订单编号"/></li>
		    
		    
		      <li>
		      <label>订单类型</label>
		      <form:select path="status"  htmlEscape="false" maxlength="50"  class="input-medium">
		            <option value="">请选择订单类型</option>  
            	   <form:option value="2">等待发货</form:option>  
                   <form:option value="3">派送中,待收货</form:option> 
                   <form:option value="4">交易成功，已完成</form:option>  
                   <form:option value="5">已关闭 </form:option>
               </form:select>
		      </li>
		       <li>
		      <label>订单类型</label>
		      <form:select path="type"  htmlEscape="false" maxlength="50"  class="input-medium">
                  <option value="">全部订单</option>  
                  <form:option value="1">商品订单</form:option>  
                  <form:option value="4">兑换订单</form:option>  
               </form:select>
		      </li>
		       <li>
				 <label>下单时间</label>
		         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入下单开始时间"/>
		       --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入下单结束时间"/>
		       </li>
		       <li><input id="btnSubmit" class="btn btn-primary" style="margin-left:10px" type="submit" value="查询" onclick="return page();"/></li>
		       <shiro:hasPermission name="merchandise:order:edit">
			<!--    <li><input id="btnExport" class="btn btn-primary check-a1" style="margin-left:10px" type="button" value="导出"/></li> -->
			   </shiro:hasPermission>
		</ul>
		 <div class="check1">

    </div>
    </form:form> 
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>订单编号</th>
		<th>商品名字</th>
		<th>收货姓名/联系电话</th>
		<th>收货地址</th>
		<th>订单状态</th>
	    <th class="sort-column payTime ">下单时间 </th>
		 <th class="sort-column assignedOpTime ">指派时间 </th>
	    <th>送达状态 </th>
	    <th>操作 </th>
		</tr>
		<c:forEach items="${page.list}" var="ebOrder" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td> ${ebOrder.orderNo} </td>
			    <td> <c:forEach items="${ebOrder.ebOrderitems}" var="ebOrderitems" varStatus="status"> 
				${ebOrderitems.productName} 
				</c:forEach>
				</td>
				<td>
				<c:if test="${ebOrder.shippingMethod!=4}">
				${ebOrder.acceptName}
				</c:if>		
				<c:if test="${ebOrder.shippingMethod==4}">
				${ebOrder.userName}
				</c:if>
				/
				<c:if test="${ebOrder.shippingMethod!=4}">
				${ebOrder.telphone}
				</c:if>		
				<c:if test="${ebOrder.shippingMethod==4}">
				${ebOrder.mobile}
				</c:if>
			    </td>
				<td>
				<c:if test="${ebOrder.shippingMethod!=4}">
				 ${ebOrder.deliveryAddress} 
				 </c:if>
				 <c:if test="${ebOrder.shippingMethod==4}">
				买家自提
				</c:if>
			    </td>
				<td>         
					 <c:if test="${ebOrder.status==1}">等待买家付款</c:if>
					 <c:if test="${ebOrder.status==2}">等待发货</c:if>
					 <c:if test="${ebOrder.shippingMethod eq 5 && ebOrder.status==3&&ebOrder.assignedStoreOffer == 1}">已送达,等待确认收货</c:if>
					 <c:if test="${ebOrder.shippingMethod eq 5 && ebOrder.status==3&&ebOrder.assignedStoreOffer== 2}">已派送，待收货</c:if>
					<c:if test="${ebOrder.shippingMethod eq 4 && ebOrder.status==3 && ebOrder.assignedStoreOfferSelf==1}"><span style="color:green;">买家已自提,等待确认收货</span></c:if>
				    <c:if test="${ebOrder.shippingMethod eq 4 && ebOrder.status==3 && ebOrder.assignedStoreOfferSelf==2}"><span style="color:blue;">已发货，等待买家自提</span></c:if>					
					<c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
					 <c:if test="${ebOrder.status==5}">已关闭</c:if>
				</td>
			
				<td> 
				     ${ebOrder.payTime} 
				</td>		
				<td> 
				     ${ebOrder.assignedOpTime} 
				</td>
				<td> 
				 
				   <c:choose>
				   <c:when test="${ebOrder.shippingMethod == 4&& ebOrder.status==2 }"><span style="color:green;">待门店发货</span></c:when>
				   <c:when test="${ebOrder.shippingMethod == 4 && ebOrder.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已自提</span></c:when>
				   <c:when test="${ebOrder.shippingMethod == 4 && ebOrder.assignedStoreOfferSelf==2}"><span style="color:blue;">等待买家自提</span></c:when>
				   <c:when test="${ebOrder.shippingMethod == 5 && ebOrder.assignedStoreOffer == 1 }"><span style="color: green;">已送达</span></c:when>
				   <c:when test="${ebOrder.shippingMethod == 5&&ebOrder.assignedStoreOffer== 2 }"><span style="color:blue;">派送中</span></c:when>
				   <c:when test="${ebOrder.shippingMethod == 5&& ebOrder.status==2}"><span style="color:red;">未派送</span></c:when>
				   </c:choose>
				   
				</td>
				<td> 
				    <a href="${ctxweb}/storeItem/storeorderform?orderId=${ebOrder.orderId}" target="tager">详细</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	
	<script type="text/javascript">
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
    /*  $('#fromNewActionSbM').click(function(){
	     $.ajax({
			    type : "POST",
			    data:$('#searchForm').serialize(),
			    url : "${ctxsys}/Order/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     }); */
	</script>
</body>
</html>