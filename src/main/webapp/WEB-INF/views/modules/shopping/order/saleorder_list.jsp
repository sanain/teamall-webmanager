<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单列表</title>
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
			$("#searchForm").attr("action","${ctxsys}/Order/saleorderlist");
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
		<li class="active"><a href="${ctxsys}/Order/saleorderlist">订单列表</a></li>
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
		      <label>支付状态</label>
		      <form:select path="payStatus"  htmlEscape="false" maxlength="50" class="input-medium">
		           <option value="">请选择支付状态</option>  
                   <form:option value="0">未支付</form:option>  
                   <form:option value="1">已支付</form:option>
               </form:select>
		      </li>
		      <li>
		      <label>支付类型</label>
		      <form:select path="payType"  htmlEscape="false" maxlength="50" class="input-medium">
		           <option value="">请选择支付类型</option>  
                   <%--<form:option value="1">货到付款</form:option>--%>
					 <%--<form:option value="2">支付宝支付</form:option>--%>
					 <%--<form:option value="3">快钱支付 </form:option>
					 <form:option value="4">银联支付</form:option>--%>
					 <%--<form:option value="5">微信支付</form:option>--%>
					 <form:option value="6">现场支付</form:option>
				     <%--<form:option value="6">微信支付</form:option>--%>
					 <form:option value="7">余额支付</form:option>
					 <form:option value="55">收银扫码余额支付</form:option>
					 <form:option value="56">扫码付</form:option>
					 <form:option value="60">美团</form:option>
					 <form:option value="61">饿了么外卖</form:option>
					  <%--<form:option value="8">汇卡支付 </form:option>
					 <form:option value="9">易联支付 </form:option>
					 <form:option value="10">通联支付 </form:option>
					 <form:option value="11">酷宝快捷支付  </form:option>
					 <form:option value="12">易宝微信支付 </form:option>
					 <form:option value="13">易宝支付宝支付 </form:option>
					 <form:option value="14">易宝一键支付 </form:option>
					 <form:option value="15">通联移动支付</form:option>
					 <form:option value="16">易宝微信支付2</form:option>
					 <form:option value="17">易宝一键支付2</form:option>--%>
               </form:select></li>
		      <li>
		      <label>订单状态</label>
		      <form:select path="status"  htmlEscape="false" maxlength="50"  class="input-medium">
		            <option value="">请选择订单状态</option>
                   <form:option value="1">等待买家付款</form:option>
            	   <form:option value="2">等待发货</form:option>  
                   <form:option value="3">已发货,待收货</form:option> 
                   <form:option value="4">交易成功，已完成</form:option>  
                   <form:option value="5">已关闭 </form:option>
                   <form:option value="6">已退款 </form:option>
               </form:select>
		      </li>
		       <li>
		      <label>订单类型</label>
		      <form:select path="type"  htmlEscape="false" maxlength="50"  class="input-medium">
                  <option value="">全部订单</option>  
                  <form:option value="1">商品订单</form:option> 
				  <form:option value="3">充值订单</form:option> 
				  <form:option value="2">${fns:getProjectName()}大使订单</form:option>
                  <form:option value="4">兑换订单</form:option>  
               </form:select>
		      </li>
			  <li>
				<label>配送状态</label>
				<form:select path="deliveryStatus"  htmlEscape="false" maxlength="50"  class="input-medium">
					<option value="">请选择配送状态</option>
					<form:option value="0">未发送</form:option>
					<form:option value="1">已发送</form:option>
					<form:option value="2">部分发送</form:option>
				</form:select>
			</li>


		       <li>
				 <label>下单时间</label>
		         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入下单开始时间"/>
		       --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入下单结束时间"/>
		       </li>
		       <li>
		        <label>门店名称</label>
		        <form:input path="shopName" class="input-medium"/>
		       </li>
		       <li>
		        <label>用户账号</label>
		        <form:input path="mobile" class="input-medium"/>
		       </li>
		       <li><input id="btnSubmit" class="btn btn-primary" style="margin-left:10px" type="submit" value="查询" onclick="return page();"/></li>
		       <shiro:hasPermission name="merchandise:order:edit">
			   <li><input id="btnExport" class="btn btn-primary check-a1" style="margin-left:10px" type="button" value="导出"/></li>
			   </shiro:hasPermission>
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
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>支付类型</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>支付状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>配送状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>下单时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>付款时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>完成时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="12"><label><i></i>付款时间</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>收货地址</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>买家留言</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="12"><label><i></i>发票抬头</label></li>--%>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="13"><label><i></i>订单编号</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="14"><label><i></i>让利比</label></li>--%>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="14"><label><i></i>订单类型</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="16"><label><i></i>快递编号</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="17"><label><i></i>物流公司</label></li>--%>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="15"><label><i></i>订单商品</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="16"><label><i></i>退款提醒</label></li>--%>
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
		<th>编号</th>
		<th>门店</th>
		<th>订单编号</th>
		<th>订单总金额</th>
		<th>运费</th>
		<th>实付总额</th>
		<th>买家信息</th>
		<th>订单类型</th>
		<th>支付状态</th>
		<th>订单状态</th>
		<th>配送状态</th>
		<%--<th>退款提醒</th>--%>
		<th>递送状态</th>
		<th>支付类型</th>
	    <th class="sort-column createTime ">下单时间 </th>
	    <th class="sort-column payTime">付款时间 </th>
	    <th>操作 </th>
		</tr>
		<c:forEach items="${page.list}" var="orderlist" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			   <td>
				   <%--<c:if test="${orderlist.shopId!=null}">--%>
					<a href=
						   <c:if test="${orderlist.shopId!=null}">
							   "${ctxsys}/PmShopInfo/shopinfo?id=${orderlist.shopId}"
							</c:if>
						   <c:if test="${orderlist.shopId!=null}">
							   "javascript:;"
						   </c:if>
					>
						<font <c:if test="${orderlist.shopId==1}">color="green"</c:if>
							  <c:if test="${orderlist.shopId!=1}">color="blue"</c:if>>

								<c:if test="${orderlist.type==3}">
									平台充值订单
								</c:if>
								<c:if test="${orderlist.type!=3}">
									${orderlist.shopName}
								</c:if>

						</font>
					</a>
				   <%--</c:if>--%>
			   </td>
			    <td><a href="${ctxsys}/Order/saleorderform?orderId=${orderlist.orderId}">${orderlist.orderNo} </a></td>
			    <td>
			    <c:if test="${orderlist.onoffLineStatus==3||orderlist.onoffLineStatus==2}">
			    <fmt:formatNumber type="number" value="${(orderlist.orderAmount*orderlist.returnRatio/100)}" pattern="0.00" maxFractionDigits="2"/>
			    </c:if>
			     <c:if test="${orderlist.onoffLineStatus!=3&&orderlist.onoffLineStatus!=2}">
			     <fmt:formatNumber type="number" value="${orderlist.orderAmount}" pattern="0.00" maxFractionDigits="2"/>
			     </c:if>
			    </td>
			    <td>${orderlist.payableFreight}</td>
				<td>${orderlist.realAmount}</td>
				<td>
					 <c:if test="${orderlist.userId!=null}">
						<a href="${ctxsys}/User/form?userId=${orderlist.userId}">
								${orderlist.userName}/
									<c:if test="${ebUserList[status.index].shopShoppingId != null}">
										${fns:replaceMobile(orderlist.mobile)}
									</c:if>

									<c:if test="${ebUserList[status.index].shopShoppingId == null}">
										${orderlist.mobile}
									</c:if>
						</a>
					 </c:if>
					 <%--<c:if test="${orderlist.userId==null}">--%>
						 <%--${orderlist.gkuserName}/--%>
						 <%--<c:if test="${ebUserList[status.index].shopShoppingId != null}">--%>
							 <%--${fns:replaceMobile(orderlist.gkuserMobile)}--%>
						 <%--</c:if>--%>
