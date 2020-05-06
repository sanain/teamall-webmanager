<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
    <title>销售信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-shop.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/refund-shop.js"></script>
    <style type="text/css">
    	.xcq{display:none;position:fixed;width:200px;height:150px;text-align:center;z-index:10000;background:#fff;top:50%;left:50%;margin-left:-100px;margin-top:-75px;border-radius: 5px;overflow:hidden;}
    	.xcq p{height:35px;line-height:35px;text-align:center;background:#f0f0f0;}
    	.xcq span{display:inline-block;margin:15px 0 20px 0;}
    	.xcq div{text-align:center;}
    	.xcq a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius: 5px;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
    $(function(){
       $('.xcq').hide();
       $('body').on('mouseover','.fu',function(){$(this).siblings('.kla').show()});
    	$('body').on('mouseout','.fu',function(){$(this).siblings('.kla').hide()});
    	//$('#my-selector').bind('click', function() {
    	$('body').on('click','#my-selector',function(){
		   // $(this).unbind('click');
		    $('.xcq').show();
		     location.href="${ctxsys}/Order/confirmReceipt?orderId=${ebOrder.orderId}&saleId=${aftersale.saleId}";
		});
		
		//$('#my-selector1').bind('click', function() {
		$('body').on('click','#my-selector1',function(){
		   // $(this).unbind('click');
		    $('.xcq').show();
		     window.location.href="${ctxsys}/Order/ReturnManagementAffirm?orderId=${ebOrder.orderId}&saleId=${aftersale.saleId}";
		})
		$('body').on('click','#my-selector3',function(){
		   // $(this).unbind('click');
		   var deposit = $("#deposit").val();
		   var maxDeposit = $("#maxDeposit").val();
		   var saleId = ${aftersale.saleId};
		   if(maxDeposit < deposit){
			   $('.consent1').hide();
			   alert("修改金额不能超过原本金额！");
			   return false;
		   }
			if(deposit < 0){
			   $('.consent1').hide();
			   alert("修改金额不能小于0！");
			   return false;
		   }
			var orderId = ${ebOrder.orderId};
			   $.ajax({
				   url : "${ctxsys}/Order/saveEbAftersale",
				   data : {
					   deposit : deposit,
					   saleId : saleId,
					   orderId : orderId
					},
					success : function(data) {
						if (data.code == "00") { //成功
							$('.xcq').show();
							location.reload();
						}
					},
			   });
		})
     })
     function messheg(){
	   //$('.xcq').hide();
	  }
    </script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin:0px">
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a class="active" href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}" style="border-bottom: 0px solid #69AC72;">订单退货处理</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
		  <li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">nc同步</a></li>
      </ul>
    <div class="xcq">
    <p>提示</p>
	<span class="message" data-tid="${messager}">提交成功</span>
	<div>
		<a href="javascript:;" onclick=" messheg()">ok</a> 
	</div>
</div>
  </div>
    <div class="order" style="background:white">
        <ul class="crumbs-ul">
        <c:choose>
        	<c:when test="${aftersale.refundStatus==1}">
	            <li>买家申请退款 >></li>
	            <li class="active">商家审核</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==2}">
	            <li>买家申请退款 >></li>
	            <li class="active">商家已拒绝</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==3}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li class="active">退款成功</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==4}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li>审核不通过 >></li>
	            <li class="active">退款关闭</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==5}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li class="active">待买家退货</li>
	            <li> >>商家收货 >></li>
	            <li>退款成功</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==6}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li>买家退货 >></li>
	            <li class="active">待商家收货</li>
	            <li> >>退款成功</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==7}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li>买家退货 >></li>
	            <li>商家收货 >></li>
	            <li class="active">待买家收款</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==8}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li>买家退货 >></li>
	            <li>商家收货 >></li>
	            <li class="active">待卖家退款</li>
	            <li> >>退款成功</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==9}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li class="active">平台介入</li>
            </c:when>
        </c:choose>
        </ul>
        <!--平台介入-->
        <c:if test="${aftersale.refundStatus==9}">
	        <c:if test="${returnGoodIntervene.interveneStatus<3}">
		        <div class="platform">
	            	<p><input id="updateTime" name="updateTime" type="hidden" value="${updateTime}"/>
		                <img src="${ctxStatic}/sbShop/images/record.png" alt="">
		                <span class="DD"></span>天
							${fns:getProjectName()}               <span class="HH"></span>小时
							${fns:getProjectName()}    <span class="mm"></span>分
	                </p>
		            <span>${fns:getProjectName()}平台客服已介入处理，请提交凭证。</span>
		            <span>您可以提交相关的证据，${fns:getProjectName()}平台客服会根据双方提交的证据公正地进行处理。</span>
		            <span>如果您逾期未提交凭证，证据不足可能会影响到处理的结果。</span>
		            <a href="${ctxweb}/shop/ReturnManagement/returnPlatform?saleId=${aftersale.saleId}" target="tager">提交凭证</a>
						${fns:getProjectName()}     </div>
			</c:if>
			<c:if test="${returnGoodIntervene.interveneStatus==3}">
				${fns:getProjectName()}       <div class="platform">
		            <span>${fns:getProjectName()}平台客服处理中。</span>
		            <span>请耐心等待${fns:getProjectName()}平台客服处理。</span>
		            <span>双方提交凭证后，${fns:getProjectName()}平台客服一般在3~5个工作日内完成处理。</span>
		        </div>
			</c:if>
			<c:if test="${returnGoodIntervene.interveneStatus==4}">
		        <div class="platform">
		            <span>${fns:getProjectName()}平台客服已完成处理。</span>
		            <span>处理结果：${returnGoodIntervene.treatmentResults}</span>
		            <span>判决理由：${returnGoodIntervene.judgmentReason}</span>
		        </div>
			</c:if>
        </c:if>
        <!--退款状态-->
        <div class="order-state">
        <c:choose>
        	<c:when test="${aftersale.refundStatus==1}">
            	<p><input id="updateTime" name="updateTime" type="hidden" value="${updateTime}"/>
	                <img src="${ctxStatic}/sbShop/images/record.png" alt="">
	                <span class="DD"></span>天
	                <span class="HH"></span>小时
	                <span class="mm"></span>分
                </p>
            </c:when>
            <c:when test="${aftersale.refundStatus==5}">
	            <p><input id="updateTime" name="updateTime" type="hidden" value="${updateTime}"/>您已同意退款申请，等待买家退货。</p>
	            <span>如买家在<b class="DD"></b>天<b class="HH"></b>小时<b class="mm"></b>分 内未退货，本次退款将自动关闭。</span>
            </c:when>
            <c:when test="${aftersale.refundStatus==6}">
            	<p><input id="updateTime" name="updateTime" type="hidden" value="${updateTime}"/>
	                <img src="${ctxStatic}/sbShop/images/record.png" alt="">
	                <span class="DD"></span>天
	                <span class="HH"></span>小时
	                <span class="mm"></span>分
                </p>
            </c:when>
            <c:when test="${aftersale.refundStatus==8}">
            	<p><input id="updateTime" name="updateTime" type="hidden" value="${updateTime}"/>
	                <img src="${ctxStatic}/sbShop/images/record.png" alt="">
	                <span class="DD"></span>天
	                <span class="HH"></span>小时
	                <span class="mm"></span>分
                </p>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
        <c:choose>
        	<c:when test="${aftersale.refundStatus==1}"><!--  退款状态：1、待卖家处理  -->
	            <span>请您及时处理退款申请，如果您逾期未处理，本次退款将自动达成。</span>
	            <div class="state-btn">
	            	<c:if test="${aftersale.applicationType==1}"><!-- 申请类型 1，退款 -->
	                	<a class="consent-a" href="javascript:;">同意</a>
	                </c:if>
	            	<c:if test="${aftersale.applicationType==0}"><!-- 申请类型 0，退货退款 -->
	                	<a class="consent-b" href="${ctxsys}/Order/saleOrderReturnGoodsAgree?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">同意</a>
	                </c:if>
	                <a href="${ctxsys}/Order/refundRefusejsp?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">拒绝</a>
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==2}"><!--  退款状态：2、卖家已拒绝  -->
	            <span>您拒绝了买家的退款申请</span>
	            <div class="state-btn">
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==3}"><!--  退款状态：3、退款成功  -->
            	<span>退款成功</span>
	            <div class="state-btn">
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==4}"><!--  退款状态：4、关闭退款  -->
            	<span>退款关闭</span>
	            <div class="state-btn">
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==6||aftersale.refundStatus==5}"><!--  退款状态：5、等待买家退货；6、等待卖家确认收货  -->
	            <div class="state-btn">
					<c:if test="${aftersale.returnGoodsMethod==1}"><!--  退货方式：1快递  -->
	                <a class="consent-a" href="javascript:;">确认收货</a>
					</c:if>
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	                <a href="${ctxweb}/shop/ReturnManagement/returnPlatform?saleId=${aftersale.saleId}" style="display:none">申请介入</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==7}"><!--  退款状态：7、等待买家确认收款  -->
            	<span>等待买家收款。</span>
	            <div class="state-btn">
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==8}"><!--  退款状态：8、等待卖家退款  -->
	            <span>等待商家退款。</span>
	            <div class="state-btn">
	            	<a class="consent-a" href="javascript:;">同意</a>
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==9}"><!--  退款状态：9、平台已介入处理  -->
	            <span>您已拒绝该退款申请，买家可修改申请后重新提交。</span>
	            <div class="state-btn">
	                <a href="${ctxsys}/Order/salesrecordlist?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">查看协商历史</a>
	            </div>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
        </div>
		
        <!--退款跟踪-->
        <div class="order-tail">
            <p>退款跟踪</p>
            <ul>
			<li style="width:20%">处理时间</li>
			<li style="width:80%">处理信息</li>
                
                <c:forEach items="${salesrecords}" var="salesrecord">
					<li style="width:20%"><fmt:formatDate value="${salesrecord.recordDate}" type="both"/></li>
	                <li style="width:80%">${salesrecord.recordName}》》${salesrecord.recordContent} <c:if test="${!empty salesrecord.imgList}">【图片信息】</c:if></li>
	                
	            </c:forEach>
            </ul>
        </div>
        <!--退货信息-->
        <c:if test="${(aftersale.refundStatus==6||aftersale.refundStatus==3||aftersale.refundStatus==4)&&(aftersale.applicationType!=1)}">
        <div class="ref-msg">
            <p>退货信息</p>
            <ul class="ref-ul1">
                <li><span>买家姓名：</span><span>${aftersale.userName}</span></li>
                <li><span>买家手机：</span><span>${aftersale.usermobile}</span></li>
                <li><span>物流公司：</span><span>${aftersale.logisticsCompany}</span></li>
                <li><span>运单号码：</span><span>${aftersale.trackCode}</span> <a href="http://www.kuaidi.com/chaxun?com=${aftersale.logisticsComCode}&nu=${aftersale.trackCode}">查看物流</a></li>
                <li><span>发货说明：</span><span>${aftersale.sendGoodsInstructions}</span></li>
            </ul>
            <ul class="shop-img">
                <c:forEach items="${aftersale.imgList}" var="img">
					<li><img src="${img}" alt=""></li>
				</c:forEach>
            </ul>
        </div>
        </c:if>
        <!--退款信息-->
        <input id="standardName" name="standardName" type="hidden" value="${aftersale.orderitem.standardName}"/>
        <div class="order-msg">
            <p>退款信息</p>
            <div class="list-div">
                <ul class="list-top">
                    <li>商品</li>
                    <li>商品属性</li>
                    <li>价格</li>
                    <li>商品数量</li>
                </ul>
                <ul class="list-body">
                    <li>
                        <div class="img-box">
                            <img src="${aftersale.orderitem.productImg}" alt="">
                        </div>
                        <u>${aftersale.orderitem.productName}
                         <p><c:if test="${ not empty aftersale.orderitem.standardName}">${aftersale.orderitem.standardName}</c:if></p>
                        </u>
                    </li>
                    <li class="standardName"></li>
                    <li>¥${aftersale.orderitem.realPrice}</li>
                    <li>x${aftersale.orderitem.goodsNums}</li>
                </ul>
            </div>
			<div style="white-space:nowrap;">
            <ul style="display:inline-block;width:40%">
                <li><span>退款编号：</span><span>${aftersale.saleNo}</span></li>
                <li><span>订单编号：</span><span>${aftersale.order.orderNo}</span></li>
                <li><span>退款原因：</span><span>${aftersale.travelingApplicants}</span></li>
                <c:choose>
	                <c:when test="${aftersale.refundStatus== 1 }">
	                	<input type="hidden" id="maxDeposit" value="${aftersale.maxDeposit}" />
	                	<li><span>退款金额：</span><span>¥<input type="number" id="deposit" name="deposit" min="0" max="${aftersale.deposit}" value="${aftersale.deposit}" />
	                	<c:if test="${!empty postage}">（不含运费¥${postage}）</c:if></span>
	                	<a class="consent-save" href="javascript:;">确定金额</a></li>
	                </c:when>
	                <c:otherwise>
	                	<li><span>退款金额：</span><span>¥${aftersale.deposit}<c:if test="${!empty postage}">（不含运费¥${postage}）</c:if></span>
	                	</li>
	                </c:otherwise>
                </c:choose>
                
                <li><span>退款类型：</span>
	                <span>
		                <c:if test="${aftersale.applicationType==0}">退货退款</c:if>
		                <c:if test="${aftersale.applicationType==1}">仅退款</c:if>
		                <%-- <c:if test="${aftersale.applicationType==2}"></c:if> --%>
	                </span>
                </li>
                <li><span>买家是否收到货：</span>
                <c:if test="${aftersale.takeStatus==0}">
                	<span>未发货</span>
                </c:if>
		        <c:if test="${aftersale.takeStatus==1}">
		        	<span>未收货</span>
		        </c:if>
		        <c:if test="${aftersale.takeStatus==2}">
		        	<span>已收货</span>
		        </c:if>
                </li>
                <li>
                	<span>退款途径：</span>
                	<span>
                		<c:if test="${aftersale.refundWay==1}">平台退款</c:if>
                		<c:if test="${aftersale.refundWay==2}">商家退款</c:if>
                	</span>
                </li>
                <li><span>退款说明：</span><span>${aftersale.refundExplain}</span></li>
                <li><span>申请时间：</span><span><fmt:formatDate value="${aftersale.applicationTime}" type="both"/></span></li>
                <li><span>退款成功时间：</span><span><fmt:formatDate value="${aftersale.updateTime}" type="both"/></span></li>
            </ul>
			 <ul style="display:inline-block;width:60%">

                <li><span>退货退款联系人：</span><span>${aftersale.returnGoodsPeople}</span></li>
                <li><span>退货退款联系人电话：</span><span>${aftersale.returnGoodsPeoplePhone}</span></li>
				<c:if test="${aftersale.takeStatus==2}">
				<li><span>退货方式：</span><span>

				<c:if test="${empty aftersale.returnGoodsMethod}">需指派上门取件</c:if>
				<c:if test="${aftersale.returnGoodsMethod==1}">快递</c:if>
                		<c:if test="${aftersale.returnGoodsMethod==2}">送至自提点</c:if>
						<c:if test="${aftersale.returnGoodsMethod==3}">门店上门取件</c:if>
				</span></li>
				</c:if>
				<c:if test="${aftersale.returnGoodsMethod==3||aftersale.returnGoodsMethod==1}">
                <li>
                	<span>上门取贷地址：</span>
                	<span>
                		${aftersale.address}
                	</span>
                </li>
				</c:if>
				<c:if test="${aftersale.returnGoodsMethod==2||aftersale.returnGoodsMethod==3}">
                <li><span>门店名字：</span><span>${aftersale.storeName}</span></li>
                <li><span>门店地址：</span>
	                <span>
		               ${aftersale.storeAddr}
	                </span>
                </li>
                <li><span>门店联系电话：</span>
                ${aftersale.storePhone}
                </li>
				</c:if>
				<c:if test="aftersale.returnGoodsMethod==1}">
				<li>
                	<span>物流公司：</span>
                	<span>
                		${aftersale.logisticsCompany}
                	</span>
                </li>
				<li>
                	<span>运单编号：</span>
                	<span>
                		${aftersale.trackCode}
                	</span>
                </li>
				<li>
                	<span>快递员：</span>
                	<span>
                		${aftersale.returnStorePeople}
                	</span>
                </li>
				<li>
                	<span>快递员电话：</span>
                	<span>
                		${aftersale.returnStorePeoplePhone}
                	</span>
                </li>
				<li>
                	<span>商品返货地址：</span>
                	<span>
                		${aftersale.returnGoodAddress}
                	</span>
                </li>
				<li>
                	<span>商品返货收货人姓名：</span>
                	<span>
                		${aftersale.consigneeName}
                	</span>
                </li>
				<li>
                	<span>商品返货收货人电话：</span>
                	<span>
                		${aftersale.consigneePhone}
                	</span>
                </li>
				<li>
                	<span>商品返货邮编号码：</span>
                	<span>
                		${aftersale.zipCode}
                	</span>
                </li>
				</c:if>
            </ul>
			</div>
            <c:if test="${!empty aftersale.imgList}">
            <ul class="shop-img">
            <c:forEach items="${aftersale.imgList}" var="img">
                <li><img class="fu"  src="${img}" alt=""><img class="kla" style="display:none;position:fixed;top:10%;left:30%;width:400px" alt="" src="${img}"  ></li>
            </c:forEach>
            </ul>
            </c:if>
        </div>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
            	<c:if test="${aftersale.refundStatus==1||aftersale.refundStatus==8}">
                	<span>同意退款？退款金额¥<b>${aftersale.deposit}</b>元<c:if test="${not empty postage}">（另加运费¥${postage}）</c:if></span>
                	<br>
                	<a id="my-selector1">确定</a>
                <a class="consent-del" href="javascript:;">取消</a>
                </c:if>
               	<c:if test="${aftersale.refundStatus==6||aftersale.refundStatus==5}">
                	<span>确认收货？</span>
                	<br>
                	
                	<a id="my-selector">确定</a>
                	<a class="consent-del" href="javascript:;">取消</a>
                </c:if>
            </div>
        </div>
	</div>
	
	<div class="consent1" style="display: none;">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
            	<span>同意修改退款金额吗？</span>
                	<br>
                	<a id="my-selector3">确定</a>
                <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
	</div>
</body>
</html>