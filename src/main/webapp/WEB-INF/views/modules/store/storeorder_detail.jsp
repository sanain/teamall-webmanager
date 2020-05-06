<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>订单详情</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/supplyshop/js/base_form.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/modules/layer/default/layer.css">
    <script src="${ctxStatic}/sbShop/layui/lay/modules/layer.js"></script>
     
     
         
    <style>
    	body p{margin-top:0;}
        ul{list-style: none}
        .order{padding: 20px}
        .order-state{padding: 20px;border: 1px solid #DCDCDC;}
        .order-state>p{font-size: 16px}
        .order-state span{color: #666666;cursor: pointer}
        .order-state .shi{color: #FF6600}
        .order-tail{border: 1px solid #DCDCDC;overflow: hidden;margin-top: 20px}
        .order-tail>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .order-tail ul{overflow:hidden;padding-left: 20px;color: #666666}
        .order-tail ul li{float:left;width:40%}
        .order-tail ul li:nth-child(1){color: #333333;margin-bottom: 10px}
        .order-msg{border: 1px solid #DCDCDC;margin-top: 20px}
        .order-msg>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .order-msg ul{color: #666666;border-bottom: 1px solid #DCDCDC;padding-bottom: 5px;margin: 0 20px 10px;}
        .order-msg ul:last-child{border-bottom: none}
        .order-msg ul li{line-height: 30px}
        .order-msg ul li:nth-child(1){color: #333333;margin-bottom: 10px}
        .look-a{display: inline-block;height: 30px;line-height: 30px;width: 90px;text-align: center;color: #ffffff;background: #78A7FF;border-radius: 5px;margin-left: 5px}
        .shop-msg{border: 1px solid #DCDCDC;margin-top: 20px}
        .shop-msg>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .list-div{margin: 20px;border: 1px solid #DCDCDC}
        .shop-msg ul{overflow: hidden;text-align: center;margin-bottom: 0;border-bottom: 1px solid #DCDCDC;margin-top:0;padding-left:0}
        .list-div ul:last-child{border-bottom: none}
        .shop-msg ul li{float: left;    box-sizing: border-box;}
        .shop-msg ul li:nth-child(1){width:9% }
        .shop-msg ul li:nth-child(2){width:17% }
        .shop-msg ul li:nth-child(3){width:34% }
        .shop-msg ul li:nth-child(4){width:10% }
        .shop-msg ul li:nth-child(5){width:10% }
        .shop-msg ul li:nth-child(6){width:10% }
         .shop-msg ul li:nth-child(7){width:10% }
        .list-top{height: 30px;line-height: 30px;background: #f0f0f0}
        .img-box{width: 80px;height: 70px;overflow: hidden;border: 1px solid #DCDCDC;margin:10px auto 0;}
        .list-body li{border-left: 1px solid #DCDCDC;line-height: 90px;height: 90px}
        .list-body li:first-child{border-left: none}
        .list-body li:nth-child(4){color: #FF6600}
        .shut{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 100}
        .shut-box{width: 450px;height: 275px;padding: 20px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-top: -137px;margin-left: -200px}
        .shut-box>p{background: #f0f0f0;text-align: center;height: 30px;line-height: 30px;}
        .shut-box select{width: 160px;height: 30px;border: 1px solid #DCDCDC;border-radius: 3px;padding-left: 10px;outline: none}
        .shut-sel{padding-left: 15px}
        .shut-btn{text-align: center;margin-top: 20px}
        .shut-btn a{display: inline-block;height: 30px;width: 80px;background: #78A7FF;color: #ffffff;border-radius: 5px;line-height: 30px}
        .shut-btn a:nth-child(1){margin-right: 10px}
        .shut-btn a:nth-child(2){margin-left: 10px}
        .shut ul{padding-left: 15px;margin-top: 20px}
        .shut ul li:nth-child(1){color: #ff6600}
        .look{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 100}
        .look-box{width: 550px;height: 310px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-top: -155px;margin-left: -225px;overflow: hidden}
        .look-box>p{height: 35px;line-height: 35px;background: #f0f0f0;text-align: center;position: relative}
        .look-box>p img{position: absolute;right: 15px;top: 12px;cursor: pointer}
        .look-msg{height: 235px;overflow-y: auto}
        .look-box ul{overflow: hidden}
        .look-box ul li{float: left;width: 50%;text-align: center}
        .look-msg ul li:nth-child(2){text-align: left}
        .btn{color: #fff;background-color: #286090; border-color: #204d74;
}}
    </style>
     
</head>
<body>

    <div class="order">

        <!--订单状态-->
        <div class="order-state">
            <p>
          <span> 当前订单状态: 	
					<c:if test="${ebOrder.status==1}">等待买家付款</c:if>
					 <c:if test="${ebOrder.status==2}">等待发货</c:if>
					 <c:if test="${ebOrder.shippingMethod eq 5 && ebOrder.status==3&&ebOrder.assignedStoreOffer == 1}">已送达,等待确认收货</c:if>
					 <c:if test="${ebOrder.shippingMethod eq 5 && ebOrder.status==3&&ebOrder.assignedStoreOffer== 2}">已派送，待收货</c:if>
					<c:if test="${ebOrder.shippingMethod eq 4 && ebOrder.status==3 && ebOrder.assignedStoreOfferSelf==1}"><span style="color:green;">买家已自提,等待确认收货</span></c:if>
				    <c:if test="${ebOrder.shippingMethod eq 4 && ebOrder.status==3 && ebOrder.assignedStoreOfferSelf==2}"><span style="color:blue;">已发货，等待买家自提</span></c:if>					
					<c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
					<c:if test="${ebOrder.status==5}">已关闭</c:if>
			<c:if test="${ebOrder.status==2&&ebOrder.shippingMethod==4}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认发货 " onclick="sendhuo()"/>
			</c:if>
			<c:if test="${ebOrder.status==2&&ebOrder.shippingMethod==5}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="派送" onclick="sendbtn()"/>
			</c:if>
			<c:if test="${ebOrder.shippingMethod==4&&ebOrder.status==3&&ebOrder.assignedStoreOfferSelf==2}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认买家自提" onclick="confirmOff()"/>
			</c:if>
			<c:if test="${ebOrder.shippingMethod==5&&ebOrder.status==3&&ebOrder.assignedStoreOffer==2}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认送达" onclick="confirmSend()"/>
			</c:if>
			</span>
            </p>
        </div>
 
          <div class="order-tail" style="margin-top: 20px; display: none;" id="sendOrder">
          <p>指定派送人</p>
       <form class="form-horizontal" role="form" method="post" action="${ctxweb}/storeItem/sendOrder">
       <input type="hidden" name="orderId" value="${ebOrder.orderId }" id="orderId">
	   <div class="form-group">
		<label for="firstname" class="col-sm-2 control-label">派送人姓名</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="assignedStorePeople"  name="assignedStorePeople"
				   placeholder="请输入派送人姓名" style="width:300px;">
		</div>
	</div>
	<div class="form-group">
		<label for="lastname" class="col-sm-2 control-label">派送人电话</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id=assignedStorePeoplePhone name="assignedStorePeoplePhone"
				   placeholder="请输入派送人电话" style="width:300px;">
		</div>
	</div>
	 
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			 <button type="button" class="btn btn-primary" onclick="sendCheck();">确定</button> 
			 <button type="button" class="btn btn-primary" style="margin-left: 30px;" onclick="closeSend()">取消</button> 
		</div>
	</div>
</form>
        </div>   
        <!--订单跟踪-->
         <div class="order-tail">
            <p>订单跟踪</p>
            <ul>
                <li style="width:15%;margin-left:40px">处理信息</li>
                <li style="width:15%">处理时间</li>
            </ul>
            <c:if test="${not empty ebOrder.createTime}">
            <ul>
                <li style="width:15%;margin-left:40px">订单提交成功</li>
                <li style="width:15%">${ebOrder.createTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebOrder.payTime}">
            <ul>
                <li style="width:15%;color:green;margin-left:40px">订单支付成功</li>
                <li style="width:15%;color:green">${ebOrder.payTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebOrder.sendTime}">
            <ul>
                <li style="width:15%;margin-left:40px">订单发货成功</li>
                <li style="width:15%">${ebOrder.sendTime}</li>
            </ul>
            </c:if> 
			<c:if test="${not empty ebOrder.assignedStoreOfferTime}">
            <ul>
                <li style="width:15%;margin-left:40px">实体店确认送达</li>
                <li style="width:15%">${ebOrder.assignedStoreOfferTime}</li>
            </ul>
            </c:if> 
			<c:if test="${not empty ebOrder.assignedStoreOfferSelfTime}">
            <ul>
                <li style="width:15%;margin-left:40px">买家已自提</li>
                <li style="width:15%">${ebOrder.assignedStoreOfferSelfTime}</li>
            </ul>
            </c:if> 
            <c:if test="${not empty ebOrder.completionTime}">
            <ul>
                <li style="width:15%;margin-left:40px">订单完成</li>
                <li style="width:15%">${ebOrder.completionTime}</li>
            </ul>
            </c:if>
        </div>
          <!--订单信息-->
        <div class="order-msg">
            <p>订单信息</p>
            <c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
			
            <ul>
                <li>收货信息</li>
                <li><span>收货人：</span><span>
				<c:if test="${ebOrder.shippingMethod==5}">
				${ebOrder.acceptName}
				</c:if>		
				<c:if test="${ebOrder.shippingMethod==4}">
				${ebOrder.userName}
				</c:if>
				</span></li>
				<c:if test="${ebOrder.shippingMethod==5}">
                <li><span>地  &nbsp;&nbsp;址：</span><span>${ebOrder.deliveryAddress}</span></li>
				</c:if>
                <li><span>手  &nbsp;&nbsp;机：</span><span>
				<c:if test="${ebOrder.shippingMethod==5}">
				${ebOrder.telphone}
				</c:if>		
				<c:if test="${ebOrder.shippingMethod==4}">
				${ebOrder.mobile}
				</c:if></span></li>
            </ul>
			
            <c:if test="${ebOrder.status==3||ebOrder.status==4||ebOrder.status==7||ebOrder.status==9}">
             <ul>
                <li>配送信息</li>
                <li><span>配送方式：</span><span>
				<c:if test="${ebOrder.shippingMethod==5}">
				门店派送
				 </c:if>
				 <c:if test="${ebOrder.shippingMethod==4}">
				买家自提
				 </c:if>
				</span></li>
                 <li>
                 <span>备注：</span><span>${ebOrder.assignedRemark }</span>
                </li>
                <li>
                 <span>门店电话：</span><span>${storeuser.storePhone }</span>
                </li>
				<c:if test="${ebOrder.shippingMethod==5}">
                 <li>
                 <span>指定派送人：</span><span>${ebOrder.assignedStorePeople }</span>
                </li>
                 <li>
                 <span>派送人联系电话：</span><span>${ebOrder.assignedStorePeoplePhone }</span>
                </li>
                  </c:if>
            </ul>
            </c:if>
            </c:if>
            
        </div>
          <c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
        <!--商品信息-->
        <div class="shop-msg">
            <p>商品信息</p>
            <div class="list-div">
                <ul class="list-top">
                    <li>明细</li>
                    <li>商品图片</li>
                    <li>商品名称</li>
                    <li>规格</li>
                    <li>价格</li>
                    <li>商品数量</li>
                    <li style="display:none">让利比</li>
                </ul>
                <c:forEach items="${ebOrder.ebOrderitems}" var="ebOrderitems">
                <ul class="list-body">
                    <li>
                       ${ebOrderitems.orderitemId}
                    </li>
                    <li>
                        <div class="img-box">
                            <img src="${ebOrderitems.productImg}" alt="" style="width: 83px;height: 67px;">
                        </div>
                    </li>
                    <li>
                        	${ebOrderitems.productName}
                    </li>
                    <li>${ebOrderitems.standardName}</li>
                    <li>
                     	   ¥${ebOrderitems.realPrice}
                    </li>
                    <li>
                        ${ebOrderitems.goodsNums}
                    </li>
                    <li style="display:none">${ebOrderitems.returnRatio}%</li>
                </ul>
                </c:forEach>
            </div>
        </div>
        </c:if>
        <div class="text-center " style="margin-top: 20px;"> <input type="button"  class="btn btn-primary" value="返回" onclick="goback()"/></div>
  </div>
   <script type="text/javascript">
     function sendhuo(){
		 layer.open({
        	    content: "确认由发货，通知用户自提？"
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	        layer.close(index);
				var index2= layer.load(1, {shade: [0.1,'#fff']}); 
    	    	var frm =document.forms[0];
    	    	setTimeout(function(){
    	    		 frm.submit();
     	   		 }, 1200);
        	    }
        	  });
     }
     </script>
    <script type="text/javascript">
	function confirmSend(){
    	 layer.open({
     	    content: "确认用户已收货？"
     	    ,btn: ['确定', '取消']
     	    ,yes: function(index){
     	        layer.close(index);
     	        takegoods();//收货
     	    }
     	  });
	}
		  </script>
    <script type="text/javascript">
    function confirmOff(){
    	 layer.open({
     	    content: "确认买家已自提？"
     	    ,btn: ['确定', '取消']
     	    ,yes: function(index){
     	        layer.close(index);
     	        takegoods();//确认买家已自提
     	    }
     	  });
	}
    	 </script>
    <script type="text/javascript">
    function takegoods(){//已收货
    		 var orderId=$("#orderId").val();
    	     $.ajax({
 			    url : "${ctxweb}/storeItem/takegoods",   
 			    type : 'post',
 			    data:{
 			    	orderId:orderId
 					},
 					cache : false,
 			     success : function (data) {
 			     if(data.code=='00'){
 			        window.location.href="${ctxweb}/storeItem/storeorderform?orderId="+data.orderId;
 			      }else{
 			    	 layer.alert(data.msg);
 			      }
 			    }
 	         });
    	 }
     
	</script>
    <script type="text/javascript">
    function goback(){
    	location.href="${ctxweb}/storeItem/storeorderlist";
    }
     function sendbtn(){
    	 $("#sendOrder").css("display","block");
     }
     
     function closeSend(){
    	 $("#sendOrder").css("display","none");
     }
     
     function sendCheck(){
    	 var person=$("#assignedStorePeople").val();
    	 var phone=$("#assignedStorePeoplePhone").val();
    	 if(person=="" || phone==""){
    		 layer.alert('输入不能为空');
	         return false;
    	 }
    	 var integer1 = /^(0|86|17951)?(13[0-9]|15[012356789]|17[01678]|18[0-9]|14[57])[0-9]{8}$/; 
		 var integer2 = /^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
		 var name=/^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/;
		 
		 if(!integer1.test(phone)&&!integer2.test(phone)){
			 layer.alert('电话格式不正确，请输入正确的固定电话或手机号');
		         return false;
		 }
		 if(!name.test(person)){
			 layer.alert('姓名格式错误，请输入正确的姓名');
		         return false;
		 }
		 layer.open({
        	    content: "确认由' "+person+"，"+phone+"' 派送？"
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	        layer.close(index);
					 
				var index2= layer.load(1, {shade: [0.1,'#fff']}); 
    	    	var frm =document.forms[0];
    	    	setTimeout(function(){
    	    		 frm.submit();
     	   		 }, 1200);
        	    }
        	  });
     }
     
    
     
     
     
  
    </script>
</body>
</html>
