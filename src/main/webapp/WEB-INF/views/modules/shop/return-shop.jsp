<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},退款详情-商家审核"/>
	<meta name="Keywords" content="${fns:getProjectName()},退款详情-商家审核"/>
	<title>退款详情-商家审核</title>
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

        a{
            color: #009688;
        }
        a:hover{
            color: rgb(120,120,120);
        }
        .crumbs-div a:hover{
            color: #009688;
        }

        .crumbs-ul li.active {
            color: #009688;
        }

        a:hover{
            color: rgb(120,120,120);
        }
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
    	$('body').one('click','#my-selector',function(){
		   // $(this).unbind('click');
		    $('.xcq').show();
		     location.href="${ctxweb}/shop/ReturnManagement/confirmReceipt?aftersaleid=${aftersale.saleId}";
		});
		
		//$('#my-selector1').bind('click', function() {
		$('body').one('click','#my-selector1',function(){
		   // $(this).unbind('click');
		    $('.xcq').show();
		     window.location.href="${ctxweb}/shop/ReturnManagement/ReturnManagementAffirm?aftersaleid=${aftersale.saleId}";
		})
     })
     function messheg(){
	   //$('.xcq').hide();
	  }
    </script>
    
</head>
<body>
<div class="xcq">
    <p>提示</p>
	<span class="message" data-tid="${messager}">提交成功</span>
	<div>
		<a href="javascript:;" onclick=" messheg()">ok</a> 
	</div>
</div>
    <div class="order">
        <div class="crumbs-div">
            <span>您的位置：</span>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">首页</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">退款管理</a>>
            <span>退款详情</span>
        </div>
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
	            <li>商家收货</li>
	            <li>退款成功</li>
            </c:when>
            <c:when test="${aftersale.refundStatus==6}">
	            <li>买家申请退款 >></li>
	            <li>商家审核 >></li>
	            <li>买家退货 >></li>
	            <li class="active">待商家收货</li>
	            <li>退款成功</li>
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
	            <li>退款成功</li>
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
			<c:if test="${eturnGoodIntervene.interveneStatus==3}">
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
	            <span>如买家在<b class="DD"></b>天<b class="HH"></b>小时<b class="mm"></b>分 未退货并填写退货信息，本次退款将自动关闭。</span>
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
        	<c:when test="${aftersale.refundStatus==1}">
	            <span>请您及时处理退款申请，如果您逾期未处理，本次退款将自动达成。</span>
	            <div class="state-btn">
	            	<c:if test="${aftersale.applicationType==1}">
	                	<a class="consent-a" href="javascript:;">同意</a>
	                </c:if>
	            	<c:if test="${aftersale.applicationType==0}">
	                	<a class="consent-b" href="${ctxweb}/shop/ReturnManagement/refundAgree?saleId=${aftersale.saleId}" target="tager">同意</a>
	                </c:if>
	                <a href="${ctxweb}/shop/ReturnManagement/refundRefusejsp?saleId=${aftersale.saleId}" target="tager">拒绝</a>
	                <a  href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==2}">
	            <span>您拒绝了买家的退款申请</span>
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==3}">
            	<span>退款成功</span>
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==4}">
            	<span>退款关闭</span>
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==5}">
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==6}">
	            <div class="state-btn">
	                <a class="consent-a" href="javascript:;">确认收货</a>
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	                <a href="${ctxweb}/shop/ReturnManagement/returnPlatform?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">申请介入</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==7}">
            	<span>等待买家收款。</span>
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==8}">
	            <span>等待商家退款。</span>
	            <div class="state-btn">
	            	<a class="consent-a" href="javascript:;">同意</a>
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:when test="${aftersale.refundStatus==9}">
	            <span>您已拒绝该退款申请，买家可修改申请后重新提交。</span>
	            <div class="state-btn">
	                <a href="${ctxweb}/shop/ReturnManagement/salesrecordlist?saleId=${aftersale.saleId}" target="tager" style="background-color: #393D49">查看协商历史</a>
	            </div>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
        </div>
        <!--退款跟踪-->
        <div class="order-tail">
            <p>退款跟踪</p>
            <ul>
                <li>处理信息</li>
                <li>处理时间</li>
                <c:forEach items="${salesrecords}" var="salesrecord">
	                <li>${salesrecord.recordName}</li>
	                <li><fmt:formatDate value="${salesrecord.recordDate}" type="both"/></li>
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
                <li><span>运单号码：</span><span>${aftersale.trackCode}</span> <a style="background-color: #393D49" href="http://www.kuaidi.com/chaxun?com=${aftersale.logisticsComCode}&nu=${aftersale.trackCode}">查看物流</a></li>
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
            <ul>
                <li><span>退款编号：</span><span>${aftersale.saleNo}</span></li>
                <li><span>订单编号：</span><span>${aftersale.order.orderNo}</span></li>
                <li><span>退款原因：</span><span>${aftersale.travelingApplicants}</span></li>
                <li><span>退款金额：</span><span>¥${aftersale.deposit}<c:if test="${!empty postage}">（含运费¥${postage}）</c:if></span></li>
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
                	<span>同意退款？退款金额¥<b>${aftersale.deposit}</b>元</span>
                	<br>
                	<a id="my-selector1">确定</a>
                <a class="consent-del" href="javascript:;">取消</a>
                </c:if>
               	<c:if test="${aftersale.refundStatus==6}">
                	<span>确认收货？</span>
                	<br>
                	
                	<a id="my-selector" <%-- href="${ctxweb}/shop/ReturnManagement/confirmReceipt?aftersaleid=${aftersale.saleId}" --%>>确定</a>
                	<a class="consent-del" href="javascript:;">取消</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>