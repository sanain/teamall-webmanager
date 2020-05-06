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
								<li><a href="${ctx}/userinfo/userregisterinfo" class="on"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo" ><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo" ><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo" ><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"  ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>


						</ul>
					</div>

					</div>

				</div>

                <div class="block_name mtt" style="margin:20px 0"> 
							
						
							<p class="">预约详情</p>
							<div class="brd"></div>
				</div>
				<div class="qrdoc ordsg">
						<div class="center">
							<div class="Fontsbar">
								<p>预约信息</p>
									<span>Reservation information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${registerrecordmsg.doctorname}</span>&nbsp;&nbsp;&nbsp;&nbsp;
											 <c:set var="doctype" value="${fnf:getDoctorTypeByid(doctormsg.doctortype)}"/> 
											 ${doctype.doctorTypeName}
											</p>
											<p>${hospitalsg.name}-${registerrecordmsg.departmentname}</p>
											<p>${dep.departaddr }</p>
											</div>
										</div>
										<div class="c">
										   <c:if test="${registerrecordmsg.sourcetimetype=='1'}">
											<p>预约挂号-<fmt:formatDate value="${registerrecordmsg.sourcedate}" pattern="MM月dd日"/>上午</p>
										   </c:if>
										   
										   <c:if test="${registerrecordmsg.sourcetimetype=='2'}">
											<p>预约挂号-<fmt:formatDate value="${registerrecordmsg.sourcedate}" pattern="MM月dd日"/>下午</p>
										   </c:if>
										   
										    <c:if test="${registerrecordmsg.sourcetimetype=='3'}">
											<p>预约挂号-<fmt:formatDate value="${registerrecordmsg.sourcedate}" pattern="MM月dd日"/>晚上</p>
										    </c:if>
										    
										</div>
										<div class="r">
											<span style="font-size: 12px;color: #65758B;position:relative;top:10px;">
											 <c:if test="${registerrecordmsg.postate==1 || registerrecordmsg.postate==2}">
											           预约编号：${registerrecordmsg.reservation}
											</c:if>
											<%-- <c:if test="${hospitalsg.hisInterfaceType ==1}">
										     	就诊编号：${registerrecordmsg.reservation}
											</c:if> --%>
											</span>
											</br>
											<span style="color: #FE824C;font-size: 30px;position:relative;top:15px;">¥${productordermsg.poallprice}0</span>
											
											 
										</div>
										
										<p class="med"  align="center">
												</br>
												 <c:if test="${registerrecordmsg.state != 10 && registerrecordmsg.postate==0}">
													  <span>
												      	 <h5> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
												      	  <%-- <a>未支付-</a><a href="${ctx}/userinfo/payTransmit?upId=${userHospital.upid}&poId=${productordermsg.poid}" style="color:#FF0000;">点击查看</a></h5> --%>
												      	  <a>未支付-</a><a href="${ctx}/userinfo/orderinfo?lookorder=${productordermsg.poid}" style="color:#FF0000;">点击查看</a></h5>
												    	
												      </span>
													 </c:if>
												</br>
												</br>
									
											 <c:if test="${registerrecordmsg.state==10}">
											  <span style="color:red;">
										      	       预约结果：${registerrecordmsg.backReason}
										      </span>
											 </c:if>
											 
									   </p>
						</div>
			      </div>	
				<div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>就诊人信息</p>
										<span>Patient information</span>
										</div>
										<p class="med">
										<span>姓名：${productordermsg.patientname}</span>
										    <c:if test="${registerrecordmsg.patientsex=='0'}">
											   <span>性别：女</span>
										    </c:if>
										       <c:if test="${registerrecordmsg.patientsex=='1'}">
											   <span>性别：男</span>
										    </c:if>
										      <c:if test="${registerrecordmsg.patientsex=='3'}">
											   <span>性别：未知</span>
										    </c:if>
										<%-- <span>年龄：${productordermsg.age}岁</span> --%>
										<span>身份证号：${registerrecordmsg.patientidcardno}</span>
										<span>手机号码：${registerrecordmsg.patienttelephone}</span>
										</p>
									</div>
				</div>	
		</div>



<script type="text/javascript">


$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})


</script>



</body>
</html>
