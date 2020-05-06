<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<body>
<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
							 <li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>  
								<li><a href="${ctx}/userinfo/orderinfo" class="on" ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								 <li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li> 

						</ul>
					</div>

					</div>

				</div>
				<div class="block_name mtt" style="margin:20px 0;"> 
							
							<span class="">MY ORDER</span>
							<p class="">我的订单</p>
							<div class="brd"></div>
				</div>
				    <c:if test="${!empty order.hospitalId}">
				    <c:set var="hosp" value="${fnf:getHospitalById(order.hospitalId)}"/>
				    </c:if>
				    <c:if test="${!empty order.departmentId}">
				    <c:set var="dep" value="${fnf:getDepartmentById(order.departmentId)}"/>
				    </c:if>
				    <c:if test="${!empty order.doctorId}">
				    <c:set var="doc" value="${fnf:getDoctorById(order.doctorId)}"/>
				    </c:if>
				   
				    <c:if test="${!empty order.userId}">
				    <c:set var="user" value="${fnf:getUserById(order.userId)}" />
				    </c:if>
				   
				   
				   
				 <div class="ordmsg">
						<div class="center">
							<div class="Fontsbar">
								<p>订单信息</p>
								<span>Order Message</span>
							</div>
							<div class="fonts">
								<p><b>订单类型：</b>
								   <c:if test="${order.potype==1}">
								       <span>医院产品订单</span>
								   </c:if>
								   <c:if test="${order.potype==2}">
								        <span>协医产品定单</span>
								   </c:if>
								   <c:if test="${order.potype==3}">
								        <span>挂号定单</span>
								   </c:if>
								   <c:if test="${order.potype==4}">
								        <span>问诊定单 </span>
								   </c:if>
								   <c:if test="${order.potype==5}">
								        <span>缴费订单</span>
								   </c:if>
								</p>
								<p><b>订单状态：</b>
								    <c:if test="${order.postate==0}">
								        <span>未支付-<a href="${ctx}/userinfo/payTransmit?upId=${userHospital.upid}&poId=${order.poid}">点击支付</a></span>
								    </c:if>
								    <c:if test="${order.postate==1}">
								        <span>支付成功</span>
								    </c:if>
								    <c:if test="${order.postate==8}">
								        <span>过期</span>
								    </c:if>
								    <c:if test="${order.postate==9}">
								        <span>取消</span>
								    </c:if>
								    <c:if test="${order.postate==10}">
								        <span>失败，请重新下订单</span>
								    </c:if>
							     </p>
								<p><b>订&nbsp;单&nbsp;号：</b><span>${order.pono}</span></p>
								<p><b>支付时间：</b><span><fmt:formatDate value="${order.popaytime}" pattern="yyyy-MM-dd"/></span>
								<span><fmt:formatDate value="${order.popaytimeend}" pattern="HH-mm-ss"/></span>
								</p>
								<p><b>支付方式：</b>
								    <c:if test="${order.popaytype==1}">
								     <span>银联</span>
								    </c:if>
								    <c:if test="${order.popaytype==2}">
								     <span>支付宝</span>
								    </c:if>
								    <c:if test="${order.popaytype==3}">
								     <span>现场支付</span>
								    </c:if>
								    <c:if test="${order.popaytype==4}">
								     <span>医保账户</span>
								    </c:if>
								    <c:if test="${order.popaytype==5}">
								     <span>微信</span>
								    </c:if>
								    <c:if test="${order.popaytype==6}">
								     <span>建行</span>
								    </c:if>
								    <c:if test="${order.popaytype==7}">
								     <span>中行</span>
								    </c:if>
								
								</p>
								
							</div>
						</div>
				</div>
				 <c:if test="${order.potype==3}">
				 <c:set var="register" value="${fnf:getRegisterRecordById(order.poid)}" />
				<div class="qrdoc ordsg">
		
									<div class="center">
										<div class="Fontsbar">
										<p>预约信息</p>
										<span>Reservation information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${doc.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;${doc.doctortypeobj.doctorTypeName}</p>
											<p>${hosp.name}</p>
											<p>${dep.name}</p>
											</div>
										</div>
										<div class="c">
										  <c:if test="${register.sourcetimetype==1}">
											<p>
											   预约挂号-<fmt:formatDate value="${register.sourcedate}" pattern="MM月dd日"/>上午
											</p>
										  </c:if>
										  <c:if test="${register.sourcetimetype==2}">
											<p>
											   预约挂号-<fmt:formatDate value="${register.sourcedate}" pattern="MM月dd日"/>下午
											</p>
										  </c:if>
										  <c:if test="${register.sourcetimetype==3}">
											<p>
											   预约挂号-<fmt:formatDate value="${register.sourcedate}" pattern="MM月dd日"/>晚上
											</p>
										  </c:if>
										</div>
										<div class="r">
											<p>￥${order.poallprice}</p>

										</div>


									</div>

				</div>	
				</c:if>
				<c:if test="${order.potype==4}">
				<c:set var="interrogation" value="${fnf:getInterroById(order.poid)}" />
                    <div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>咨询信息</p>
										<span>Medical information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${doc.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;${doc.doctortypeobj.doctorTypeName}</p>
											<p>${hosp.name}</p>
											<p>${dep.name}</p>
											</div>
										</div>
										<div class="c">
											<p>
											 <c:if test="${interrogation.interrogationtype==1}">
											     图文咨询
											 </c:if>
											 <c:if test="${interrogation.interrogationtype==2}">
											     电话咨询
											 </c:if>
											 <c:if test="${interrogation.interrogationtype==3}">
											     视频咨询
											 </c:if>
											 <c:if test="${interrogation.interrogationtype==10}">
											     免费咨询
											 </c:if>
											</p>
										</div>
										<div class="r">
											<p>￥${order.poallprice}元</p>
										</div>
									</div>
				</div>
				<div class="qrdoc ordsg">
				 <c:if test="${!empty order.poid}">
				    <c:set var="orderItem" value="${fnf:getOrderItemBypoid(order.poid)}" />
				    </c:if>
									<div class="center">
										<div class="Fontsbar">
										<p>检查信息</p>
										<span>Check information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p>${hosp.name}-${dep.name}</p>
											</div>
										</div>
										<div class="c">
										  <c:forEach items="${orderItem}" var="orderitem">
										  <p>
											  ${orderitem.poitemname}
											</p>
										  </c:forEach>
										</div>
										<div class="r">
											<p>￥${orderitem.poitemallamount}元</p>
										</div>
									</div>

				</div>
                </c:if>
                 <c:if test="${order.potype==5}">
                   <c:if test="${!empty order.objectid}">
				    <c:set var="hospitalFee" value="${fnf:getHospitalFeelByObjId(order.objectid)}" />
				     </c:if>
				      <c:if test="${!empty hospitalFee.feeid}">
				    <c:set var="hospitalFeeItem" value="${fnf:getHospitalFeeItemById(hospitalFee.feeid)}" />
				    </c:if>
                    <div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>处方信息</p>
										<span>Prescription information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${hosp.name}</span>-${dep.name}</p>
											</div>
										</div>
										<div class="c">
										  <c:forEach items="${hospitalFeeItem}" var="hosFeeitem">
											  <p class="Cname">名称：${hosFeeitem.feeitemname}</p>
											<p class="Cxq"><span>规格：${hosFeeitem.feeitemstandard}</span>
											<span>单位：${hosFeeitem.feeitemunit}</span>
											<span>数量：${hosFeeitem.feeitemnum}</span>
											<span>单价：${hosFeeitem.feeitemamount}</span>
										  </c:forEach>
										</div>
										<div class="r">
											<p>小计：￥${hospitalFee.settleamount}元</p>
										</div>
									</div>

				      </div>
                 </c:if>
				<div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>就诊人信息</p>
										<span>Patient information</span>
										</div>
										<p class="med">
										<span>姓名：${userhospitalmsg.patientname}</span>
										<c:if test="${userhospitalmsg.patientsex==1}">
										  <span>性别：男</span>
										</c:if>
										<c:if test="${userhospitalmsg.patientsex==0}">
										  <span>性别：女</span>
										</c:if>
										
										<span>年龄：${order.age}</span>
										<span>身份证号：${userhospitalmsg.patientidcardno}</span>
										<span>手机号码：${userhospitalmsg.patienttelephone}</span>
										</p>
									</div>
				</div>	
           
		</div>
		<div class="clear"></div>
		<div class="cd-popup" role="alert">
			<div class="cd-popup-container">
				<p>确认要退号码</p>
				<ul class="cd-buttons">
					<li><a href="" class="yes">Yes</a></li>
					<li><a href="" class="no">No</a></li>
				</ul>
				<a href="#0" class="cd-popup-close img-replace">Close</a>
			</div> <!-- cd-popup-container -->
		</div> <!-- cd-popup -->
		
<script type="text/javascript">

function sumbis(){

		

}


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")

		})
})

$.fn.Mtanc = function (){ 

	$(this).on('click', function(event){
		event.preventDefault();
		$('.cd-popup').addClass('is-visible');
	});
	
	//close popup
	$('.cd-popup').on('click', function(event){
		if( $(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup') ) {
			event.preventDefault();
			$(this).removeClass('is-visible');
			return false;
		}
	});
	//close popup when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$('.cd-popup').removeClass('is-visible');
    		return false;
	    }
});


}

$("a.tuihao").Mtanc()

</script>



</body>
</html>