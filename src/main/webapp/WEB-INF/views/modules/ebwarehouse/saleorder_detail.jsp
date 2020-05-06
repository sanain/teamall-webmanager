<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>订单退款详情</title>
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
          <span> 当前退货状态: 	
		  <c:choose>
		  
        	<c:when test="${ebAftersale.refundStatus==1}">
	            买家申请退款 >><font color="green">商家审核</font>
            </c:when>
            <c:when test="${ebAftersale.refundStatus==2}">
	           买家申请退款 >> <font color="green">商家已拒绝</font>
            </c:when>
            <c:when test="${ebAftersale.refundStatus==3}">
	            买家申请退款 >>商家审核 >> <font color="green">退款成功</font>
            </c:when>
            <c:when test="${ebAftersale.refundStatus==4}">
	            买家申请退款 >>商家审核 >>审核不通过 >> <font color="green">退款关闭</font>
            </c:when>
            <c:when test="${ebAftersale.refundStatus==5}">
	            买家申请退款 >>商家审核 >>
				 <font color="green">待买家退货</font>
				 >>商家收货 >>退款成功
				 （
				    <c:choose>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2&& empty ebAftersale.assignedStoreOfferSelf }"><span style="color:green;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==2}"><span style="color:blue;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer == 1 }"><span style="color: green;">已取件</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer== 2 }"><span style="color:blue;">取件中</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && empty ebAftersale.assignedStoreOffer}"><span style="color:red;">未指派取件人</span></c:when>
				   </c:choose>
				 ）
            </c:when>
            <c:when test="${ebAftersale.refundStatus==6}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	             <font color="green">待商家收货</font>
	             >>退款成功
				 （
				    <c:choose>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2&& empty ebAftersale.assignedStoreOfferSelf }"><span style="color:green;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==2}"><span style="color:blue;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer == 1 }"><span style="color: green;">已取件</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer== 2 }"><span style="color:blue;">取件中</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && empty ebAftersale.assignedStoreOffer}"><span style="color:red;">未指派取件人</span></c:when>
				   </c:choose>
				 ）
            </c:when>
            <c:when test="${ebAftersale.refundStatus==7}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	            商家收货 >>
	             <font color="green">待买家收款</font>
				 （
				    <c:choose>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2&& empty ebAftersale.assignedStoreOfferSelf }"><span style="color:green;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==2}"><span style="color:blue;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer == 1 }"><span style="color: green;">已取件</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer== 2 }"><span style="color:blue;">取件中</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && empty ebAftersale.assignedStoreOffer}"><span style="color:red;">未指派取件人</span></c:when>
				   </c:choose>
				 ）
            </c:when>
            <c:when test="${ebAftersale.refundStatus==8}">
	            买家申请退款 >>
	            商家审核 >>
	            买家退货 >>
	            商家收货 >>
	            <font color="green">待卖家退款</font>
	            >>退款成功</li>
				（
				    <c:choose>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2&& empty ebAftersale.assignedStoreOfferSelf }"><span style="color:green;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==1 }"><span style="color:green;">买家已上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 2 && ebAftersale.assignedStoreOfferSelf==2}"><span style="color:blue;">等待上门退货</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer == 1 }"><span style="color: green;">已取件</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && ebAftersale.assignedStoreOffer== 2 }"><span style="color:blue;">取件中</span></c:when>
				   <c:when test="${ebAftersale.returnGoodsMethod == 3 && empty ebAftersale.assignedStoreOffer}"><span style="color:red;">未指派取件人</span></c:when>
				   </c:choose>
				 ）
            </c:when>
            <c:when test="${ebAftersale.refundStatus==9}">
	            买家申请退款 >>
	            商家审核 >>
	             <font color="green">平台介入</font>
            </c:when>
        </c:choose>
		  
			<c:if test="${(ebAftersale.refundStatus==5||ebAftersale.refundStatus==6)&&ebAftersale.returnGoodsMethod==2}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认收到退货 " onclick="sendhuo()"/>
			</c:if>
			<c:if test="${(ebAftersale.refundStatus==5||ebAftersale.refundStatus==6)&&ebAftersale.returnGoodsMethod==3&&empty ebAftersale.assignedStoreOffer}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="上门取件" onclick="sendbtn()"/>
			</c:if>
			<c:if test="${ebAftersale.returnGoodsMethod==2&&(ebAftersale.refundStatus==5||ebAftersale.refundStatus==6)&&ebAftersale.assignedStoreOfferSelf==2}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认买家自提" onclick="confirmOff()"/>
			</c:if>
			<c:if test="${ebAftersale.returnGoodsMethod==3&&(ebAftersale.refundStatus==5||ebAftersale.refundStatus==6)&&ebAftersale.assignedStoreOffer==2}">
			<input type="button" class="btn btn-primary" style="margin-left:10px" value="确认已取件" onclick="confirmSend()"/>
			</c:if>
			</span>
            </p>
        </div>
 
          <div class="order-tail" style="margin-top: 20px; display: none;" id="sendOrder">
          <p>指定上门取件人</p>
       <form class="form-horizontal" role="form" method="post" action="${ctxweb}/ebWarehouseItem/sendReturnStorePeople">
       <input type="hidden" name="saleId" value="${ebAftersale.saleId}" id="saleId">
	   <div class="form-group">
		<label for="firstname" class="col-sm-2 control-label">取件人姓名</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="returnStorePeople"  name="returnStorePeople"
				   placeholder="请输入取件人姓名" style="width:300px;">
		</div>
	</div>
	<div class="form-group">
		<label for="lastname" class="col-sm-2 control-label">取件人电话</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id=returnStorePeoplePhone name="returnStorePeoplePhone"
				   placeholder="请输入取件人电话" style="width:300px;">
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
            <p>退货跟踪</p>
            <ul>
                <li style="width:15%;margin-left:40px">处理信息</li>
                <li style="width:15%">处理时间</li>
            </ul>
            <c:if test="${not empty ebAftersale.applicationTime}">
            <ul>
                <li style="width:15%;margin-left:40px">申请退货时间</li>
                <li style="width:15%">${ebAftersale.applicationTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebAftersale.assignedOpTime}">
            <ul>
                <li style="width:15%;color:green;margin-left:40px">平台指派门店时间</li>
                <li style="width:15%;color:green">${ebAftersale.assignedOpTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebAftersale.returnStorePeopleTime}">
            <ul>
                <li style="width:15%;margin-left:40px">指定上门取件人时间</li>
                <li style="width:15%">${ebAftersale.returnStorePeopleTime}</li>
            </ul>
            </c:if> 
			<c:if test="${not empty ebAftersale.assignedStoreOfferTime}">
            <ul>
                <li style="width:15%;margin-left:40px">实体店确认已上门取件</li>
                <li style="width:15%">${ebAftersale.assignedStoreOfferTime}</li>
            </ul>
            </c:if> 
			<c:if test="${not empty ebAftersale.assignedStoreOfferSelfTime}">
            <ul>
                <li style="width:15%;margin-left:40px">买家上门退货时间</li>
                <li style="width:15%">${ebAftersale.assignedStoreOfferSelfTime}</li>
            </ul>
            </c:if> 
        </div>
          <!--订单信息-->
        <div class="order-msg">
            <p>退货信息</p>
			
            <ul>
                <li>退货客户信息</li>
                <li><span>退货客户名字：</span><span>
				${ebAftersale.returnGoodsPeople}
				</span></li>
                <li><span>地  &nbsp;&nbsp;址：</span><span><c:if test="${ebAftersale.returnGoodsMethod!=2}">
				 ${ebAftersale.address} 
				 </c:if>
				 <c:if test="${ebAftersale.returnGoodsMethod==2}">
				买家上门退货
				</c:if></span></li>
                <li><span>电  &nbsp;&nbsp;话：</span><span>
				${ebAftersale.returnGoodsPeoplePhone}
				</span></li>
            </ul>
			
             <ul>
                <li>退货方式</li>
                <li><span>退货方式：</span><span>
				<c:if test="${ebAftersale.returnGoodsMethod==3}">
				门店上门取货
				 </c:if>
				 <c:if test="${ebAftersale.returnGoodsMethod==2}">
				买家上门退货
				 </c:if>
				</span></li>
                 <li>
                 <span>备注：</span><span>${ebAftersale.returnRemark }</span>
                </li>
                <li>
                 <span>门店电话：</span><span>${ebWarehouseuser.ebWarehousePhone }</span>
                </li>
				<c:if test="${ebAftersale.returnGoodsMethod==3}">
                 <li>
                 <span>指定派送人：</span><span>${ebAftersale.returnStorePeople }</span>
                </li>
                 <li>
                 <span>派送人联系电话：</span><span>${ebAftersale.returnStorePeoplePhone }</span>
                </li>
                  </c:if>
            </ul>
            
        </div>
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
                <ul class="list-body">
                    <li>
                       ${ebAftersale.orderitem.orderitemId}
                    </li>
                    <li>
                        <div class="img-box">
                            <img src="${ebAftersale.orderitem.productImg}" alt="" style="width: 83px;height: 67px;">
                        </div>
                    </li>
                    <li>
                        	${ebAftersale.orderitem.productName}
                    </li>
                    <li>${ebAftersale.orderitem.standardName}</li>
                    <li>
                     	   ¥${ebAftersale.orderitem.realPrice}
                    </li>
                    <li>
                        ${ebAftersale.orderitem.goodsNums}
                    </li>
                    <li style="display:none">${ebAftersale.orderitem.returnRatio}%</li>
                </ul>
            </div>
        </div>
        <div class="text-center " style="margin-top: 20px;"> <input type="button"  class="btn btn-primary" value="返回" onclick="goback()"/></div>
  </div>
   <script type="text/javascript">
     function sendhuo(){
		 layer.open({
        	    content: "确认收到客户的退货？"
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	        layer.close(index);
        	     var frm =document.forms[0];
    	   	     	 frm.submit();
        	    }
        	  });
     }
     </script>
    <script type="text/javascript">
	function confirmSend(){
    	 layer.open({
     	    content: "确认用户已退货？"
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
    function takegoods(){//确认取件人已经取件
    		 var saleId=$("#saleId").val();
    	     $.ajax({
 			    url : "${ctxweb}/ebWarehouseItem/saletakegoods",   
 			    type : 'post',
 			    data:{
 			    	saleId:saleId
 					},
 					cache : false,
 			     success : function (data) {
 			     if(data.code=='00'){
 			        window.location.href="${ctxweb}/ebWarehouseItem/saleorderform?saleId="+data.saleId;
 			      }else{
 			    	 layer.alert(data.msg);
 			      }
 			    }
 	         });
    	 }
     
	</script>
    <script type="text/javascript">
    function goback(){
    	location.href="${ctxweb}/ebWarehouseItem/saleorderlist";
    }
     function sendbtn(){
    	 $("#sendOrder").css("display","block");
     }
     
     function closeSend(){
    	 $("#sendOrder").css("display","none");
     }
     
     function sendCheck(){
    	 var person=$("#returnStorePeople").val();
    	 var phone=$("#returnStorePeoplePhone").val();
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
        	    content: "确认由' "+person+"，"+phone+"' 上门取件？"
        	    ,btn: ['确定', '取消']
        	    ,yes: function(index){
        	        layer.close(index);
        	     var frm =document.forms[0];
    	   	     	 frm.submit();
        	    }
        	  });
     }
     
    
     
     
     
  
    </script>
</body>
</html>
