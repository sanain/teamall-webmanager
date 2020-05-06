<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
		$(document).ready(function() {
			getProvince();
					});
		function selecttab(v){
			   if(v=='1'){
			   		 $("#table_box_1").show();
			    	 $("#li_1").addClass("active");
			    	 $("#table_box_2").hide();
			         $("#li_2").removeClass("active");
			         $("#table_box_3").hide();
			         $("#li_3").removeClass("active");
			    }
			    if(v=='2'){
			        $("#table_box_1").hide();
			        $("#li_1").removeClass("active");
			        $("#table_box_2").show();
			        $("#li_2").addClass("active");
			        $("#table_box_3").hide();
			        $("#li_3").removeClass("active");
			    }
	    		if(v=='3'){
	                $("#table_box_1").hide();
	    			$("#li_1").removeClass("active");
	   				$("#table_box_2").hide();
	     			$("#li_2").removeClass("active");
	    			$("#table_box_3").show();
	    			$("#li_3").addClass("active");
	   			 }
	   		 }
	    function getProvince(){
		var url="${ctxsys}/Order/getOList";
		$.getJSON(url,function(data){callbackfunProvince(data);});
		}
		function callbackfunProvince(jsonObj){
		var provinces=jsonObj.provinces;
		var str="<option value=''>-选择物流公司-</option>"; 
		var a=$("#provinceId").val();
		if(provinces!=undefined){
			$.each(provinces,function(i,pro){
			if(a==pro.deliveryId){
			str+="<option  value='"+pro.deliveryId+"' selected='selected'>"+pro.deliveryName+"</option>";
			}else{
			str+="<option  value='"+pro.deliveryId+"'>"+pro.deliveryName+"</option>";
			}
			});
		}
		$("#provinceId").html(str);
		}
	 	</script>