<%----%>
						 <%--<c:if test="${ebUserList[status.index].shopShoppingId == null}">--%>
							 <%--${orderlist.gkuserMobile}--%>
						 <%--</c:if>--%>
<%----%>
					 <%--</c:if>--%>
				</td>
				<td>
				     <c:if test="${orderlist.type==1}">商品订单</c:if>
					 <c:if test="${orderlist.type==2}">${fns:getProjectName()}大使订单</c:if>
					 <c:if test="${orderlist.type==3}">充值订单</c:if>
			    </td>
				<td>
				     <c:if test="${orderlist.payStatus==0}"><font color="red">未支付</font></c:if>
					 <c:if test="${orderlist.payStatus==1}"><font color="green">已支付</font></c:if>
			    </td>
				<td>         
					 <c:if test="${orderlist.status==1}">等待买家付款</c:if>
					 <c:if test="${orderlist.status==2}">等待发货</c:if>
					 <c:if test="${orderlist.status==3}">已发货,待收货</c:if>
					 <c:if test="${orderlist.status==4}">交易成功，已完成</c:if>
					 <c:if test="${orderlist.status==5}">已关闭</c:if>
					<c:if test="${orderlist.refundOrderNo != null && !''.equals(orderlist.refundOrderNo)}">
						<c:if test="${orderlist.status!=null&&orderlist.status==6}">
							已退款
						</c:if>
						<c:if test="${orderlist.status==null||orderlist.status!=6}">
							退款中
						</c:if>
					</c:if>
				</td>
				<td>
					<c:if test="${orderlist.deliveryStatus==0}">未发送</c:if>
					<c:if test="${orderlist.deliveryStatus==1}">已发送</c:if>
					<c:if test="${orderlist.deliveryStatus==2}">部分发送</c:if>
				</td>
				<%--<td>         --%>
					  <%--<c:choose>--%>
        	<%--<c:when test="${orderlist.ebAftersale.refundStatus==1}">--%>
	            <%--买家申请退款 >><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">商家审核</font></a>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==2}">--%>
	           <%--买家申请退款 >> <a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">商家已拒绝</font></a>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==3}">--%>
	            <%--买家申请退款 >>商家审核 >> <a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">退款成功</font></a>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==4}">--%>
	            <%--买家申请退款 >>商家审核 >>审核不通过 >> <a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">退款关闭</font></a>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==5}">--%>
	            <%--买家申请退款 >>商家审核 >>--%>
				 <%--<a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">待买家退货</font></a>--%>
				 <%-->>商家收货 >>退款成功--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==6}">--%>
	            <%--买家申请退款 >>--%>
	            <%--商家审核 >>--%>
	            <%--买家退货 >>--%>
	             <%--<a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">待商家收货</font></a>--%>
	             <%-->>退款成功--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==7}">--%>
	            <%--买家申请退款 >>--%>
	            <%--商家审核 >>--%>
	            <%--买家退货 >>--%>
	            <%--商家收货 >>--%>
	             <%--<a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">待买家收款</font></a>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==8}">--%>
	            <%--买家申请退款 >>--%>
	            <%--商家审核 >>--%>
	            <%--买家退货 >>--%>
	            <%--商家收货 >>--%>
	            <%--<a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">待卖家退款</font></a>--%>
	            <%-->>退款成功</li>--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderlist.ebAftersale.refundStatus==9}">--%>
	            <%--买家申请退款 >>--%>
	            <%--商家审核 >>--%>
	             <%--<a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${orderlist.orderId}"><font color="green">平台介入</font></a>--%>
            <%--</c:when>--%>
        <%--</c:choose>--%>
				<%--</td>--%>
				<td>         
				<a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${orderlist.orderId}">	
				<c:choose>
					<c:when test="${orderlist.status==1 }"><span style="color:green;">待付款</span></c:when>
					<c:when test="${orderlist.warehouseId!=null&& orderlist.status==2 }"><span style="color:blue;">待仓库发货</span></c:when>
					<c:when test="${orderlist.warehouseId!=null&& orderlist.status==3 }"><span style="color:green;">仓库已发货</span></c:when>
					<c:when test="${empty orderlist.shippingMethod&& orderlist.status==2 }"><span style="color:green;">待处理</span></c:when>
					<c:when test="${orderlist.shippingMethod==1 }"><span style="color:green;">快递派送</span></c:when>
					<c:when test="${orderlist.shippingMethod == 4&& orderlist.status==2 }"><span style="color:green;">待门店发货</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 4&& orderlist.status==2 }"><span style="color:green;">待门店发货</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 5&& orderlist.status==2 }"><span style="color:green;">待门店派送</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 4 && orderlist.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已自提</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 4 && orderlist.assignedStoreOfferSelf==2}"><span style="color:blue;">等待买家自提</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 5 && orderlist.assignedStoreOffer == 1 }"><span style="color: green;">已送达</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 5&&orderlist.assignedStoreOffer== 2 }"><span style="color:blue;">派送中</span></c:when>
				   <c:when test="${orderlist.shippingMethod == 5&& orderlist.status==2}"><span style="color:red;">未派送</span></c:when>
				   
				   </c:choose>
				   </a>
				</td>
				<td>
				     <c:if test="${orderlist.payType==1}">货到付款</c:if>
					 <c:if test="${orderlist.payType==2}">支付宝支付</c:if>
					 <c:if test="${orderlist.payType==3}">快钱支付 </c:if>
					 <c:if test="${orderlist.payType==4}">银联支付</c:if>
					 <c:if test="${orderlist.payType==5}">微信支付</c:if>
					 <c:if test="${orderlist.payType==6}">现场支付</c:if>
					 <c:if test="${orderlist.payType==7}">余额支付</c:if>
					 <c:if test="${orderlist.payType==8}">汇卡支付 </c:if>
					  <c:if test="${orderlist.payType==9}">易联支付 </c:if>
					 <c:if test="${orderlist.payType==10}">通联支付 </c:if>
					 <c:if test="${orderlist.payType==11}">酷宝快捷支付  </c:if>
					 <c:if test="${orderlist.payType==12}">易宝微信支付 </c:if>
					 <c:if test="${orderlist.payType==13}">易宝支付宝支付  </c:if>
					 <c:if test="${orderlist.payType==14}">易宝一键支付 </c:if>
					 <c:if test="${orderlist.payType==15}">通联移动支付 </c:if>
					 <c:if test="${orderlist.payType==16}">易宝微信支付2  </c:if>
					 <c:if test="${orderlist.payType==17}">易宝一键支付2 </c:if>
					 <c:if test="${orderlist.payType==52}">H5微信支付</c:if>
					 <c:if test="${orderlist.payType==54}">微信小程序支付</c:if>
					 <c:if test="${orderlist.payType==55}">收银扫码余额支付</c:if>
					 <c:if test="${orderlist.payType==56}">扫码付</c:if>
					 <c:if test="${orderlist.payType==60}">美团</c:if>
					 <c:if test="${orderlist.payType==61}">饿了么外卖</c:if>
			    </td>
				<td> 
				     ${orderlist.createTime} 
				</td>
				<td> 
				     ${orderlist.payTime} 
				</td>
				<td> 
				    <a href="${ctxsys}/Order/saleorderdata?orderId=${orderlist.orderId}">详细</a>
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