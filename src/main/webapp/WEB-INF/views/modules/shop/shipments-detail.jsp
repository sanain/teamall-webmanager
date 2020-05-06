<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},发货详情"/>
	<meta name="Keywords" content="${fns:getProjectName()},发货详情"/>
    <title>发货详情</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/shipments-detail.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/shipments-detail.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
        //根据不同的订单状态显示不同的内容
        $(function(){
            var orderStatus = '${ebOrder.status}';
            var shippingMethod = '${ebOrder.shippingMethod}';
            //订单状态：1、等待买家付款；2、等待发货；3、已发货,待收货；4、交易成功，已完成；5、已关闭；
            /** 运送方式：1快递、2EMS、3平邮 、4买家自提、5自营实体店送货上门*/
            //显示自提的未发货内容
            if(orderStatus == '2' && shippingMethod == '4'){
                $("#li-1").show();
            }
            //显示自提的等待收货内容
            if(orderStatus == '2' && shippingMethod == '5'){
                $("#li-3").show();
            }
            //显示外卖的未发货内容
            if(orderStatus == '3' && shippingMethod == '4'){
                $("#li-2").show();
            }
            //显示外卖的等待收货内容
            if(orderStatus == '3' && shippingMethod == '5'){
                $("#li-4").show();
            }

            //显示交易完成内容
            if(orderStatus == '4'){
                $("#li-5").show();
            }
            // $('.ul-tab li').click(function () {
            //     $(this).addClass('active').siblings().removeClass('active');
            //     var a=$(this).index();
            //     if (a==0){
            //         $('.li-1').show();
            //         $('.li-2').hide();
            //     }else if(a==1){
            //         $('.li-1').hide();
            //         $('.li-2').show();
            //     }
            // });
        })
        
           	
   	function wubtna(){
    	var expressNumber=$("#expressNumber").val();
    	if(expressNumber==""){
    		/*$("#expressNumber").css("border", "1px solid red")*/
    		 layer.open({content: "请填写运单编号!",skin: 'msg',time: 2 });
			return;
		}
    	  //询问框
    	  layer.open({
    	    content: '确定发货？'
    	    ,btn: ['确定', '取消']
    	    ,yes: function(index){
    	        layer.close(index);
    	    	var frm =document.forms[0];
    	   		frm.submit();
    	    }
    	  });
    	
    }
    	function send(){
    		//询问框
      	  layer.open({
      	    content: '确认发货？'
      	    ,btn: ['确定', '取消']
      	    ,yes: function(index){
      	        layer.close(index);
      	    	window.location.href="${ctxweb}/shop/PmShopOrders/orderedit?orderId=${ebOrder.orderId}";
      	    }
      	  });
      	
    	}
        
        
    </script>