</head>
<body>
     <ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pro:view"><li><a href="${ctxsys}/Order/list">订单列表</a></li></shiro:hasPermission>
	    <%-- <li class="active"><a href="${ctxsys}/Order/form?orderId=${eborder.orderId}">订单<shiro:hasPermission name="merchandise:pro:edit">${not empty eborder.orderId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:pro:view">查看</shiro:lacksPermission></a></li> --%>
	</ul>
		<form:form  modelAttribute="eborder"  action="${ctxsys}/Order/save" method="post" class=" form-search ">
		<form:hidden path="orderId"/>
		<form:hidden path="orderNo"/>
		<tags:message content="${message}"/>
		<c:if test="${eborder.type==1}">
		<div id="table_box_1">
				<table id="treeTable" class="table table-striped table-condensed">
				<tr><th>序号</th><th>商品名称</th><th>商品属性名称</th><th>商品原价</th><th>实付金额</th><th>商品数量</th><th>重量</th><th>是否已发货 </th><shiro:hasPermission name="merchandise:order:edit"><th>操作</th></shiro:hasPermission></tr>
				<c:forEach items="${ebOrderitems}" var="EbOrderitem" varStatus="status">
					<input type="hidden" name="ids" value="${EbOrderitem.orderitemId}"/>
					<tr>
					    <td>${status.index+1}</td>
					    <td>${EbOrderitem.productName}</td>
					    <td>${EbOrderitem.propertyName}</td>
						<td>${EbOrderitem.goodsPrice}</td>
						<td>${EbOrderitem.realPrice}</td>
						<td>${EbOrderitem.goodsNums}<%-- <input name="count" value="${EbOrderitem.goodsNums}"/> --%></td>
						<td>${EbOrderitem.goodsWeight}</td>
						<td>
				 <c:if test="${EbOrderitem.isSend==0}">未发货</c:if>
				<c:if test="${EbOrderitem.isSend==1}">已发货</c:if>
				 <c:if test="${EbOrderitem.isSend==2}">已经退货</c:if>
				 <c:if test="${EbOrderitem.isSend==3}">退货中</c:if>
				</select><td>
							<a href="${ctxsys}/Order/deleteitme?ids=${EbOrderitem.orderitemId}&id=${eborder.orderId}" onclick="return confirmx('要删除该明细吗？', this.href)">删除</a>
						</td>
					</tr>
				</c:forEach>
				</table>
				<table id="treeTable" class="table table-striped table-condensed">
					<tr><th style="width:13%;">订单详情</th ><th style="width:20%;"></th><th style="width:10%;">用户详情</td><th style="width:20%;"></th></tr>
					<td>订单类型</td><td><c:if test="${eborder.type==1}">商品订单</c:if><c:if test="${eborder.type==2}">夺宝订单</c:if></td>              <td>收货人</td><td>${eborder.acceptName}</td></tr>
					<tr><td>订单总金额</td><td>${eborder.orderAmount}元</td>        <td>收货人手机</td><td>${eborder.mobile}</td></tr>
					<tr><td>实付运费金额</td><td>${eborder.realFreight}元</td>       <td>收货地址</td><td>${eborder.address}</td></tr>
					<tr><td>总运费金额</td><td>${eborder.payableFreight}元</td>     <td>用户附言</td><td>${eborder.postscript}</td></tr>
					<tr><td>实付商品总金额</td><td>${eborder.realAmount}元</td>       <td>订单流水号</td><td>${eborder.wserialNumber}</td></tr>
					<tr><td>应付商品总金额</td><td>${eborder.payableAmount}元</td>    <td>积分id</td><td>${eborder.couponId}</td></tr>
					<tr><td>优惠金额</td><td>${eborder.promotions}元</td>           <td>优惠券id</td><td>${eborder.redenvelopeId}</td></tr>
					<tr><td>订单状态</td><td>
					           <c:if test="${eborder.status==1}">待付款</c:if> 
					           <c:if test="${eborder.status==2}">待发货</c:if>   
					           <c:if test="${eborder.status==3}">待发货(已确定)</c:if> 
					           <c:if test="${eborder.status==4}">已发货</c:if> 
					           <c:if test="${eborder.status==5}">待评价</c:if> 
					           <c:if test="${eborder.status==6}">已完成</c:if>
					           <c:if test="${eborder.status==7}">已取消订单</c:if> 
					</td><td>物流单号</td><td><c:if test="${ eborder.status==3}"><c:if test="${empty eborder.expressnumber}"><input name="expressnumber" type="text"/></c:if></c:if><c:if test="${not empty eborder.expressnumber}"> ${eborder.expressnumber}</c:if></tr>
					<tr><td>下单时间</td><td><fmt:formatDate value="${eborder.createTime}" pattern="yyyy-MM-dd"/></td><td>物流公司</td><td><form:select path="deliveryId" id="provinceId" value="${eborder.deliveryId}" htmlEscape="false" maxlength="100"  required="required">
			               			<option value="${eborder.deliveryId}">${eborder.deliveryId}</option>
			               			</form:select></td></tr>
					<tr><td>发货时间</td><td>${eborder.sendTime}</td><td></td><td></td></tr>
					<tr><td>付款时间</td><td>${eborder.payTime}</td><td></td><td></td></tr>
					<tr><td>支付状态</td><td><c:if test="${eborder.payStatus==0}">未支付</c:if><c:if test="${eborder.payStatus==1}">已支付</c:if></td><td></td><td></td></tr>
				</table>
		</div>
		</c:if>
		<c:if test="${eborder.type==2}">
			<table id="treeTable" class="table table-striped table-condensed">
				<tr><th style="width:13%;">订单详情</th ><th style="width:20%;"></th><th style="width:10%;"></td><th style="width:20%;"></th></tr>
				<td>订单类型</td><td><c:if test="${eborder.type==1}">商品订单</c:if><c:if test="${eborder.type==2}">夺宝订单</c:if></td>              <td></td><td></td></tr>
				<tr><td>订单总金额</td><td>${eborder.orderAmount}元</td>        <td></td><td></td></tr>
				<tr><td>订单状态</td><td>
				           <c:if test="${eborder.status==1}">待付款</c:if> 
				           <c:if test="${eborder.status==2}">待发货</c:if>   
				           <c:if test="${eborder.status==3}">待发货(已确定)</c:if> 
				           <c:if test="${eborder.status==4}">已发货</c:if> 
				           <c:if test="${eborder.status==5}">待评价</c:if> 
				           <c:if test="${eborder.status==6}">已完成</c:if>
				           <c:if test="${eborder.status==7}">已取消订单</c:if> 
				</td><td></td><td></td></tr>
				<tr><td>下单时间</td><td><fmt:formatDate value="${eborder.createTime}" pattern="yyyy-MM-dd"/></td><td></td><td></td></tr>
				<tr><td>付款时间</td><td>${eborder.payTime}</td><td></td><td></td></tr>
				<tr><td>支付状态</td><td><c:if test="${eborder.payStatus==0}">未支付</c:if><c:if test="${eborder.payStatus==1}">已支付</c:if></td><td></td><td></td></tr>
				<tr><td>订单流水号</td><td>${eborder.wserialNumber}</td><td></td><td></td></tr>
		    </table>
		</c:if>
		<c:if test="${eborder.type==3}">
			<table id="treeTable" class="table table-striped table-condensed">
				<tr><th style="width:13%;">订单详情</th ><th style="width:20%;"></th><th style="width:10%;"></td><th style="width:20%;"></th></tr>
				<td>订单类型</td><td><c:if test="${eborder.type==1}">商品订单</c:if><c:if test="${eborder.type==3}">充值订单</c:if><c:if test="${eborder.type==2}">夺宝订单</c:if></td>              <td></td><td></td></tr>
				<tr><td>订单总金额</td><td>${eborder.orderAmount}元</td>        <td></td><td></td></tr>
				<tr><td>订单状态</td><td>
				           <c:if test="${eborder.status==1}">待付款</c:if> 
				           <c:if test="${eborder.status==2}">待发货</c:if>   
				           <c:if test="${eborder.status==3}">待发货(已确定)</c:if> 
				           <c:if test="${eborder.status==4}">已发货</c:if> 
				           <c:if test="${eborder.status==5}">待评价</c:if> 
				           <c:if test="${eborder.status==6}">已完成</c:if>
				           <c:if test="${eborder.status==7}">已取消订单</c:if> 
				</td><td></td><td></td></tr>
				<tr><td>下单时间</td><td><fmt:formatDate value="${eborder.createTime}" pattern="yyyy-MM-dd"/></td><td></td><td></td></tr>
				<tr><td>付款时间</td><td>${eborder.payTime}</td><td></td><td></td></tr>
				<tr><td>支付状态</td><td><c:if test="${eborder.payStatus==0}">未支付</c:if><c:if test="${eborder.payStatus==1}">已支付</c:if></td><td></td><td></td></tr>
				<tr><td>订单流水号</td><td>${eborder.wserialNumber}</td><td></td><td></td></tr>
		    </table>
		</c:if>
		<table class="form_table">
						<tr align="center">
						<c:if test="${eborder.status==2}"><td width="400px"><a href="${ctxsys}/Order/questatus?id=${eborder.orderId}" class="btn  btn-primary">已确定发货前信息</a></td></c:if>
						<td width="400px"><shiro:hasPermission name="merchandise:pro:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission></td>
						<td width="400px"><input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/></td>
						</tr>
					</table>
	</form:form>

</body>
</html>