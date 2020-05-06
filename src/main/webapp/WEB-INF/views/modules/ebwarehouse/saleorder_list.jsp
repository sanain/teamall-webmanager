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
			$("#searchForm").attr("action","${ctxweb}/ebWarehouseItem/saleorderlist");
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
		<li><a href="${ctxweb}/ebWarehouseItem/ebWarehouseorderlist">派送列表</a></li>
		<li class="active"><a href="${ctxweb}/ebWarehouseItem/saleorderlist">售后列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebAftersale" action="${ctxweb}/ebWarehouseItem/saleorderlist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		     <label style="width:150px">订单编号/退货编号</label>
		      <form:input path="saleNo" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入编号"/></li>
		      <li>
		      <label>退货类型</label>
		      <form:select path="returnGoodsMethod"  htmlEscape="false" maxlength="50"  class="input-medium">
		            <option value="">请选择订单类型</option>  
            	   <form:option value="2">买家上门退货</form:option>  
                   <form:option value="3">门店上门取货</form:option> 
               </form:select>
		      </li>
		      
		       <li>
				 <label>指派时间</label>
		         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入下单开始时间"/>
				<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入下单结束时间"/>
		       </li>
		       <li><input id="btnSubmit" class="btn btn-primary" style="margin-left:10px" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
		 <div class="check1">

    </div>
    </form:form> 
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>订单编号</th>
		<th>退货编号</th>
		<th>商品名字</th>
		<th>客户姓名/联系电话</th>
		<th>上门取货地址</th>
		<th>退款状态</th>
	    <th class="sort-column assignedOpTime">指派时间 </th>
	    <th>退货状态 </th>
	    <th>操作 </th>
		</tr>
		<c:forEach items="${page.list}" var="ebAftersaleList" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td> ${ebAftersaleList.order.orderNo} </td>
			    <td> ${ebAftersaleList.saleNo} </td>
			    <td> 
				${ebAftersaleList.orderitem.productName} 
				</td>
				<td>
				${ebAftersaleList.returnGoodsPeople}/${ebAftersaleList.returnGoodsPeoplePhone}
			    </td>
				<td>
				<c:if test="${ebAftersaleList.returnGoodsMethod!=2}">
				 ${ebAftersaleList.address} 
				 </c:if>
				 <c:if test="${ebAftersaleList.returnGoodsMethod==2}">
				买家上门退货
				</c:if>
			    </td>
				<td>
				 <c:choose>
        	<c:when test="${ebAftersaleList.refundStatus==1}">
	            买家申请退款 >><font color="green">商家审核</font>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==2}">
	           买家申请退款 >> <font color="green">商家已拒绝</font>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==3}">
	            买家申请退款 >>商家审核 >> <font color="green">退款成功</font>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==4}">
	            买家申请退款 >>商家审核 >>审核不通过 >> <font color="green">退款关闭</font>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==5}">
	            买家申请退款 >>商家审核 >>
				 <font color="green">待买家退货</font>
				 >>商家收货 >>退款成功
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==6}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	             <font color="green">待商家收货</font>
	             >>退款成功
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==7}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	            商家收货 >>
	             <font color="green">待买家收款</font>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==8}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	            商家收货 >>
	            <font color="green">待卖家退款</font>
	            >>退款成功</li>
            </c:when>
            <c:when test="${ebAftersaleList.refundStatus==9}">
	            买家申请退款 >>
	            商家审核 >>
	             <font color="green">平台介入</font>
            </c:when>
        </c:choose>
				</td>
			
				<td> 
				     ${ebAftersaleList.assignedOpTime} 
				</td>
				<td> 
				 
				   <c:choose>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 2&& empty ebAftersaleList.assignedStoreOfferSelf }"><span style="color:green;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 2 && ebAftersaleList.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已上门退货</span></c:when>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 2 && ebAftersaleList.assignedStoreOfferSelf==2}"><span style="color:blue;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 3 && ebAftersaleList.assignedStoreOffer == 1 }"><span style="color: green;">已取件</span></c:when>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 3 && ebAftersaleList.assignedStoreOffer== 2 }"><span style="color:blue;">取件中</span></c:when>
				   <c:when test="${ebAftersaleList.returnGoodsMethod == 3 && empty ebAftersaleList.assignedStoreOffer}"><span style="color:red;">未指派取件人</span></c:when>
				   </c:choose>
				   
				</td>
				<td> 
				    <a href="${ctxweb}/ebWarehouseItem/saleorderform?saleId=${ebAftersaleList.saleId}" target="tager">详细</a>
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