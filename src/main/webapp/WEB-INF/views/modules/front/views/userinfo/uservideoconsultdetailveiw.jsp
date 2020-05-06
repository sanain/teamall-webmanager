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
								<li><a href="${ctx}/userinfo/userregisterinfo" ><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo" class="on"><img src=""><p>我的咨询</p></a></li>
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
				<div class="block_name mtt" style="margin:20px 0;"> 
							
							
							<p class="">咨询详情</p>
							<div class="brd"></div>
				</div>
				<div class="qrdoc ordsg">

									
									<div class="center">
										<div class="Fontsbar">
										<p>医生信息</p>
										<span>Reservation information</span>
										</div>
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${userinterrogationmsg.doctor.name}</span>
											&nbsp;&nbsp;&nbsp;&nbsp;
									     	<c:set var="type" value="${fnf:getDoctorTypeByid(userinterrogationmsg.doctor.doctortype)}" />  
											${type.doctorTypeName}
											 </p>
											<p>${userinterrogationmsg.doctor.department.hospital.name}</p>
											<p>${userinterrogationmsg.doctor.department.name}</p>
											</div>
										</div>
										<div class="c">
											<p>咨询开始时间:<fmt:formatDate value="${userinterrogationmsg.starttime}" pattern="yyyy-MM-dd"/></p>
											<p><fmt:formatDate value="${userinterrogationmsg.starttime}" pattern="HH:mm"/></p>
										</div>
										<div class="r">
											<p>¥${userinterrogationmsg.currentprice}元</p>
										</div>
									</div>
				</div>	
				 <c:if test="${empty userinterrogationmsg or empty userinterrogationmsg.name}">
                 		
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
                 </c:if>
                 				<c:if test="${not empty userinterrogationmsg and not empty userinterrogationmsg.name}">
						<div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>就诊人信息</p>
										<span>Patient information</span>
										</div>
										<p class="med">
										<span>姓名：${userinterrogationmsg.name}</span>
										<span>性别：${userinterrogationmsg.sex=='0'?'女':'男'}</span>
										<span>年龄：${userinterrogationmsg.age}</span>
										<span>身份证号：${userinterrogationmsg.idcard}</span>
										</p>
										<p class="med">
										<span>婚姻情况：
											<c:choose>
												<c:when test="${userinterrogationmsg.maritalStats=='0'}">
													未知
												</c:when>
												<c:when test="${userinterrogationmsg.maritalStats=='1'}">
													未婚
												</c:when>
												<c:when test="${userinterrogationmsg.maritalStats=='2'}">
													已婚
												</c:when>
												<c:when test="${userinterrogationmsg.maritalStats=='3'}">
													离异
												</c:when>
												<c:otherwise>
													未知
												</c:otherwise>
											</c:choose>
										</span>
										<span id="race"></span>
										<span>手机号码：${userinterrogationmsg.phone}</span>
										<span>职业：${userinterrogationmsg.occupation}</span>
										<span>教育程度：${userinterrogationmsg.educational}</span>
										</p>
										<p class="med">
											<span>服务机构：${userinterrogationmsg.service}</span>
											<span>住址：${userinterrogationmsg.addr}</span>
											<span>咨询日期：${userinterrogationmsg.askDate}</span>
										</p>
									</div>
						</div>	
				
				
						<div class="qrdoc ordsg">
									<div class="center">
										<div class="Fontsbar">
										<p>主观资料</p>
										<span>Patient information</span>
										</div>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >主诉：${userinterrogationmsg.subComplaint}</span>
										</p>
										<br/>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >现病史：${userinterrogationmsg.subThisDisease}</span>
										</p>
										<br/>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >既往史：${userinterrogationmsg.subBeforeDisease}</span>
										</p>
										<br/>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >食物药物过敏史：${userinterrogationmsg.subFoodDisease}</span>
										</p>
										<br/>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >个人婚育史：${userinterrogationmsg.subPersonalDisease}</span>
										</p>
										<br/>
										<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
											<span >家族史：${userinterrogationmsg.subFamilyDisease}</span>
										</p>
										
									</div>
				</div>	
					<div class="qrdoc ordsg">
						<div class="center">
							<div class="Fontsbar">
							<p>客观资料</p>
							<span>OBJECTIVE</span>
							</div>
							<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
								<span >体格检查：${userinterrogationmsg.objHealthCheck}</span>
							</p>
							<br/>
							<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
								<span >辅助检查：${userinterrogationmsg.objAuxCheck}</span>
							</p>
						</div>
				    </div>	
				    
				    <div class="qrdoc ordsg">
						<div class="center">
							<div class="Fontsbar">
							<p>评估</p>
							<span>ASSESSMENT</span>
							</div>
							<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
								<span >初步诊断：${userinterrogationmsg.assFirstDiagnosis}</span>
							</p>
						</div>
				    </div>	
				    
				    <div class="qrdoc ordsg">
						<div class="center">
							<div class="Fontsbar">
							<p>计划</p>
							<span>PLAN</span>
							</div>
							<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
								<span >处理建议：${userinterrogationmsg.planProposal}</span>
							</p>
							<br/>
							<p class="med" style="text-align:left;padding-left:15px;padding-right:5px;">
								<span >健康干预：${userinterrogationmsg.planHealthy}</span>
							</p>
						</div>
				    </div>	
				
				</c:if>				
                 
				
				
				
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