</head>
<body>
    <div class="house">
        <p class="bu">确认收货信息及交易详情</p>

        <div class="house-list-body">
            <p>
                <span>订单编号：<a href="${ctxweb}/shop/PmShopOrders/orderDetail?orderId=${ebOrder.orderId}" target="tager">${ebOrder.orderNo}</a></span>
                <span>创建时间：<span><fmt:formatDate value="${ebOrder.createTime}" type="both"/></span></span>
                <span>买家：${fns:replaceMobile(ebOrder.mobile)}</span>
            </p>
            <ul class="list-left">
                <li>收货人：${ebOrder.acceptName}</li>
                <li>手机：${fns:replaceMobile(ebOrder.telphone)}</li>
            	<li>收货地址：${ebOrder.deliveryAddress}</li>
            </ul>
            <ul class="list-right">
                <li>发票抬头：${ebOrder.invoiceTitle}</li>
                <li>买家备注：${ebOrder.postscript}</li>
            </ul>
        </div>
        <div class="shop-mag">
            <ul class="mag-top">
                <li>商品ID</li>
                <li>商品图片</li>
                <li>商品名称</li>
                <li>价格</li>
                <li>商品数量</li>
            </ul>
          <c:forEach items="${ebOrder.ebOrderitems}" var="items">
            <ul class="mag-list">
                <li>${items.orderitemId}</li>
                <li>
                    <div class="img-kuang">
                        <c:choose>
			        		<c:when test="${empty items.productImg}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
			        		<c:when test="${items.productImg=='null'}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
			        		<c:otherwise><img src="${items.productImg}" alt=""></c:otherwise>
			        	</c:choose>
                    </div>
                </li>
                <li><input id="standardName" name="standardName" type="hidden" style="display:none;" value="${items.standardName}"/>
                    <span>${items.productName}</span>
                    <p >${items.standardName}</p>
                </li>
                <li>¥${items.realPrice}</li>
                <li>${items.goodsNums}</li>
            </ul>
          </c:forEach>
        </div>
        <p class="bu">发货方式</p>
        <div class="wu-liu">
            <ul class="ul-tab">
                <li class="active">${ebOrder.shippingMethod == 4 ? "自提":"外卖"}</li>
            </ul>
            <div class="div-tab">
            	<form class="form-horizontal" action="${ctxweb}/shop/PmShopOrders/orderedit" method="post" name="form2">
                    <input type="hidden" name="orderId" value="${ebOrder.orderId}"/>
                    <div id="li-1" style="display: none">
                        <ul>
                            <li><h5 style="font-weight: bold">未发货</h5></li>
                            <li>收件人名字：${ebOrder.acceptName}
                            联系方式：${ebOrder.telphone}</li>
                        </ul>
                        <%--<a class="btn btn-primary" href="javascript:;" onclick="wubtna();">确定</a>--%>
                        <input type="submit" value="确定" class="btn btn-primary">
                    </div>

                    <div id="li-2" style="display: none">
                        <ul id="shop-user-info">
                            <li><h5 style="font-weight: bold">未发货</h5></li>
                            <li><a class="btn btn-primary" href="javascript:;" onclick="chooseDeliveryStaff();">选择配送人员</a> </li>
                            <li>
                                <spand id="chooseId" style="display: none"></spand>
                                <span>配送人员名字：</span><input type="text" name="assignedStorePeople" id="assignedStorePeople">
                                <span style="padding-left: 100px">联系方式：</span><input type="text" name="assignedStorePeoplePhone" id="assignedStorePeoplePhone">
                            </li>
                        </ul>
                        <input type="submit" value="配送" class="btn btn-primary">
                    </div>

                    <div id="li-3" style="display: none">
                        <ul>
                            <li><h5 style="font-weight: bold">等待收货</h5></li>
                            <li>收件人名字：${ebOrder.acceptName}
                            <span style="padding-left: 100px">联系方式：</span>${ebOrder.telphone}</li>
                        </ul>
                        <input type="submit" value="已自提" class="btn btn-primary">
                    </div>

                    <div id="li-4" style="display: none">
                        <ul >
                            <li><h5 style="font-weight: bold">等待收货</h5></li>
                            <li>配送人员名字： ${ebOrder.assignedStorePeople}</li>
                            <li>配送人员联系方式： ${ebOrder.assignedStorePeoplePhone} </li>
                        </ul>
                        <input type="submit" value="送达" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
    </div>

<script type="text/javascript">
    $(function(){

    })
    //选择配送人员
    function chooseDeliveryStaff(){
        if($("#type3").val()!=""){
            layer.open({
                type: 2,
                title: '加料列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/PmShopOrders/chooseDeliveryStaff?chooseId='+$("#chooseId").text(),
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    if(content==""){
                        layer.msg("请先选中一名配送人员");
                        // $("#productChargingIds").val(content);
                    }else{
                        $("#assignedStorePeople").css("display","inline-block");
                        $("#assignedStorePeoplePhone").css("display","inline-block");

                        $("#chooseId").text(content.split(",")[0]);
                        $("#assignedStorePeople").val(content.split(",")[1]);
                        $("#assignedStorePeoplePhone").val(content.split(",")[2]);

                        layer.close(index);
                    }

                }
            });
        }
    }
</script>
</body>
</html>